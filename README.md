# _Home Garden Project - Joe Mecha_
![logo](lib/images/pexels-engin-akyurt-1435904.jpg "Variety of vegetables")
<!-- ![logo](lib/images/garden_logo.png "Home Garden logo") -->

## About
Home Garden Project is a RESTful back-end API which exposes data on Gardens, Locations within gardens (e.g. separate raised beds), Crops, and Days-to-Maturity. 


## Table of contents
[**Developer Notes**](#developer-notes) |
[**Stretch Goals**](#stretch-goals) |
[**Versions**](#versions) |
[**Setup**](#setup) |
<!-- [**Project Design**](#project-design) | -->
[**Endpoints**](#endpoints) |
[**Examples**](#examples) |
[**Tests**](#running-the-tests) |
[**About Me**](#about-me) |


## Technical Notes

  - `The database design` is a simple __one-to-many__ relationship between Garden & Locations, and for Locations & Crops.
  
  <!-- - `Testing` request tests include happy and sad paths, and are be included in a __postman collection__ (Note: to be added) -->

  - `Authentication` is achieved using Devise and JWT (JSON Web Token). The non-RESTful routes for signup, login, logout were added to manage users and their access to the API. It requires the following steps:
    1. Create (signup) a user
    2. Login to authenticate and generate a token
    3. Logout causes the token to be revoked

  - Geocoder and the Timezone gem are leveraged to provide seamless time zone detection for users and ensures precise data about crop harvest timing based on their geographic location. Geocoder simplifies the process by converting user-provided zip codes into latitude and longitude coordinates, while the Timezone gem leverages Geonames to accurately identify time zones based on the obtained coordinates.


## Development Notes:

2023-08-04:
2023-08-03:
Authentication moved to using Devise and JWT, and requirement to include an API key in all requests has been removed; all request tests updated

2023-08-01:
Completed code to calculate and serialize "days remaining until harvest"

Index, Show, Create are complete for Garden, Location, and Crop

Test coverage is 100%

Next steps:
0. Create a seed file to generate sample data
1. ~~Implement devise gem for authentication~~
2. Create API documentation through a Postman collection and/or Swagger
    2b. Consider serializing related models (e.g. a crop's location)
3. Consume a relevant 3rd party API
4. Add one or more queries for Garden-level data
5. Add update and destroy actions where needed
6. Implement caching where possible
7. Build out notes CRUD functionality
8. Diagram the app


## Versions

* Rails 7.0.6
* Ruby  3.2.2


## Setup
  1. Get a copy of this repository
  2. Install gem packages by running `bundle`
  3. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`
  4. Set up Geocoder with MapQuest
    A. Sign up for a MapQuest API key:
    B. Go to the MapQuest Developer Portal (https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
    C. Create an account or log in if you already have one.
    D. Create a new application to obtain an API key.
    E. Create a new file .env in the main app directory. Add ```MAPQUEST_API_KEY=<your_api_key>``````
  5. Set up Timezone gem with Geonames
    A. Sign up for a Geonames username - go to the Geonames website (https://www.geonames.org/login) and sign up for a free account.
    B. Enable Geonames web services - after logging in, go to https://www.geonames.org/manageaccount and ensure that the "Free Web Services" option is checked.
    C. Add ```YOUR_GEONAMES_USERNAME=<your_geonames_username>``` to your .env file

  6. Run command `rails routes` to view available routes
  7. Run command `rails s` and navigate to http://localhost:3000 to consume API endpoints below
  <!-- 8. If using `Postman`, please use the __collection__ included in this respository (home_garden_api.postman.json)

<!-- ## Project Design
![Diagram](lib/images/Home_Garden_API_diagram.jpeg "Project Design") -->


## Endpoints

WIP

The following are all API endpoints. Note, some endpoints have optional or required query parameters.

~ All endpoints run off base connector http://localhost:3000 ~ 

__For endpoints other than create new user, send the api_key in the request body or as a query param. Examples:__
```
{
    "api_key": "a02a9fc29934a6c173aa924961403005"
}
```
```
/api/v0/gardens?api_key=a02a9fc29934a6c173aa924961403005
```

### 0 Create new user:
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `POST`    | `/api/v0/users`     | Register new user and receive API KEY  |


### 1 Retrieve all gardens:
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/gardens`     | Retrieve all gardens  |

### 2 Retrieve one garden:
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/gardens/:id`     | Retrieve a single garden  |


### 3 Retrieve all locations for a garden:
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/gardens/:garden_id/locations`     | Retrieve all locations for a single garden  |

### 4 Retrieve one location for a garden:
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/gardens/:garden_id/locations/:id`     | Retrieve one location for a single garden  |

### 5 Retrieve all crops for a location
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/locations/:location_id/crops`     | Retrieve all crops for one location  |

### 6 Retrieve data for one crop for a location
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/locations/:location_id/crops/:id`     | Retrieve one crop for a single location  |


## Examples

#### 0 - Create new user
_Request_
POST /signup
Content-Type: application/json
Accept: application/json

```json
{
  "name": "Josh",
  "email": "testtesttest@test.com",
  "password": "mypassword",
}
```
_Response_
```
{
    "status": {
        "code": 200,
        "message": "Signed up successfully."
    },
    "data": {
        "id": 1,
        "name": "Josh",
        "email": "testtesttest@test.com"
    }
}
```


#### 0 - Login
_Request_
POST /login
Content-Type: application/json
Accept: application/json

```json
{
  "email": "testtesttest@test.com",
  "password": "mypassword"
}
```
_Response_
```json
{
    "status": {
        "code": 200,
        "message": "Logged in successfully.",
        "data": {
            "user": {
                "id": 1,
                "name": "Josh",
                "email": "testtesttest@test.com"
            }
        }
    }
}
```

#### 1 - View all gardens:

status: 200
body:
```json
{
    "data": [
        {
            "id": "1",
            "type": "garden",
            "attributes": {
                "name": "Vegetable Garden",
                "size": "25.0"
            }
        },
        {
            "id": "2",
            "type": "garden",
            "attributes": {
                "name": "Sweet Corn Garden",
                "size": "30.5"
            }
        }
    ]
}
```


#### 2 - Retrieve Garded with ID 2:

status: 200
body:
```json

{
    "data": {
        "id": "2",
        "type": "garden",
        "attributes": {
            "name": "Sweet Corn Garden",
                "size": "30.5"
        }
    }
}
```

#### 2b - No garden for given ID (555):

status: 404
body:
```json

{
    "errors": "Can't find garden with ID 555"
}
```


#### 3 - Retrieve all locations for garden 1:

status: 200
body:
```json
{
    "data": [
        {
            "id": "1",
            "type": "location",
            "attributes": {
                "name": "Back Yard",
                "size": "20.0",
                "irrigated": "true"
            }
        },
        {
            "id": "2",
            "type": "location",
            "attributes": {
                "name": "Patio Planter Box",
                "size": "5.0",
                "irrigated": "false"
            }
        } 
    ]
}
```


#### 3b - No locations for garden:

status: 200
body:
```json
{
    "message": "There are no locations associated with this garden"
}
```


#### 4 - Retrieve location 2 for garden 1:

status: 200
body:
```json
{
    "data": {
        "id": "2",
        "type": "location",
        "attributes": {
            "name": "Patio Planter Box",
            "size": "5.0",
            "irrigated": "false"
        }
    }
}
```

#### 4b - No location with ID 55 for garden 1:

status: 404
body:
```json

{
    "errors": "Can't find location with ID 55"
}
```



## Running the Tests

Run all tests for the application with `bundle exec rspec`.


## Developer
### Joe Mecha  [GitHub](https://github.com/joemecha) • [LinkedIn](https://www.linkedin.com/in/joemecha/)
