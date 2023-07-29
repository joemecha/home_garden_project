# _Home Garden Project - Joe Mecha_
![logo](lib/images/pexels-engin-akyurt-1435904.jpg "Variety of vegetables")
<!-- ![logo](lib/images/garden_logo.png "Home Garden logo") -->

## About
Home Garden Project is a RESTful back-end API which exposes data on Locations, Crops, and Days-to-Maturity. 


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

  - `The database design` is a __one-to-many__ relationship between Garden & Locations, and a __many-to-many__ between Locations and Crops.

  
  - `Testing` request (integration) tests WILL include happy and sad paths, and WILL be included in a __postman collection__

  - `Authentication` is achieved through registering a new user, generating a random key, and by having the controllers inherit authenticate methods which are called with a 'before_action' filter. The response returns an `API KEY` __please see SET UP for instructions to generate a key__ 
    - _API KEY IS REQUIRED TO HIT ENDPOINTS_
    - With _has secure password_ in the User model, an authenticate method is available for checking credentials in a _log in_ action. However, there is currently no login/session; an authenticate method is defined in the _base controller_ to check the user/api_key.


## Stretch Goals:

TBD


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
| `GET`    | `/api/v0/gardens/:garden_id/locations/:location_id/crops`     | Retrieve all crops for one location  |

### 6 Retrieve data for one crop for a location
| Method   | URI                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v0/gardens/:garden_id/locations/:location_id/crops/:id`     | Retrieve one crop for a single location  |


## Examples

#### 0 - Create new user and receive API KEY
_Request_
```
POST /api/v0/users
Content-Type: application/json
Accept: application/json

{
  "name": "Ohn Scoggins",
  "email_address": "namenamename@example.com",
  "password": "mypassword",
  "password_confirmation": "mypassword"
}
```
_Response_
```
status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email_address": "Ohn Scoggins",
      "email_address": "namenamename@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

#### 1 - View all gardens:

```
status: 200
body:

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

```
status: 200
body:

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
```
status: 404
body:

{
    "errors": "Cannot find garden with ID 555"
}
```


#### 3 - Retrieve all locations for garden 1:

```
status: 200
body:

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
```
status: 200
body:

{
    "message": "There are no locations associated with this garden"
}
```


#### 4 - Retrieve location 2 for garden 1:

```
status: 200
body:

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
```
status: 404
body:

{
    "errors": "Cannot find location with ID 55"
}
```



## Running the Tests

Run all tests for the application with `bundle exec rspec`.


## Developer
### Joe Mecha  [GitHub](https://github.com/joemecha) • [LinkedIn](https://www.linkedin.com/in/joemecha/)
