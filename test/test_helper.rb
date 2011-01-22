$:.unshift File.expand_path('../../lib', __FILE__)

Dir[File.join(File.dirname(__FILE__), '../lib/*')].each do |file|
  require file
end

require 'shoulda-context'
