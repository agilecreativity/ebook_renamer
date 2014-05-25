require "agile_utils"
require "code_lister"
require "fileutils"
require_relative "../ebook_renamer"
module EbookRenamer
  class CLI < Thor
    desc "rename", "Rename multiple ebook files (pdf,epub,mobi) from a given directory"
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::RECURSIVE
    method_option :sep_string,
                  aliases: "-s",
                  desc: "Separator string between words in output filename",
                  default: "."
    method_option :commit,
                  aliases: "-c",
                  desc: "Make change permanent",
                  type: :boolean,
                  default: false
    method_option *AgileUtils::Options::VERSION
    def rename
      opts = options.symbolize_keys
      # Explicitly add the :exts options
      opts[:exts] = %w[pdf epub mobi]
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
  ebook_renamer

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
    #
    # @param args [Hash<Symbol, Object>] options argument
    # possible options
    #  :base_dir  - the base directory
    #  :recursive - perform the rename recursively (true|false)
    #  :commit    - make the rename permanent (true|false)
    #  :exts      - list of extensions to be processed default to ['epub,mobi,pdf']
    def execute(options = {})
      input_files = CodeLister.files(options)
      if input_files.empty?
        puts "No file found for your option: #{options}"
        return
      end
      unless options[:commit]
        puts "-----------------------------------------------------------"
        puts " FYI: no changes as this is a dry-run, please use --commit "
        puts "-----------------------------------------------------------"
      end

      FileUtils.chdir(options[:base_dir])
      input_files.each_with_index do |file, index|
        input_file = File.expand_path(file)
        begin
          metadata  = meta(input_file, "ebook-meta")
          meta_hash = meta_to_hash(metadata)
          compare_and_rename(input_file, meta_hash, options, index, input_files.size)
        rescue RuntimeError => e
          puts e.backtrace
          next
        end
      end
    end

    def compare_and_rename(input_file, meta_hash, options, index, total)
      if identical_name?(input_file, meta_hash)
        puts "#{index + 1} of #{total} skip name: #{input_file} [no title found or file is identical]"
        return
      end
      output_file = compute_name(input_file, meta_hash, options)
      if input_file != output_file
        puts "#{index + 1} of #{total} old name : #{input_file}"
        puts "#{index + 1} of #{total} new name : #{output_file}"
        FileUtils.mv(input_file, output_file) if options[:commit]
      else
        puts "#{index + 1} of #{total} skip name: #{input_file} [file is identical]"
      end
    end

    # Check and return if we have the title or
    # if the title is the same as the input name
    def identical_name?(input_file, meta_hash = {})
      meta_hash["title"] == File.basename(input_file, ".*")
    end

    # Compute the new name from metadata
    #
    # @todo make use of filename cleaner gem
    def compute_name(input_file, meta_hash, options)
      extension = File.extname(input_file)
      name = formatted_name(meta_hash, sep_char: " by ")
      name = sanitize_filename(name, options[:sep_string])
      name = "#{File.dirname(input_file)}/#{name}#{extension}"
      File.expand_path(name)
    end
  end
end
