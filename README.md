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

#### Clone the Repo
- run `git clone https://github.com/yeonchae62/LIVE.git` to clone the repo.
- run `cd LIVE` to change the current working directory.

#### Install RVM (Skip if you have already installed)
- Follow instructions [here](https://rvm.io/rvm/install) to install Ruby Version Manger (RVM).

#### Install Ruby (Skip if you have already installed)
- run `rvm install 3.3.0` to install the required ruby version.
- run `rvm use 3.3.0` to activate the installed version.

#### Check Ruby Version
- run `ruby -v` to check if the ruby 3.3.0 is actually used. If the ruby version is incorrect or not installed, please refer to the steps above to install and activate the correct version.


### Configuration(for development)
  * run `bundle install` or ` bundle config set --local without 'production'` to install ruby dependencies.
  * run the following commands to set up the database: 
    ```bash
    bin/rails db:create
    bin/rails db:migrate
    bin/rails db:seed
    ```
  * run `bin/rails s` to start the server
  * open the application by clicking the link appearing in your terminal or pasting this in your browser: http://127.0.0.1:3000.
  * Use Ctrl-C to stop the server

### Testing
  * run `bin/rails db:test:prepare` to setup the database.
  * run `bundle exec rspec` to run Rspec tests.
  * run `bundle exec cucumber` to run Cucumber tests


## Deploy to Heroku
  *  signup or login to your [Heroku](https://id.heroku.com/login) account. After successfully logged in, you will see this:
    <img src="img.png" width=400px>
  * 


## How to contact us:
  * Komo Zhang: <komo@tamu.edu>
  * Nilo Lisboa: <nl6867@tamu.edu>
  * Xiuyu Tang: <xiuyu@tamu.edu>
  * Yeon Chae: <yeonchae62@tamu.edu>
  * Zachary McDowell: <cholmcdowell@tamu.edu>
