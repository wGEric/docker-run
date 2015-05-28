module DockerRun::Builders
  class Base
    attr_accessor :options

    def initialize(options)
      @options = options

      raise ArgumentError, "Command can't be nil/empty" if options.command.nil? || options.command.empty?
    end

    def build_command
      raise NotImplementedError
    end

    protected

    def build_env_vars
      (@options.env_vars || {}).map{ |key,value| "-e #{key}=#{value}" }.join(" ")
    end

    def build_flags
      (@options.flags || []).join(" ")
    end

    def prepare_command
      @options.command.join(" ")
    end
  end
end
