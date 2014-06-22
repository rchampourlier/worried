# Worried

A minimalist Rack app to forward NewRelic webhooks to PushBullet.

## Use Case

Get notified instantly through PushBullet on your phone when NewRelic is
opening an alert for your app.

## Getting Started

    PUSHBULLET_API_KEY=<your-key> foreman start
    
Or you can create a `.env` file and use it with Foreman:

    foreman start -e .env