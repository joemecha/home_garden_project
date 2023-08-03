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


## Developer Notes

  - `The database design` is a __one-to-many__ relationship between Garden & Locations, and for Locations & Crops.

  
  - `Testing` request tests include happy and sad paths, and are be included in a __postman collection__ (Note: to be added)

  - `Authentication` is achieved using Devise and JWT (JSON Web Token). It requires the following steps:
    1. Create (signup) a user
    2. Sign in to authenticate and generate a token
    3. Sign out causes the token to be revoked


## Stretch Goals:

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
  4. Run command `rails routes` to view available routes
  5. Run command `rails s` and navigate to http://localhost:3000 to consume API endpoints below
  <!-- 6. If using `Postman`, please use the __collection__ included in this respository (home_garden_api.postman.json)
  7. API KEY - seed data includes a user with the api_key:
    ```
    [ADD KEY HERE]
    ```
    This key is used in all postman requests -->


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
