require_relative "app"
require "rspec"
require "rack/test"
describe "Hello application" do
include Rack::Test::Methods
def app
Sinatra::Application
end
it "says hello" do
    get '/'
    expect(last_response).to be_ok
  end
  
end