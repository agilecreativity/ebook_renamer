require_relative '../../test_helper'
describe EbookRenamer do

  before :each do
    EbookRenamer.configure do |config|
      config.meta_binary = 'ebook-meta'
    end
  end

  after :each do
    EbookRenamer.reset
  end

  it "uses the updated configuration" do
    EbookRenamer.configuration.meta_binary.must_equal 'ebook-meta'
    config = EbookRenamer.configure do |config|
      config.meta_binary = "new-ebook-meta"
    end
    EbookRenamer.configuration.meta_binary.must_equal 'new-ebook-meta'
  end

end
