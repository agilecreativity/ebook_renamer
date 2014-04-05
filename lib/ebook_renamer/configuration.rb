module EbookRenamer
  class Configuration
    # the separator char for each word in the file name
    attr_accessor :meta_binary

    # the separator char for each word in the file name
    attr_accessor :sep_string

    def initialize
      @meta_binary = 'ebook-meta'
      @sep_string  = '.'
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
