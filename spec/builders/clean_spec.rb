require "spec_helper"

RSpec.describe DockerRun::Builders::Clean do
  it_behaves_like "a builder"

  describe "#build_command" do
    let(:builder) { described_class.new(@options) }

    it "returns the built command with no additional options" do
      @options = instance_double(DockerRun::Options, command: ["command"], container: "web", env_vars: [])
      expect(builder.build_command).to eq("docker-compose run --rm web command")
    end

    it "returns the built command if the command has spaces" do
      @options = instance_double(DockerRun::Options, command: ["command", "subcommand"], container: "web", env_vars: [])
      expect(builder.build_command).to eq("docker-compose run --rm web command subcommand")
    end

    it "returns the built command for the correct container" do
      @options = instance_double(DockerRun::Options, command: ["command"], container: "container", env_vars: [])
      expect(builder.build_command).to eq("docker-compose run --rm container command")
    end

    it "returns the command with the env vars built correctly" do
      @options = instance_double(DockerRun::Options, command: ["command"], container: "web", env_vars: {"one" => "one", "TWO" => "two"})
      expect(builder.build_command).to eq("docker-compose run --rm -e one=one -e TWO=two web command")
    end
  end
end
