require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'json'

describe Application do

  include Rack::Test::Methods
  let(:app) { Application.new }

  context 'GET /' do
    it 'should get the homepage' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>welcome to the super bowl!</h1>')
      expect(response.body).to include('<h2>please click a number for each of your rolls</h2>')
      expect(response.body).to include('<div id="buttons" class="button_group">')
      expect(response.body).to include('<input type="hidden" name="roll" value=10>')
      expect(response.body).to include('<input class="btn" type="submit" value=10>')
    end
  end  
end
