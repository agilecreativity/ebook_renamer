require 'optparse'

module EbookRenamer::Options

  def parse_options()
    options = {}

    option_parser = OptionParser.new do |opts|
      opts.banner = <<-END.gsub(/^\s+\|/, '')
        |
        | Usage: ebook_renamer [options]
        |
        | Examples:
        |
        |  1) $ebook_renamer
        |
        |  2) $ebook_renamer --base-dir ~/Dropbox/ebooks
        |
        |  3) $ebook_renamer --base-dir ~/Dropbox/ebooks
        |                    --recursive
        |
        |  4) $ebook_renamer --base-dir ~/Dropbox/ebooks
        |                    --recursive
        |
        |  5) $ebook_renamer --base-dir ~/Dropbox/ebooks
        |                    --recursive
        |                    --commit
        |
        |  6) $ebook_renamer --base-dir ~/Dropbox/ebooks
        |                    --meta-binary /usr/bin/ebook-meta
        |                    --recursive
        |                    --commit
        |
        | Options:
        |
      END

      options[:base_dir] ||= Dir.pwd
      opts.on('-b', '--base-dir directory', 'Starting directory [default - current directory]') do |base_dir|
        options[:base_dir] = base_dir
      end

      options[:meta_binary] ||= '/usr/bin/ebook-meta'
      opts.on('-m', '--meta-binary path', "Path to the ebook-meta executable [default - '/usr/bin/ebook-meta']") do |binary|
        options[:meta_binary] = binary
      end

      options[:recursive] = false
      opts.on('-r', '--recursive', 'Process the files recursively [default - false]') do
        options[:recursive] = true
      end

      options[:commit] = false
      opts.on('-c', '--commit', 'Perform the actual rename [default - false]') do
        options[:commit] = true
      end

      opts.on('-v', '--version', 'Display version number') do
        puts EbookRenamer::VERSION
        exit 0
      end

      opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit 0
      end
    end

    option_parser.parse!
    options
  end
end
