require 'rubygems' unless defined? Gem 

task :default => :test

task :test do
  sh %Q{bundle install --standalone --clean} do |ok, res|
    puts "fail to install gems (status = #{res.exitstatus})" unless ok
  end
  #sh %Q{ruby test/test.rb} do |ok, res|
  sh %Q{ruby lib/workflow.rb index } do |ok, res|
    puts "fail to run test (status = #{res.exitstatus})" unless ok
  end
end
