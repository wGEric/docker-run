class DockerRun::Builders::Existing < DockerRun::Builders::Base
  def build_command
    "".gsub(/\s+/, " ")
  end
end
