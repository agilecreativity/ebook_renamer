module EbookRenamer
  class Configuration

    attr_accessor :meta_binary

    def initialize
      @meta_binary = '/usr/bin/ebook-meta'
    end

    def to_s
      <<-END.gsub(/^\s+\|/, '')
       | ebook-meta : #{meta_binary}
      END
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
