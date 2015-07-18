require 'sinatra'
require 'slack'

Slack.configure do |config|
  config.token = ENV['slack_api_token']
end

get '/forcekill?' do
  unless params['token'] == ENV['slack_verify_token']
    halt 400
    return
  end

  unless ENV['slack_valid_users'].include? params['user_id']
    status 200
    return "No authentication; invalid user."
  end

  resp = Slack.search_all({:query => "from:#{params['text']}", :count => 500})

  resp['messages']['matches'].each do |message|
    ts = message['ts']
    channel = message['channel']['id']
    Slack.chat_delete({:ts => ts, :channel => channel})
  end
  status 200
  "In theory that worked. If it didn't, you need to wait a minute and try again so that the channel & search backends are up to date."
end