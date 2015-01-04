# Worried

A minimalist Rack app to forward NewRelic webhooks to PushBullet.

## Use Case

Get notified instantly through PushBullet on your phone when NewRelic is
opening an alert for your app.

## Getting Started

    PUSHBULLET_API_KEY=<your-key> foreman start

Or you can create a `.env` file and use it with Foreman:

    foreman start -e .env

You can also simply deploy it to Heroku.

    heroku create myworriedapp
    heroku config:set PUSHBULLET_API_KEY=<your-key>
    git push heroku

You must then configure your alerting on NewRelic.

1. Locate "Channels and groups" section and open it.
2. Create a new channel of type "Webhook".
3. Enter the name you want for your channel.
4. Enter this as the webhook URL (replace "mydomain.com" with the domain
  you used to deploy the worried app, maybe "myworriedapp.herokuapp.com"):
  `http://mydomain.com/new_relic/push_bullet`.
