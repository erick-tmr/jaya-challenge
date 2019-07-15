# Jaya Challenge Solution

## Proposition

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

To run the entire test suite run:

```
cd ./ (to the repository folder)

rspec
```

You should see something like:

```
EventProcessor
  creates an issue
  creates an event
  returns a bool idicating whether the operation was successfull or not
  when there is already an issue with the github_id in the params
    does not create an issue
    associates the issue that already exists to the new event
```

If the text from the output is green :green_circle: means that the test passed and a red :red_circle: text means that it failed
