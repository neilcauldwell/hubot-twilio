# Hubot Twilio Adapter

## Description

This is the [Twilio](http://twilio.com) adapter for hubot that allows you to
send an SMS to your Hubot and he will send an SMS back with the response.

## Installation

* Add `hubot-twilio` as a dependency in your hubot's `package.json`
* Install dependencies with `npm install`
* Run hubot with `bin/hubot -a twilio`

### Note if running on Heroku

You will need to change the process type from `app` to `web` in the `Procfile`.

## Usage

You will need to set some environment variables to use this adapter.

### Heroku

    % heroku config:add HUBOT_SMS_FROM="+14156662671"

    % heroku config:add HUBOT_SMS_SID="AC5d10e5624da757326d12f8d31c08c20b"

    % heroku config:add HUBOT_SMS_TOKEN="4ada63e18146a204e468fb6289030231"

### Non-Heroku environment variables

    % export HUBOT_SMS_FROM="+14156662671"

    % export HUBOT_SMS_SID="AC5d10e5624da757326d12f8d31c08c20b"

    % export HUBOT_SMS_TOKEN="4ada63e18146a204e468fb6289030231"

Then you will need to set the HTTP endpoint on Twilio to point to your server
and make sure the request type is set to `GET`.

## Contribute

Here's the most direct way to get your work merged into the project.

1. Fork the project
2. Clone down your fork
3. Create a feature branch
4. Hack away and add tests, not necessarily in that order
5. Make sure everything still passes by running tests
6. If necessary, rebase your commits into logical chunks without errors
7. Push the branch up to your fork
8. Send a pull request for your branch

## Copyright

Copyright &copy; Tom Bell. See LICENSE for details.

