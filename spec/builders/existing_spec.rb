require "spec_helper"

RSpec.describe DockerRun::Builders::Existing do
  it_behaves_like "a builder"

  describe "#build_command" do
    let(:builder) { described_class.new(command: "command") }

    xit "returns the built command with no additional options" do
      expect(builder.build_command).to eq("docker exec -it \"web\" bash -c \"(command)\"")
    end

    xit "returns the built command for the correct container" do
      builder.container = "container"
      expect(builder.build_command).to eq("docker exec -it \"container\" bash -c \"(command)\"")
    end
  end
end
