# URLockbox
URLlockbox is an application in which a user can post and save links for later review. The user can create an account, sign in, save links, edit saved links, mark links as read or unread, and filter links by included characters or read status.

## Tech stack
This application uses Rails 5.0.1

## Setup
* To setup this application first clone the repo
* Run `bundle`
* To run locally run `rails s` and open browser to localhost:3000
* The production link is [here](https://shrouded-plateau-67325.herokuapp.com/)

## Tests
* This application uses RSpec and Selenium to test the backend and frontend respectively.
* To run tests use the command `rspec`

## API docs
This application has two API endpoints.
* POST to '/api/v1/links' allows the user to create a new link. This is used to create a link without refreshing the page
* PATCH to '/api/v1/links/:id' allows the user to update a link without refreshing the page. 
