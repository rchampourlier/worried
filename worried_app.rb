# worried_app.rb
 
require 'rack'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'worried'
require 'worried/app'
require 'worried/push_bullet'
require 'worried/new_relic'
$LOAD_PATH.shift