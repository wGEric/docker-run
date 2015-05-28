require "spec_helper"

RSpec.describe DockerRun::Options do
  describe "container" do
    it "requires a value when setting the container with -c" do
      expect {
        described_class.new(["-c"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "requires a value when setting the container with --container" do
      expect {
        described_class.new(["--container"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "sets the container with -c" do
      options = described_class.new(["-c", "asdf"])
      expect(options.container).to eq("asdf")
    end

    it "sets the container with --container" do
      options = described_class.new(["--container", "asdf"])
      expect(options.container).to eq("asdf")
    end
  end

  describe "env vars" do
    it "requires a value when setting env vars with -e" do
      expect {
        described_class.new(["-e"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "requires a value when setting env vars with --environment" do
      expect {
        described_class.new(["--environment"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "default value is a blank array" do
      options = described_class.new([])
      expect(options.env_vars).to be_a(Array)
      expect(options.env_vars).to be_empty
    end

    it "sets environment variables with -e" do
      options = described_class.new(["-e", "VAR1=one,VAR2=two"])
      expect(options.env_vars).to eq({"VAR1" => "one", "VAR2" => "two"})
    end

    it "sets environment variables with --environment" do
      options = described_class.new(["--environment", "VAR1=one,VAR2=two"])
      expect(options.env_vars).to eq({"VAR1" => "one", "VAR2" => "two"})
    end
  end

  describe "clean" do
    it "default value for clean is true" do
      options = described_class.new([])
      expect(options.clean).to eq(true)
    end

    it "sets clean to true with -C" do
      options = described_class.new(["-C"])
      expect(options.clean).to eq(true)
    end

    it "sets clean to true with --clean" do
      options = described_class.new(["--clean"])
      expect(options.clean).to eq(true)
    end

    it "sets clean to false with --no-clean" do
      options = described_class.new(["--no-clean"])
      expect(options.clean).to eq(false)
    end
  end

  describe "verbose" do
    it "default value for verbose is false" do
      options = described_class.new([])
      expect(options.verbose).to eq(false)
    end

    it "sets verbose to true with -v" do
      options = described_class.new(["-v"])
      expect(options.verbose).to eq(true)
    end

    it "sets verbose to true with --verbose" do
      options = described_class.new(["--verbose"])
      expect(options.verbose).to eq(true)
    end

    it "sets verbose to false with --no-verbose" do
      options = described_class.new(["--no-verbose"])
      expect(options.verbose).to eq(false)
    end
  end

  describe "flags" do
    it "requires a value when setting flags with -f" do
      expect {
        described_class.new(["-f"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "requires a value when setting flags with --flags" do
      expect {
        described_class.new(["--flags"])
      }.to raise_error(OptionParser::MissingArgument)
    end

    it "sets the flags with -f" do
      options = described_class.new(["-f", "--service-ports,--another-flag"])
      expect(options.flags).to eq(["--service-ports", "--another-flag"])
    end

    it "sets the flags with --flags" do
      options = described_class.new(["--flags", "--service-ports,--another-flag"])
      expect(options.flags).to eq(["--service-ports", "--another-flag"])
    end
  end

  describe "command" do
    it "sets the command to whatever is left" do
      options = described_class.new(["-c", "container", "my_command"])
      expect(options.command).to eq(["my_command"])
    end

    it "sets the command to whatever is left with spaces" do
      options = described_class.new(["-c", "container", "my_command", "subcommand"])
      expect(options.command).to eq(["my_command", "subcommand"])
    end
  end

  describe "version" do
    it "exits after outputting the version with -V" do
      expect {
        described_class.new(["-V"])
      }.to raise_error(SystemExit)
    end

    it "exits after outputting the version with --version" do
      expect {
        described_class.new(["--version"])
      }.to raise_error(SystemExit)
    end

    it "outputs the version with -V" do
      expect {
        begin
          described_class.new(["-V"])
        rescue SystemExit; end
      }.to output("#{DockerRun::VERSION}\n").to_stdout
    end

    it "outputs the version with --version" do
      expect {
        begin
          described_class.new(["--version"])
        rescue SystemExit; end
      }.to output("#{DockerRun::VERSION}\n").to_stdout
    end
  end

  describe "help" do
    it "exits after outputting the help with -h" do
      expect {
        described_class.new(["-h"])
      }.to raise_error(SystemExit)
    end

    it "exits after outputting the help with --help" do
      expect {
        described_class.new(["--help"])
      }.to raise_error(SystemExit)
    end

    it "outputs help with -h" do
      expect {
        begin
          described_class.new(["-h"])
        rescue SystemExit; end
      }.to output(/^Docker Run/).to_stdout
    end

    it "outputs help with --help" do
      expect {
        begin
          described_class.new(["--help"])
        rescue SystemExit; end
      }.to output(/^Docker Run/).to_stdout
    end
  end
end
