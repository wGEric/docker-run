require "spec_helper"

RSpec.describe DockerRun::CLI do
  describe "#initialize" do
    it "requires options" do
      expect {
        described_class.new
      }.to raise_error(ArgumentError)
    end
  end

  describe "#run" do
    let(:options_clean) { instance_double(DockerRun::Options, clean: true, verbose: false) }
    let(:options_existing) { instance_double(DockerRun::Options, clean: false, verbose: false) }

    before do
      clean_builder = instance_double(DockerRun::Builders::Base, build_command: "built command clean")
      existing_builder = instance_double(DockerRun::Builders::Base, build_command: "built command existing")
      allow(DockerRun::Builders::Clean).to receive(:new).and_return(clean_builder)
      allow(DockerRun::Builders::Existing).to receive(:new).and_return(existing_builder)
      allow(DockerRun::CommandRunner).to receive(:run).and_return(true)
    end

    it "runs a command in clean container" do
      described_class.new(options_clean).run
      expect(DockerRun::CommandRunner).to have_received(:run).with("built command clean")
    end

    it "runs a command in existing container" do
      described_class.new(options_existing).run
      expect(DockerRun::CommandRunner).to have_received(:run).with("built command existing")
    end
  end
end
