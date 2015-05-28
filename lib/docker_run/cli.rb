class DockerRun::CLI
  def initialize(options)
    @options = options
  end

  def run
    command = build_command
    puts command if @options.verbose
    DockerRun::CommandRunner.run(command)
  end

  private

  def build_command
    builder.build_command
  end

  def builder
    if @options.clean
      DockerRun::Builders::Clean.new(@options)
    else
      DockerRun::Builders::Existing.new(@options)
    end
  end
end
