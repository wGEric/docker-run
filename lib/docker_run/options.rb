require "optparse"

class DockerRun::Options
  attr_accessor :command, :container, :env_vars, :flags, :clean, :verbose

  def initialize(args)
    self.container = "web"
    self.env_vars = []
    self.flags = []
    self.clean = true
    self.verbose = false

    parse_options(args)

    # whats left is the command
    self.command = args
  end

  private

  def parse_options(args)
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Docker Run will execute commands within docker containers."

      opts.separator ""

      opts.on("-c", "--container CONTAINER", "Container to run command in") do |container|
        self.container = container
      end

      opts.on("-e", "--environment key=value,key2=value2", Array, "Environment variables to set in the container.") do |env_vars|
        self.env_vars = parse_env_vars(env_vars)
      end

      opts.on("-f", "--flags \"--flag1\",\"-flag2\"", Array, "Additional flags to pass to the docker commands") do |flags|
        self.flags = flags
      end

      opts.on("-C", "--[no-]clean", "Start a new container or run in existing") do |clean|
        self.clean = clean
      end

      opts.separator ""

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        self.verbose = v
      end

      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end

      opts.on_tail("-V", "--version", "Show version") do
        puts DockerRun::VERSION
        exit
      end
    end

    opt_parser.parse!(args)
  end

  def parse_env_vars(env_vars)
    env_vars.each_with_object({}) do |env_var, combined|
      env_var_name, env_var_value = env_var.split("=")
      combined[env_var_name] = env_var_value
    end
  end
end
