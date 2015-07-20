# -*- mode: ruby -*-
require 'tilt'
require 'sinatra'
require 'slim'
require 'rack-flash'
require 'sinatra/content_for'

configure :development do
  Slim::Engine.set_default_options pretty: false
end

get '/' do
  "hello"
end

run Sinatra::Application
