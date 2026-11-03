class BitcoinsController < ApplicationController
  def index 
 # connect to the Blockchain.com Exchange Rates API (the Week 4 code)
    require "net/http"
    require "json"
    response = Net::HTTP.get(URI("https://blockchain.info/ticker"))
    uri = URI(url)
    response = Net: :HTTP.get(uri)
    bitcoin_data = JSON.parse(response)

    @bitcoin = params["amount"].to_f
    @usd_rate = bitcoin_data["USD"]["last"]
    @usd_value = @usd_rate * @bitcoin

    render({ :template=> "bitcoins/index"})
  end
end
