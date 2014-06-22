# config.ru

ROOT_DIR = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift ROOT_DIR
require 'worried_app'

run Worried::App.new

$LOAD_PATH.shift