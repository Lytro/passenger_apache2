require 'chefspec'
require 'fauxhai'

describe 'passenger_apache2::default' do
  before do
    Fauxhai.mock(platform: 'ubuntu', version: '10.04')
  end

  let(:runner) do
    cookbook_paths = %W(#{File.expand_path(Dir.pwd)}/cookbooks #{File.expand_path("..", Dir.pwd)})
    ChefSpec::ChefRunner.new({cookbook_path: cookbook_paths})
  end

  let(:chef_run) { runner.converge 'passenger_apache2::default' }

  it "creates a blank ports.conf" do
    chef_run.should create_file_with_content "/etc/apache2/ports.conf", "# empty ports file since passenger module declares which ports to open"
  end
end
