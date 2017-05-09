require 'rubygems'
require 'git'
require 'xcodeproject'

if File.directory?('ProjectTemplate') == false
	templateRepo = Git.clone('', 'XCodeProjectTemplate', :path => '/tmp/checkout')
end
proj = XcodeProject::Project.new('example.xcodeproj')