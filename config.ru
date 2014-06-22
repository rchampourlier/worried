# config.ru

ROOT_DIR = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift ROOT_DIR
require 'worried_app'
run Sinatra::Application
$LOAD_PATH.shift