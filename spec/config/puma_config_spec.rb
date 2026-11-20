require "spec_helper"
require "puma"
require "puma/configuration"
require "tmpdir"

RSpec.describe "config/puma.rb" do
  let(:config_file) { File.expand_path("../../config/puma.rb", __dir__) }

  def load_options
    configuration = Puma::Configuration.new({ config_files: [config_file] })
    configuration.clamp
    configuration.options
  end

  it "creates the pidfile directory when it does not exist" do
    Dir.mktmpdir do |dir|
      pidfile = File.join(dir, "tmp", "pids", "server.pid")
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with("PIDFILE").and_return(pidfile)

      options = load_options

      expect(options[:pidfile]).to eq(pidfile)
      expect(File.directory?(File.dirname(pidfile))).to be(true)
    end
  end

  it "accepts a pidfile directory that already exists" do
    Dir.mktmpdir do |dir|
      pidfile = File.join(dir, "server.pid")
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with("PIDFILE").and_return(pidfile)

      expect(load_options[:pidfile]).to eq(pidfile)
    end
  end
end
