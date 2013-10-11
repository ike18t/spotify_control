#!/usr/bin/env ruby
APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'sinatra'
require 'json'

class SpotifyControl < Sinatra::Base

  set :root, APP_ROOT

  get '/whatbeplayin' do
    headers 'Access-Control-Allow-Origin'   => '*',
            'Access-Control-Request-Method' => '*'
    content_type 'application/json'

    stuff = ['title', 'artist', 'artUrl']

    track_info = `lib/spotify_control.pl metadata-debug`
    track_information = {}
    stuff.each do |key|
      matches = track_info.match /#{key}: ?\t(.*)\n/
      track_information[key.to_sym] = matches[1]
    end
    track_information.to_json
  end

  ['playpause', 'stop', 'next', 'previous', 'pause', 'playstatus'].each do |command|
    get "/#{command}" do
      `lib/spotify_control.pl #{command}`
    end
  end

end

