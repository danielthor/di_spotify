#!/usr/bin/env /Users/Daniel/.rvm/bin/rvm-auto-ruby

require 'rubygems'
require 'hallon'

session = Hallon::Session.initialize IO.read('./spotify_appkey.key')
session.login!('danielthor', '')

# track = Hallon::Track.new("spotify:track:1ZPsdTkzhDeHjA5c2Rnt2I").load
# artist = track.artist.load
# 
# puts "#{track.name} by #{artist.name}"

playlist_uri = "spotify:user:danielthor:playlist:5Oc1z3gcUhppNcT6wKLArU"

track_uris = %w[spotify:track:1ZPsdTkzhDeHjA5c2Rnt2I spotify:track:30Ss0PVDiOpFCBYUlAvN8Z spotify:track:1cLEBlj0pwwnfPxMJmHJ0w]

track_uri = track_uris[2]

# puts "Loading playlist #{playlist_uri}."
# playlist = Hallon::Playlist.new(playlist_uri).load
# puts "(it has #{playlist.size} tracks)"
# track = Hallon::Track.new(track_uri)
# playlist.insert(playlist.size, track)
# playlist.remove(0)
# puts "Uploading playlist changes to Spotify back-end!"
# playlist.upload
# puts "Done!"

search = Hallon::Search.new("Bsfhdsjfhkjdshfjksdhfjkhsdkjhfjkdshfjkhdkjfhkjdsh", tracks: 1, albums: 0, playlists: 0, tracks_offset: 0).load
p search.tracks.size
# p search.tracks.first.duration