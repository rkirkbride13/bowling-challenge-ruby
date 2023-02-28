require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/frame'
require_relative 'lib/scoreboard'

class Application < Sinatra::Base
  enable :sessions
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    initialize_game
    @frame = session[:frame]
    @scoreboard = session[:scoreboard]
    if @scoreboard != [] then @scoreboard_array = @scoreboard.accessScoreboard end
    return erb(:index)
  end

  post '/roll1' do
    frame = Frame.new
    frame.addRoll(params[:roll].to_i)
    session[:frame] = frame
    redirect '/'
  end

  post '/roll2' do
    initialize_scoreboard
    frame = session[:frame]
    frame.addRoll(params[:roll].to_i)
    @scoreboard.addFrame(frame)
    session[:scoreboard] = @scoreboard
    frame = Frame.new
    session[:frame] = frame
    redirect '/'
  end

  post '/roll3' do
    @roll3 = params[:roll]
    @frame.addRoll(@roll3)
    @scoreboard.addFrame(@frame)
    redirect '/'
  end

  post '/reset' do
    session[:initialized?] = false
    redirect '/'
  end

  private

  def initialize_game
    if !session[:initialized?]
      @roll_count = 0
      session[:initialized?] = true
      session[:scoreboard] = []
    end
  end

  def initialize_scoreboard
    session[:scoreboard] != [] ? @scoreboard = session[:scoreboard] : @scoreboard = Scoreboard.new
  end

end