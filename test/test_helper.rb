require 'minitest/autorun'

#optionally require turn for minitest output
begin; require 'turn/autorun'; rescue LoadError; end
Turn.config.format = :dot
require File.expand_path('../../lib/cartero.rb', __FILE__)
