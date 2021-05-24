class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # enables rememberable option 
  include Devise::Controllers::Rememberable

  def google_oauth2
    # all information retrieved from Google by OmniAuth is available 
    # as a hash at request.env["omniauth.auth"]
    
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
      remember_me(@user) # remembers user for 2 minutes 
      # event: :authentication causes Warden(underlying Devise) to trigger 
      # any callbacks defined with Warden::Manager.after_authentication block
      # pretty useful, ex. store additional data about user behaviour 
    else # if something went wrong 
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end