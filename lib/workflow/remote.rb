module Workflow
  class Remote

    def self.index(query = nil)
      url = "#{$host}/workflows.json"
      url = "#{url}?query=#{query}" if query
      request = open(url).read
      workflows = YAML::load(request)
      return workflows
    end

    def self.get(id)
      url = "#{$host}/workflows/#{id}.json"
      request = open(url).read
      workflow = YAML::load(request)
      return workflow
    end

    def self.search(query)
      self.index(query)
    end
  end
end
