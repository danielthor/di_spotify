require 'rubygems'
require 'nokogiri'
require 'json'
require 'net/http'
require 'open-uri'


if true
  #json = File.read('di.json')
  json = Net::HTTP.get(URI.parse('http://api.audioaddict.com/v1/di/track_history/channel/1.json'))
  #json = open('http://api.audioaddict.com/v1/di/track_history/channel/1.json')
  #p json
  result = JSON.parse(json)
  #p result
  playing = result.first
  #p playing
  unless playing['type'] == 'advertisement'
    p "Currently playing: " + playing['track']
  else
    p "Advertisement"
    exit
  end
end

#p URI.encode(playing['track'])

#url = "http://ws.spotify.com/search/1/track?q=Vast%20Vision%20-%20A%20Sunny%20Morning%20(dennis%20pedersen%20remix)"
url = ['http://ws.spotify.com/search/1/track?q=', URI.encode(playing['track'])].join
#p url

if true
  #xml = File.read('spotify.xml')
  xml = Net::HTTP.get(URI.parse(url))
  noko = Nokogiri::XML(xml)
  
  #p noko.xpath('/xmlns:tracks/xmlns:track[1]').first['href']
  spot_result =  noko.css('track')
  unless spot_result.empty?
    spot_result = spot_result.first['href']
  else
    p "No Spotify found"
    exit
  end
end

p "First Spotify result: " + spot_result
