require 'agile_utils'
require 'code_lister'
require 'fileutils'
require_relative '../ebook_renamer'
module EbookRenamer
  class CLI < Thor
    desc 'rename', 'Rename multiple ebook files (pdf,epub,mobi) from a given directory'
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::RECURSIVE
    method_option :sep_string,
                  aliases: '-s',
                  desc: 'Separator string between words in output filename',
                  default: '.'
    method_option :commit,
                  aliases: '-c',
                  desc: 'Make change permanent',
                  type: :boolean,
                  default: false
    method_option *AgileUtils::Options::VERSION
    def rename
      opts = options.symbolize_keys
      # Explicitly add the :exts options
      opts[:exts] = %w(pdf epub mobi)
      if opts[:version]
        puts "You are using EbookRenamer version #{EbookRenamer::VERSION}"
        exit
      end
      execute(opts)
    end

    desc 'usage', 'Display help screen'
    def usage
      puts <<-EOS
Usage:
  ebook_renamer rename

Options:
  -b, [--base-dir=BASE_DIR]            # Base directory
                                       # Default: . (current directory)
  -r, [--recursive], [--no-recursive]  # Search for files recursively
                                       # Default: true
  -s, [--sep-string=SEP_STRING]        # Separator string between words in output filename
                                       # Default: .
  -c, [--commit], [--no-commit]        # Make change permanent
  -v, [--version], [--no-version]      # Display version information

Rename multiple ebook files (pdf,epub,mobi) from a given directory
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
      meta_binary = 'ebook-meta'

      input_files = CodeLister.files(options)

      if input_files.empty?
        puts "No file found for your option: #{options}"
        return
      end

      unless options[:commit]
        puts 'Changes will not be applied without the --commit option.'
      end

      FileUtils.chdir(options[:base_dir])
      input_files.each_with_index do |file, index|
        extension = File.extname(file)
        begin
          hash = meta_to_hash(meta(file, meta_binary))
          full_name = formatted_name(hash, sep_char: ' by ')
          new_name  = "#{File.dirname(file)}/#{sanitize_filename(full_name, options[:sep_string])}#{extension}"
          puts "#{index + 1} of #{input_files.size}::[#{file}] -> [#{new_name}]"
          FileUtils.mv(file, new_name) if options[:commit] && file != new_name
        rescue RuntimeError => e
          puts e.backtrace
          next
        end
      end
    end
  end
end
