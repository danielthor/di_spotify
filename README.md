# README

This is a proof of concept for an idea I had -- check what's playing on di.fm and build a Spotify playlist from the songs. Work in progress.

## Quick and dirty setup

1. `cp spotify_config.yml.example spotify_config.yml`
2. Download your Spotify API key as described in [Hallon gem docs](https://github.com/Burgestrand/Hallon#prerequisites)
3. Edit `spotify_config.yml`, find an incomplete list of `di_channel_id` in di_channels.yml
4. Run using `bundle exec ruby di_spotify.rb`

## Todo / Ideas

* DI.fm channel list yml with name and ids
* Generic config with Spotify and DI.fm settings
* Continuously search for new playing tracks and update playlist
* Sleep search loop for at least the length of the currently playing track on DI.dm
* Figure out some clever way when to look for new song and do it more efficiently (ie when the current song finished)
* Initialize a new playlist if --playlist option is passed


## License

[MIT](http://opensource.org/licenses/MIT)
