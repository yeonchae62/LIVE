# README

## Useful Links
* Github repo: https://github.com/yeonchae62/LIVE
* Deployment: https://evg-library-8a920fa9c3cb.herokuapp.com/
* Code Climate Reports: https://codeclimate.com/github/yeonchae62/LIVE


## Tech Stack

- **Ruby on Rails**
- **SQLite** as database for development, **PostgreSQL** as database for production
- **Bootstrap** for styling
- **Cucumber** for BDD
- **RSpec** for unit testing
- **SimpleCov** for coverage report


## Getting Started

### Dependencies

- Ruby 3.3.0
- Rails 7.1.3

### Setup

#### Install RVM 
- Follow instructions [here](https://rvm.io/rvm/install) to install Ruby Version Manger (RVM)

#### Install Ruby
- run `rvm install 3.3.0` to install the required ruby version
- run `rvm use 3.3.0` to activate the installed version
- run `ruby -v` to check if the ruby 3.3.0 is actually used


### Configuration(for development and testing)
  * run `bundle install` or ` bundle config set --local without 'production'` to install ruby dependencies
  * run `bin/rails s` to start the server

* For testing
  * run `rails db:test:prepare` to setup the database
 


* How to contact us:
  * Xiuyu Tang: <xiuyu@tamu.edu>
  * Zachary McDowell: <cholmcdowell@tamu.edu>
  * Yeon Chae: <yeonchae62@tamu.edu>
  * Komo Zhang: <komo@tamu.edu>
  * Nilo Lisboa: <nl6867@tamu.edu>
