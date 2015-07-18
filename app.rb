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
    halt 400
    return "That didn't work. Feel like it should? Run /uid and give your ID to a valid user."
  end

  resp = Slack.search_all({:query => "from:#{params['text']}", :count => 500})

  resp['messages']['matches'].each do |message|
    ts = message['ts']
    channel = message['channel']['id']
    Slack.chat_delete({:ts => ts, :channel => channel})
  end
  status 200
  "Did that help? If it didn't, you need to wait a minute and try again so that the channel & search backends are up to date. Usually, the most recent 5 messages aren't processed."
end

get '/uid?' do
  status 200
  "Your Slack UserID is #{params['user_id']}."
end

get '/' do
  status 200
  "Ok."
end