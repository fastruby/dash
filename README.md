[![CircleCI](https://circleci.com/gh/ombulabs/dash/tree/master.svg?style=svg&circle-token=aa41e55b03a167988f14667d78d1d7c0183f2656)](https://circleci.com/gh/ombulabs/dash/tree/master)  [![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](https://github.com/fastruby/dash/blob/main/CODE_OF_CONDUCT.md)

# Dash

A dashboard to integrate GitHub pull requests and issues, as well as  Pivotal Tracker stories.

## Getting Started

To get started with the app:
```
$ bin/setup
```

We currently recommend using "Ruby 2.6.6" with Dash to avoid any warnings or problems with gems.

## Environment Variables

Running bin/setup will create a .env file with the following environment variables:

Examples
```
GITHUB_KEY=c0aa36d5697d97ded
GITHUB_SECRET=6571a2b4fc1dae2abcdea568edc9161a1e7672
GITHUB_PERSONAL_ACCESS_TOKEN=058ba38d0e50000333265ae783534a560838868f6
GITHUB_MACHINE_USER_ACCESS_TOKEN=28abc9e6de7e1234567d7b9c9483f23a77bd9758
PIVOTAL_TOKEN=8406d6312871234565e9aa95516c4b2
LOCKBOX_MASTER_KEY=0a982923e5954b16c82abcdef2c13f6368724679f056977bb36c594ead211
GITHUB_ORGANIZATIONS=myorg,otherorg,org-org
```
GITHUB_KEY and GITHUB_SECRET:
You need to sign up for an OAuth2 Application ID and Secret on the [GitHub Applications Page](https://github.com/settings/applications).

GITHUB_MACHINE_USER_ACCESS_TOKEN:
This is required only if you want to use an asynchronous job.
You can get this token using a [GitHub Machine User](https://developer.github.com/v3/guides/managing-deploy-keys/#machine-users).

GITHUB_PERSONAL_ACCESS_TOKEN and PIVOTAL_TOKEN:
These tokens are only needed for running tests. If you want to create new tests or new VCRs you will need to replace these tokens with your own.

LOCKBOX_MASTER_KEY:
This is used by [Lockbox Gem](https://github.com/ankane/lockbox#key-generation) which is being used to encrypt the pivotal token for each user.

GITHUB_ORGANIZATIONS:
This is a string with comma separated organization names. This is not the name of the organization, but how it is represented in the url.
For example: "Hello World" should be "hello-world"

## Starting the Server
```
$ rails s
```
Go to http://localhost:3000

## Running Tests
```
$ rails spec
```
The tests in this project use the [VCR gem](https://github.com/vcr/vcr) to record and playback all interactions with the Github and Pivotal Tracker APIs. This allows you to run the test suite without having an account at GitHub or Pivotal Tracker for testing.

If you add a test that requires making an additional API call, then you'll need to make adjustments to the `.env` file to provide account details that are required by the test suite.

If you need to refresh the VCR cassettes, the easiest way is to delete all of the files located under [`fixtures/vcr_cassettes`](fixtures/vcr_cassettes). The next time the test suite is run, VCR will make actual calls against the GitHub or Pivotal Tracker APIs and record the responses into updated cassette files. Care should be taken to use fake account if you are doing this and wish to preserve sensitive data.

Effort has been taken to ensure that private information is excluded from the recorded cassettes. To adjust this further, add additional `filter_sensitive_data` calls to [`spec/spec_helper.rb`](spec/spec_helper.rb).

## Tasks

  There are rake tasks in lib/tasks/scheduler.rake available to use as a cron job.
```
  $ bundle exec rake update_pull_requests
```
```
  $ bundle exec rake update_issues
```
  ## Contributing

  Bug reports and pull requests are welcome on GitHub at [https://github.com/ombulabs/dash](https://github.com/ombulabs/dash). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


  When Submitting a Pull Request:

  * If your PR closes any open GitHub issues, please include `Closes #XXXX` in your comment

  * Please include a summary of the change and which issue is fixed or which feature is introduced.

  * If changes to the behavior are made, clearly describe what changes.

  * If changes to the UI are made, please include screenshots of the before and after.

  ## License

  The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

  ## Code of Conduct

  Everyone interacting in the Dash project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fastruby/dash/blob/main/CODE_OF_CONDUCT.md).

  ## Sponsorship

![FastRuby.io | Rails Upgrade Services](app/assets/images/fastruby-logo.png)


`Dash` is maintained and funded by [FastRuby.io](https://fastruby.io). The names and logos for FastRuby.io are trademarks of The Lean Software Boutique LLC.
