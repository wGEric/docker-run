class DockerRun::Builders::Clean < DockerRun::Builders::Base
  def build_command
    "docker-compose run --rm #{build_env_vars} #{build_flags} #{@options.container} #{prepare_command}".gsub(/\s+/, " ")
  end
end
