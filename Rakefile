# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require './lib/motion-alert'

begin
  require 'bundler'
  require 'motion/project/template/gem/gem_tasks'
  require 'motion-stump'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'motion-alert'
  app.sdk_version = '8.1'
  app.deployment_target = '7.1'
end
