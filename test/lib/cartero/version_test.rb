require_relative '../../test_helper'

describe Cartero do
  it 'must have a version' do
    Cartero::VERSION.wont_be_nil
  end
end
