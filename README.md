# Travel diary 

## Table of contents
* [Introduction](#introduction)
* [Technologies](#technologies)
* [Setup](#setup)
* [Tests](#tests)

## Introduction

This simple app allows you to quickly add/edit/delete short notes. When you type valid city Travel diary will make API call to external app - WeatherAPI and then attach the current temperature in that city to your note. Travel diary uses jquery to make views more responsive. Currently, you can only log in thorough google. Travel diary is also [in production]()
## Technologies:

* Ruby 2.7.0
* Rails 6.0.3.7
* Postgresql 1.2.3
* jquery-rails 4.4.0

## Setup

Fork respository and ensure you have postgresql installed.Then run:

```
$ rake db:create db:migrate 
```

## Tests 

Soon will come.

