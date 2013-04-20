require "sinatra"
require "slim"
require "coffee-script"
require "httparty"
require "json"

class Faye
  include HTTParty
  base_uri "http://localhost:9292"

  class << self
    def publish(channel, data)
      puts "Faye.publish #{channel} #{data}"
      puts post('/faye', :body => {
        :message => {
          :channel => channel,
          :data    => data
        }.to_json
      })
    end
  end
end


class CoffeeHandler < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/coffee'

  get "/js/app.js" do
    coffee :app
  end
end

use CoffeeHandler

get "/" do
  slim :index
end

post "/publish" do
  params = JSON.parse(request.body.read)
  Faye.publish(params["channel"], params["data"])
  "OK"
end

