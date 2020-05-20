# require 'time'
# require "active_support/all"
require "net/http"

class SearchController < ApplicationController
 
  def getapi

    puts params

    inputText = params['inputText']

    uri = URI('https://maps.googleapis.com/maps/api/place/findplacefromtext/json')
    apiKey = "AIzaSyAmlsvjUNhN1BUTmvSq9SKhq8b0r4qXwAc"
    
    params = { :input => inputText, :inputtype => 'textquery', :fields => 'formatted_address', :key => apiKey }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    render json: res.body if res.is_a?(Net::HTTPSuccess)
  end

  private

  # Only allow a list of trusted parameters through.
    def search_params
      params.require(:search).permit(:inputText)
    end
end
