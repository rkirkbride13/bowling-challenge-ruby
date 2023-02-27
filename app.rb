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
    if @scoreboard != []
      @scoreboard_array = @scoreboard.accessScoreboard
    end
    return erb(:index)
  end

  post '/roll1' do
    @frame = Frame.new
    @frame.addRoll(params[:roll])
    @frame.accessFrame[0] = @frame.accessFrame[0].to_i
    session[:initialized?] = true
    session[:frame] = @frame
    redirect '/'
  end

  post '/roll2' do
    initialize_scoreboard
    @frame = session[:frame]
    @frame.addRoll(params[:roll])
    @frame.accessFrame[1] = @frame.accessFrame[1].to_i
    @scoreboard.addFrame(@frame)
    session[:scoreboard] = @scoreboard
    @frame = Frame.new
    session[:frame] = @frame
    session[:initialized?] = true
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
    if session[:initialized?]
      @frame = session[:frame].accessFrame.map{|roll| roll.to_i}
    else
      @roll_count = 0
      session[:scoreboard] = []
    end
  end

  def initialize_scoreboard
    if session[:scoreboard] != []
      @scoreboard = session[:scoreboard]
    else
      @scoreboard = Scoreboard.new
    end
  end

end