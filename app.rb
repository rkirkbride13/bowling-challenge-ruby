require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/frame'
require_relative 'lib/scoreboard'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

end