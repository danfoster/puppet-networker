require 'spec_helper'
describe 'networker' do

  context 'with defaults for all parameters' do
    it { should contain_class('networker') }
  end
end
