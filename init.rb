require 'rubygems'
require 'ruote'
require 'ruote/storage/fs_storage'
require 'activeresource'
require 'lib/youre_bluffing'

# URL of frontend application
YoureBluffing::Models::Base.site = 'http://youre-bluffing.local/'