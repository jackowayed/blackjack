#!/usr/bin/env ruby

task :default => :test do
  Dir["test/unit/*"].each do |file|
    puts file
    require file
  end
end
