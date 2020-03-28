<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:0 orderedList:0 -->

- [adept it to your needs](#adept-it-to-your-needs)
  - [Your awesome API](#your-awesome-api)
  - [Usage](#usage)
  - [Rake Tasks](#rake-tasks)
  - [Docker](#docker)
  - [Contributing](#contributing)
  - [License](#license)

<!-- /TOC -->

# adept it to your needs

## Booking Movies API

An awesome API used to create movies and book specific dater for each movie.
It is built with Grape Gem to make it easier to implement api routing and and input validations, using Sequel as database query toolkit

## Usage

To run it locally you will need the last version of Ruby, then follow these steps:

- [Get Project](#get)
- [Setup](#setup)
- [Test](#test)
- [Run](#run)
- [Update](#update)
- [Stop](#stop)

#### `Get Project`

First clone the project and access the folder
```
git clone https://github.com/daniuribe25/booking-movie-api.git

cd booking-movie-api
```

#### `Setup`

Run:
```
bundle install
```

Create a new PG Database 
```
CREATE USER bookingmovies WITH PASSWORD 'Paxwork1!';
CREATE DATABASE booking_movies WITH ENCODING 'UTF8';
GRANT ALL PRIVILEGES ON DATABASE booking_movies TO bookingmovies
$ ./script/setup
```

Migrate Database by running
```
rake db:migrate
```
if you encountered any issue comment in model's content like
```
class Movie
  # < Sequel::Model
  # one_to_many :movie_dates
end
```
then run the migration again

#### `Test`

Running tests
```
$ ./script/test
```

#### `Run`

Running local server
```
$ ./script/server *port (default: 9292)
```
and go to: [http://localhost:port/doc](http://localhost:9292/doc)
to access the OAPI documentation.

For production, set `RACK_ENV=production`
```
$ RACK_ENV=production ./script/server *port (default: 9292)
```

#### `Update`

… dependencies
```
$ ./script/update
```

#### `Stop`

… would only be used, if server started in production mode
```
$ ./script/stop
```

#### List Routes

```
rake routes
```

#### OpenApi Documentation and Validation

```
rake oapi:fetch
rake oapi:validate
```
comming from: [`grape-swagger` Rake Tasks](https://github.com/ruby-grape/grape-swagger#rake-tasks)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/daniuribe25/booking-movie-api.git.