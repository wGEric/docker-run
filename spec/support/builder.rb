require "spec_helper"

RSpec.shared_examples "a builder" do
  describe "#initialize" do
    it "requires a argument" do
      expect {
        described_class.new
      }.to raise_error(ArgumentError)
    end

    it "requires a command argument" do
      expect {
        described_class.new(instance_double(DockerRun::Options, command: nil))
      }.to raise_error(ArgumentError)
    end

    it "doesn't require any other arguments" do
      expect {
        described_class.new(instance_double(DockerRun::Options, command: ["command"]))
      }.not_to raise_error
    end

    it "sets the other options" do
      options = instance_double(DockerRun::Options, command: ["command"], container: "container")
      builder = described_class.new(options)
      expect(builder.options).to eq(options)
    end
  end
end
