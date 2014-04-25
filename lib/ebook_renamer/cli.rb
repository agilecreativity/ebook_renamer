require 'code_lister'
require_relative '../ebook_renamer'

module EbookRenamer
  class CLI < Thor
    desc 'rename', 'Rename multiple ebook files (pdf,epub,mobi)'

    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::EXTS
    method_option *AgileUtils::Options::NON_EXTS
    method_option *AgileUtils::Options::INC_WORDS
    method_option *AgileUtils::Options::EXC_WORDS
    method_option *AgileUtils::Options::IGNORE_CASE
    method_option *AgileUtils::Options::RECURSIVE
    method_option *AgileUtils::Options::VERSION

    method_option :sep_string,
                  aliases: "-s",
                  desc: "Separator string between words in filename",
                  default: "."

    method_option :commit,
                  aliases: "-c",
                  desc: "Make change permanent",
                  type: :boolean,
                  default: false
    def rename
      opts = options.symbolize_keys

      # Note: by default the 'code_lister' for exts: is [].
      # To make it more user friendly, we explicitly set the extension
      # to %w(pdf epub mobi) to avoid the need for explicit value by the user
      opts[:exts] = %w(pdf epub mobi) if opts.fetch(:exts, []).empty?

      if opts[:version]
        puts "You are using EbookRenamer version #{EbookRenamer::VERSION}"
        exit
      end
      execute(opts)
    end

    desc "usage", "Display help screen"
    def usage
      puts <<-EOS
Usage:
  cli.rb rename [OPTIONS]

Options:
  -b, [--base-dir=BASE_DIR]                # Base directory
                                           # Default: /Users/agilecreativity/Dropbox/spikes/ebooks-renamer
  -e, [--exts=one two three]               # List of extensions to search for
  -f, [--non-exts=one two three]           # List of files without extension to search for
  -n, [--inc-words=one two three]          # List of words to be included in the result if any
  -x, [--exc-words=one two three]          # List of words to be excluded from the result if any
  -i, [--ignore-case], [--no-ignore-case]  # Match case insensitively
                                           # Default: true
  -r, [--recursive], [--no-recursive]      # Search for files recursively
                                           # Default: true
  -v, [--version], [--no-version]          # Display version information
  -s, [--sep-string=SEP_STRING]            # Separator string between words in filename
                                           # Default: .
  -c, [--commit], [--no-commit]            # Make change permanent

Rename multiple ebook files (pdf,epub,mobi)
      EOS
    end

    default_task :usage

    private

    # Rename the file from the given directory
    # Using the with the argurment options as follow
    #
    #   :base_dir  - the base directory
    #   :recursive - perform the rename recursively (true|false)
    #   :commit    - make the rename permanent (true|false)
    #   :exts      - list of extensions to be processed default to ['epub,mobi,pdf']
    #
    # @param args [Hash<Symbol, Object>] options argument
    def execute(options = {})
      meta_binary = "ebook-meta"

      input_files = CodeLister.files(options)

      if input_files.empty?
        puts "No file found for your option: #{options}"
        return
      end

      unless options[:commit]
        puts "Changes will not be applied without the --commit option."
      end

      input_files.each do |file|
        extension = File.extname(file)
        begin
          hash = meta_to_hash(meta(file, meta_binary))
          full_name = formatted_name(hash, sep_char: " by ")
          new_name  = "#{File.dirname(file)}/#{sanitize_filename(full_name, options[:sep_string])}#{extension}"
          puts "[#{file}] -> [#{new_name}]"
          FileUtils.mv(file,new_name) if options[:commit] && file != new_name
        rescue RuntimeError => e
          puts e.backtrace
          next
        end
      end
    end
  end
end
