# Jaya Challenge Solution

## Proposition

This is an API that listens to the Github API [Issue Events](https://developer.github.com/v3/activity/events/types/#issuesevent "Github API's documentation") through webhooks and exposes then in it's endpoints.

This repository is a solution to this proposed challenge ([link to the challenge statement](https://takeshi-jaya-challenge.herokuapp.com/developer-test-v2.1.pdf "Repository problem statement")) from [Jaya](https://jaya.tech/ "Jaya's Homepage").

## How to run locally

This project uses [RVM](https://rvm.io/ "RVM's Homepage") to manage Ruby and Rails/Gems.

You must have [PostgreSQL](https://www.postgresql.org/ "PostgreSQL's Homepage") installed and running.

If you already have RVM installed with its wrappers and bash script it should be straight foward, just run:

```
cd ./ (to the repository folder)

rvm install ruby 2.6.3 (if needed)

gem install bundler -v 2.0.2

bundle install

rails db:create

rails db:migrate

rails s
```

## Running the test suite

This project uses [Rspec](https://rspec.info/ "Rspec's Homepage") as it's testing tool.

To run the entire test suite, run:

```
cd ./ (to the repository folder)

rspec
```

You should see something like this:

```
EventProcessor
  creates an issue
  creates an event
  returns a bool idicating whether the operation was successfull or not
  when there is already an issue with the github_id in the params
    does not create an issue
    associates the issue that already exists to the new event
```

If the text from the output is green :green_heart: means that the test passed and a red :red_circle: text means that it failed.

## The solution

This project is live [here](https://takeshi-jaya-challenge.herokuapp.com/ "Repository Heroku link").

This is a [Restful](https://restfulapi.net/ "Restful API explanation") API, it consists in two modules:

* The Webhooks endpoints, that listen's to the Github API Events.
* The resources endpoints, that lists the collected events.

This API partially implements the [Json API specification](https://jsonapi.org/ "Json API's Homepage"), so the payload from the resouces endpoints will follow it's structure.

### Resources Endpoints

#### GET /issues

Link: `https://takeshi-jaya-challenge.herokuapp.com/api/issues`

Returns a collection from the collected issues from the webhook.

Data set:
```json
{
  "github_id": "int"
}
```

#### GET /issues/:github_id

Link: `https://takeshi-jaya-challenge.herokuapp.com/api/issues/<github_id>`

Returns a specific issue collected from the webhook.

Data set:
```json
{
  "github_id": "int"
}
```

#### GET /issues/:github_id/events

Link: `https://takeshi-jaya-challenge.herokuapp.com/api/issues/<github_id>/events`

Returns the events from the specified issue collected from the webhook.

Data set:
```json
{
  "action": "text",
  "payload": "json",
  "relationships": [
    "issue_id"
  ]
}
```

## Notable dependencies

This project uses:

* [Fast Json API](https://github.com/Netflix/fast_jsonapi "Fast Json API's Homepage") to serialize its resources and output it in the JSON API format.
* [FactoryBot](https://github.com/thoughtbot/factory_bot "FactoryBot's Homepage") to generate seed data to tests.
* [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner "Database Cleaner's Homepage") to sanitize the database before each test run.

## Integrations

This project is integrated with its Github's repository, any issue action generated here will be reflected in the API's endpoints, if the webhook event capture action succeeds.

## Considerations

To store the whole payload from the webhook event it was chose the PostgreSQL [JSONB](https://www.postgresql.org/docs/current/datatype-json.html "PostgreSQL JSONB data type explanation") data type because of the dynamic nature of the payload sent from the webhook.

To drive this decision this [article](https://www.citusdata.com/blog/2016/07/14/choosing-nosql-hstore-json-jsonb/ "JSON vs JSONB article") was used.

The resources endpoints are not paginated, so it could potentially slow down or even timeout when a large amout of events were registered.

## Last words

For any comment, suggestion or question feel free to contact me erick.tmr@outlook.com.

Open an issue here and have fun :wink:.
