#!/usr/bin/env /Users/Daniel/.rvm/bin/rvm-auto-ruby
#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'net/http'
Bundler.require(:default)

config = YAML::load(File.open('spotify_config.yml'))

session = Hallon::Session.initialize IO.read(File.join(File.dirname(File.expand_path(__FILE__)), config['api_keyfile']))
session.login!(config['username'], config['password'])


playlist_uri = "spotify:user:danielthor:playlist:5Oc1z3gcUhppNcT6wKLArU"
puts "Loading playlist #{playlist_uri}."
playlist = Hallon::Playlist.new(playlist_uri).load

sleep_time = 30

while true
  #json = File.read('di.json')
  json = Net::HTTP.get(URI.parse("http://api.audioaddict.com/v1/di/track_history/channel/#{config['di_channel_id']}.json"))
  result = JSON.parse(json)
  playing = result.first
  unless playing['type'] == 'advertisement'
    puts "DI.fm currently playing: " + playing['track']
    puts "Started at: " + Time.at(playing['started'].to_i).to_s
    puts "Duration: " + playing['duration'].to_s
    
    ends_at = Time.at(playing['started'].to_i) + playing['duration'].to_i
    time_left = ends_at - Time.now
    
    if time_left < 0
      time_left = 0
    end
    
    puts "Time left: " + time_left.to_s
    
    
    
    sleep_time = time_left.to_i + 10
    
    # sleep_time = playing['duration'].to_i/4
    # sleep_time = 30
  else
    puts "Advertisement playing"
    sleep_time = 30
  end
  
  
  
  # find first track
  search = Hallon::Search.new(playing['track'], tracks: 1, albums: 0, playlists: 0, tracks_offset: 0).load
  
  if search.tracks.size > 0
    puts "Found matching Spotify track, adding to playlist!"
    track = search.tracks.first
    
    playlist.insert(playlist.size, track)
    # playlist.remove(0)
    
    playlist.upload
    puts "Added!"
  else
    puts "No Spotify match"
  end
  
  puts "Sleeping for " + (Time.mktime(0)+sleep_time).strftime("%H:%M:%S") 
  sleep sleep_time
end
