# Weatheraza
![seasonal-image](https://github.com/JasonPKnoll/weatheraza/blob/main/app/assets/images/seasonal.jpeg)

## Overview
Welcome to Weatheraza! This Ruby on Rails API application helps plan road trips. This app will allow users to see the current weather as well as the forecasted weather at the destination.

In this service-oriented architecture, the (theoretical) front-end team will communicate with this back-end application through an API. Weatheraza exposes the API that satisfies the front-end team’s requirements.

Weatheraza consumes the MapQuest Developer API, the Open Weather Map API, the Unsplash API, and the Open Library API then aggregates their data. This app also exposes an API that requires an authentication token, exposes an API for CRUD functionality, and structures responses that are JSON API 1.0 Compliant.

## Table of Contents
- [Technologies](#technologies)
- [System Dependencies](#system-dependencies)
- [Configuration](#configuration)
- [Database Creation](#database-creation)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
<!-- - [Screenshots](#screenshots) -->
- [Endpoints](#endpoints)
  - [Retrieve Weather for a City](#retrieve-weather-for-a-city)
  - [Background Image for a City](#background-image-for-a-city)
  - [Book Search](#book-search)
  - [User Registration](#user-registration)
  - [Login](#login)
  - [Road Trip](#road-trip)

## Technologies
|Development|Development|Testing
|--- |--- |--- |
|[Rails 5.2.6](https://rubygems.org/gems/rails/versions/5.2.6)|[Git](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)|[RSpec for Rails](https://github.com/rspec/rspec-rails)
|[Ruby 2.7.2](https://www.ruby-lang.org/en/downloads/)|[Github](https://desktop.github.com/)|[Capybara](https://github.com/teamcapybara/capybara)
|[Pry](https://rubygems.org/gems/pry/versions/0.10.3)|[FastJSONApi](https://github.com/Netflix/fast_jsonapi)|[Webmock](https://github.com/bblimke/webmock)
|[PostgresQL](https://www.postgresql.org/)|[BCrypt](https://github.com/bcrypt-ruby/bcrypt-ruby)|[VCR](https://github.com/vcr/vcr)
|[Faraday](https://github.com/lostisland/faraday)|[Rubocop](https://rubygems.org/gems/rubocop/versions/0.39.0)|[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)|[Figaro](https://github.com/laserlemon/figaro)|[Atom](https://atom.io/)|[Postman](https://www.postman.com/product/rest-client/)
|||[SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)

## System Dependencies
You will need to sign up for the MapQuest Developer, Open Weather Map, and Unsplash api keys.

- [MapQuest Developer API](https://developer.mapquest.com/documentation/)
  - [Sign up for an account with MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
  - Then, [get your key here](https://developer.mapquest.com/user/me/apps) then select `Create a New Key` and fill in required fields.
- [Open Weather Map API](https://openweathermap.org/api)
  - [Sign up](https://home.openweathermap.org/users/sign_up)
  - Go to [your API keys](https://home.openweathermap.org/api_keys), fill in API key name, and select `Generate`.
- [Unsplash API ](https://unsplash.com/documentation)
  - First, login or [join](https://unsplash.com/join)
  - Then register your application. Go to [your apps](https://unsplash.com/oauth/applications), click `New Application`, and fill in the required details.
  - NOTE: All applications must follow the [API Guidelines](https://help.unsplash.com/en/articles/2511245-unsplash-api-guidelines), including [properly providing attribution for the photographer and Unsplash](https://help.unsplash.com/en/articles/2511315-guideline-attribution).
- [Open Library API](https://openlibrary.org/dev/docs/api/search)
  - No authorization key required
  
## Configuration
  - Clone this repo
  - Run `bundle`
  - Run `bundle exec figaro install`
  - Open your `config/application.yml` file in your code editor (You may have to open it manually). Then, add to the bottom of the `config/application.yml` file **your** api keys:
```
open_weather_key: <your_open_weather_api_key>
map_quest_key: <your_mapquest_api_key>
unsplash_key: <your_unsplash_api_key>
```

## Database Creation
  - Run `rails db:{create,migrate}`

## How to Run the Test Suite
### RSpec:
- Delete spec/fixtures/vcr_cassettes, then run `bundle exec rspec`
### Postman:
- In Terminal, run `rails s`
- In Postman, set appropriate HTTP verb, append endpoint URI to `http://localhost:3000/`, and select `SEND`.
- NOTE: For `post` requests, send a JSON payload in the body of the request in Postman. Under the address bar, click on `Body`, select `raw`, and from the dropdown that probably says `Text` in it, choose `JSON`.

## Endpoints

### Retrieve Weather for a City
#### Request
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
#### 200 Response
```

```

<hr>

### Background Image for a City
#### Request
```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```
#### 200 Response
```

```

<hr>

### Book Search
#### Request
```
GET /api/v1/book-search?location=denver,co&quantity=5
```
#### Response
```

```

<hr>

### User Registration
#### Request
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "sample@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```
#### 200 Response
```
```
<hr>

### Login
#### Request
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "sample@email.com",
  "password": "password"
}
```
#### 200 Response
```

```

<hr>

### Road Trip
#### Request
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "4DA6ZiJNWfctA4CDHaR4qAtt"
}
```
#### 200 Response
```

```
