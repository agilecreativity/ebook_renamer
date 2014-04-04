require_relative '../../test_helper'
describe EbookRenamer do

  before :each do
    EbookRenamer.configure do |config|
      config.meta_binary = '/usr/bin/ebook-meta'
    end
  end

  after :each do
    EbookRenamer.reset
  end

  it "uses the updated configuration" do
    EbookRenamer.configuration.meta_binary.must_equal '/usr/bin/ebook-meta'
    config = EbookRenamer.configure do |config|
      config.meta_binary = "ebook-meta"
    end
    EbookRenamer.configuration.meta_binary.must_equal 'ebook-meta'
  end

end
