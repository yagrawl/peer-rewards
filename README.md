# Peer Rewards

A simple rails app to send [Tremendous](https://tremendous.com/) rewards to your peers.

## Getting started
This app is still in progress and at a very rudimentary phase. 

### Clone the repository

```
git clone https://github.com/yagrawl/peer-rewards.git
cd peer-rewards
```

### Install Dependencies
```
bundle install
```

### Setup Environment Variables
- Open config/credentials.yml.enc in an editor.
- Add your API keys:
```
tremendous:
  api_key: "YOUR-API-KEY-HERE"
```

To edit credentials.yml.enc, use:
```
EDITOR="your_editor_here --wait" rails credentials:edit
```

### Setup the Config File
You can find a sample tremendous_config.json at the root directory. Modify it with your Campaign IDs and any other options:

### Start the Server
Run the Rails server using:
```
rails s
```

You should now have the Rails server running on http://localhost:3000.

## Making API Requests
You can make API requests using curl or any API testing tool like Postman.

Here's a sample curl command:
```
curl --request POST 'http://localhost:3000/api/rewards' \
--header 'Content-Type: application/json' \
--data-raw '{
  "to": "John",
  "recipient_email": "hi@example.com"
  "from": "Jane",
  "message": "Great job!"
}'
```

