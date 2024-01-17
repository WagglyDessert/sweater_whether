# Sweater_Weather

This is my mod3 final solo project at Turing. It involves taking a city and extracting geolocation coordinates to find weather forecast, as well as using a roadtrip from an origin to a destination to calculate what weather will be like upon arrival at destination.

## Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).

### Prerequisites

- Ruby (version 7.0.8 or later)
- Bundler (`gem install bundler`)
- Obtain API keys for the following services:
  * Weather API
  * Yelp API
  * MapQuest API

### Installation

1. Clone the repository.
   ```git clone git@github.com:WagglyDessert/sweater_whether.git```
2. Install Dependencies
```bundle install```
3. Set database
```rails db:{drop,create,migrate,seed}```
4. Delete masterkey and credentials.yml.enc file and add your own api keys to credentials.
  Use the following code to do so:
```EDITOR="code --wait" rails credentials:edit```
5. In your credentials yml that popped up, add the following:
```
  yelp:
    key: Bearer [insert your api key here]
  weather:
    key: [insert your api key here]
  mapquest:
    key: [insert your api key here]
```
6. Close the credentials file and you should be good to start making api calls!

### Release History
* 0.0.1
  * work in progress

### Running the tests
  -RSpec is setup so all you need to do is run:
  ```Bundle exec rspec```

### Authors
  * Nathan Trautenberg

### License
[This project is licensed under the MIT License.](https://www.mit.edu/~amini/LICENSE.md)
