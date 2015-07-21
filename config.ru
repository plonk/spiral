#! /usr/bin/env ruby -E utf-8:utf-8
# -*- mode: ruby -*-
require 'tilt'
require 'sinatra'
require 'slim'
require 'rack-flash'
require 'sinatra/content_for'
require 'active_support'
require 'active_support/core_ext'

configure :development do
  Slim::Engine.set_default_options pretty: false
end

get '/' do
  slim :top
end

require 'open3'
post '/run' do
  sourcefile = "/tmp/spiral.#{$$}.cc"
  File.open(sourcefile, "w") do |f|
    f.write params['code']
  end
  result = nil
  error = nil
  Open3.popen3("bin/sandbox-run", sourcefile, 'r') do |stdin, stdout, stderr, _th|
    stdin.close_write
    result = stdout.read
    error = stderr.read
  end

  slim :result, locals: { result: result.force_encoding('utf-8'), error: error.force_encoding('utf-8') }
end

run Sinatra::Application
