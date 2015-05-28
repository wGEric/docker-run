class DockerRun::CommandRunner
  def self.run(command)
    system(command)
  end
end
