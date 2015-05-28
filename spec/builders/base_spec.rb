require "spec_helper"

RSpec.describe DockerRun::Builders::Base do
  it_behaves_like "a builder"

  describe "#build_command" do
    it "raises an error. Child classes are suppose to implement" do
      options = instance_double(DockerRun::Options, command: "command", env_vars: [])
      builder = DockerRun::Builders::Base.new(options)
      expect {
        builder.build_command
      }.to raise_error
    end
  end
end
