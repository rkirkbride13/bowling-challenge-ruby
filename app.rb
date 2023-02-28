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
    if !(@scoreboard.frameCount == 9 && frame.frameTotal >= 10)
      @scoreboard.addFrame(frame)
      frame = Frame.new
    end
    session[:scoreboard] = @scoreboard
    session[:frame] = frame
    redirect '/'
  end

  post '/roll3' do
    frame = session[:frame]
    frame.addRoll(params[:roll].to_i)
    @scoreboard = session[:scoreboard]
    @scoreboard.addFrame(frame)
    session[:scoreboard] = @scoreboard
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