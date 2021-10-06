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
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-10-06T07:48:22.000Z",
                "sunrise": "2021-10-06T13:01:10.000Z",
                "sunset": "2021-10-07T00:34:27.000Z",
                "temperature": 59.92,
                "feels_like": 57.4,
                "humidity": 38,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01n"
            },
            "daily_weather": [
                {
                    "date": "2021-10-06T18:00:00.000Z",
                    "sunrise": "2021-10-06T13:01:10.000Z",
                    "sunset": "2021-10-07T00:34:27.000Z",
                    "max_temp": 79.48,
                    "min_temp": 59.4,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-10-07T18:00:00.000Z",
                    "sunrise": "2021-10-07T13:02:10.000Z",
                    "sunset": "2021-10-08T00:32:52.000Z",
                    "max_temp": 79.45,
                    "min_temp": 60.17,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "date": "2021-10-08T18:00:00.000Z",
                    "sunrise": "2021-10-08T13:03:09.000Z",
                    "sunset": "2021-10-09T00:31:18.000Z",
                    "max_temp": 78.55,
                    "min_temp": 61.09,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-10-09T18:00:00.000Z",
                    "sunrise": "2021-10-09T13:04:09.000Z",
                    "sunset": "2021-10-10T00:29:45.000Z",
                    "max_temp": 74.28,
                    "min_temp": 58.44,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {
                    "date": "2021-10-10T18:00:00.000Z",
                    "sunrise": "2021-10-10T13:05:10.000Z",
                    "sunset": "2021-10-11T00:28:12.000Z",
                    "max_temp": 64.89,
                    "min_temp": 51.1,
                    "conditions": "light rain",
                    "icon": "10d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "07:00",
                    "temperature": 60.82,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "08:00",
                    "temperature": 59.92,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "09:00",
                    "temperature": 60.49,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "10:00",
                    "temperature": 60.55,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "11:00",
                    "temperature": 60.33,
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "12:00",
                    "temperature": 59.9,
                    "conditions": "few clouds",
                    "icon": "02n"
                },
                {
                    "time": "13:00",
                    "temperature": 59.4,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "14:00",
                    "temperature": 60.49,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                }
            ]
        }
    }
}
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
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "full_image": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=srgb&fm=jpg&ixid=MnwyNjI5Mzh8MHwxfHNlYXJjaHwxfHxEZW52ZXIlMkMlMjBDT3xlbnwxfHx8fDE2MzM1MDY1OTE&ixlib=rb-1.2.1&q=85",
                "regular_image": "https://images.unsplash.com/photo-1619856699906-09e1f58c98b1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNjI5Mzh8MHwxfHNlYXJjaHwxfHxEZW52ZXIlMkMlMjBDT3xlbnwxfHx8fDE2MzM1MDY1OTE&ixlib=rb-1.2.1&q=80&w=1080",
                "description": "Night Time Downtown Denver",
                "author": "Ryan De Hamer"
            }
        }
    }
}
```

<hr>

### Book Search
#### Request
```
GET /api/v1/book-search?location=denver,co&quantity=5
```
#### Response
```
{
    "data": {
        "id": null,
        "type": "books",
        "attributes": {
            "destination": "denver,co",
            "forecast": {
                "summary": "clear sky",
                "temperature": 59.99
            },
            "total_books_found": 35991,
            "books": [
                {
                    "isbn": [
                        "9780762507849",
                        "0762507845"
                    ],
                    "title": "Denver, Co",
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "isbn": [
                        "1427401683",
                        "9781427401687"
                    ],
                    "title": "University of Denver Co 2007",
                    "publisher": [
                        "College Prowler"
                    ]
                },
                {
                    "isbn": [
                        "9780762557363",
                        "0762557362"
                    ],
                    "title": "Denver Co Deluxe Flip Map",
                    "publisher": [
                        "Universal Map Enterprises"
                    ]
                },
                {
                    "isbn": [
                        "9780883183663",
                        "0883183668"
                    ],
                    "title": "Photovoltaic safety, Denver, CO, 1988",
                    "publisher": [
                        "American Institute of Physics"
                    ]
                },
                {
                    "isbn": [
                        "9812582622",
                        "9789812582621"
                    ],
                    "title": "Insight Fleximap Denver, CO (Insight Fleximaps)",
                    "publisher": [
                        "American Map Corporation"
                    ]
                }
            ]
        }
    }
}
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
#### 201 Response
```
{
    "data": {
        "id": "12",
        "type": "user",
        "attributes": {
            "email": "sample@email.com",
            "api_key": "3gqwatyJXtcq1ByajjdjkAtt"
        }
    }
}
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
{
    "data": {
        "id": "12",
        "type": "user",
        "attributes": {
            "email": "sample@email.com",
            "api_key": "3gqwatyJXtcq1ByajjdjkAtt"
        }
    }
}

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
  "api_key": "3gqwatyJXtcq1ByajjdjkAtt"
}
```
#### 201 Response
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01:44:22",
            "weather_at_eta": {
                "temperature": 56.7,
                "conditions": "clear sky"
            }
        }
    }
}
```
