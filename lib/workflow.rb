#!/usr/bin/env ruby

require 'open-uri'
require 'yaml'
require 'sqlite3'

$environment = :production unless $environment

case $environment
  when :production
    $host = "http://flow.lab.io"
    $alfred_preferences = ENV['alfred_preferences']
    $workflow_path = "#{$alfred_preferences}/workflows"
  when :development
    $host = "http://alfred-workflow-package-manager.dev" unless $host
    tmp_path = (ENV['TMP']) ? ENV['TMP'] : "/tmp"
    $workflow_path = tmp_path unless $workflow_path
end

module Workflow
  require "./lib/workflow/initialize"
  require "./lib/workflow/list"
  require "./lib/workflow/remote"
  require "./lib/workflow/git"

  def self.index
    workflows = Workflow::Remote.index()
    puts Workflow::List.generate_xml(workflows)
  end

  def self.search
    query = ARGV[1]
    if query && query != ""
      workflows = Workflow::Remote.search(query)
      puts Workflow::List.generate_xml(workflows)
    else
      self.index()
    end
  end

  def self.download
    id = ARGV[1]
    workflow = Workflow::Remote.get(id)
    git_repository_url = workflow["git_repository_url"]
    Workflow::Git.download "test", git_repository_url
  end
end

case ARGV[0]
  when "index"
    if ARGV[1].nil?
      Workflow.index
    else
      Workflow.search
    end

  when "download"
    Workflow.download
end
