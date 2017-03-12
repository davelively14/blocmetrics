require 'rails_helper'

RSpec.describe API::EventsController, type: :controller do
  # describe "Message API" do
  #   let(:url) { Faker::Internet.url }
  #   let(:name) { 'test_name' }
  #
  #   it "returns the CORS headers" do
  #     create(:registered_application, url: url)
  #     get 'events#preflight', nil, 'HTTP_ORIGIN' => '*'
  #     expect(last_response.headers['Access-Control-Allow-Origin']).to eq('*')
  #   end
  #
  #   # curl -v
  #   # -H "Accept: application/json"
  #   # -H "Origin: http://registered_application.com"
  #   # -H "Content-Type: application/json"
  #   # -X POST -d '{"name":"foobar"}'
  #   # http://localhost:3000/api/events
  # end
end
