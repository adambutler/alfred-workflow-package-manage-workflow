module Workflow
  class Git
    def self.workflow_is_already_installed(title)
      false
    end

    def self.download(title, git_repository_url)
      if self.workflow_is_already_installed(title)
        puts "Error: Workflow is already installed"
        return
      end
      if system "cd \"#{$workflow_path}\" && git clone #{git_repository_url}"
        DB.execute "INSERT INTO workflows ('title', 'git_repository_url') VALUES ('#{title}', '#{git_repository_url}');"
      end
    end
  end
end
