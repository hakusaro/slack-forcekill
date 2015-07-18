# Slack-Forcekill

This is a somewhat essential tool for public slack instances. It allows you to ban Slack users and remove their messages.

Unfortunately, due to API restrictions, you can't ban a user via the API, you can only delete their messages.

## Installation

This deploys on Heroku.

* Deploy repo to heroku.
* Set the ```sack_api_token``` config variable to a user level access token from Slack's API. A bot token won't work (it can't access the search API).
* Create two outgoing webhooks. Name one /forcekill and the other /uid. Point them at the heroku endpoints, e.g. ```http://tshock-forcekill.herokuapp.com/forcekill```.
* Make the token that the outgoing webhook will send the same for both hooks, and set the config variable ```slack_verify_token``` to that token.
* Done!

## Authorizing Users

* Run /uid from the given user you want to authorize.
* Add the UID given in the output to the ```slack_valid_users``` config file. Separate values with commas.

## License

I'm too lazy to add a license file. All rights waived; do whatever you like.