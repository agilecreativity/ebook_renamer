require "agile_utils"
require "code_lister"
require "filename_cleaner"
require "fileutils"
require_relative "../ebook_renamer"
module EbookRenamer
  class CLI < Thor
    using AgileUtils::HashExt

    desc "rename", "Rename multiple ebook files (pdf,epub,mobi) from a given directory"
    method_option *AgileUtils::Options::BASE_DIR
    method_option *AgileUtils::Options::RECURSIVE
    method_option :sep_string,
                  aliases: "-s",
                  desc: "Separator string between each word in output filename",
                  default: "."
    method_option :downcase,
                  aliases: "-d",
                  type: :boolean,
                  desc: "Convert each word in the output filename to lowercase",
                  default: false
    method_option :capitalize,
                  type: :boolean,
                  aliases: "-t",
                  desc: "Capitalize each word in the output filename",
                  default: false
    method_option :commit,
                  aliases: "-c",
                  desc: "Make your changes permanent",
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
  -b, [--base-dir=BASE_DIR]              # Base directory
                                         # Default: . (current directory)
  -r, [--recursive], [--no-recursive]    # Search for files recursively
                                         # Default: --recursive
  -s, [--sep-string=SEP_STRING]          # Separator string between each word in output filename
                                         # Default: '.' (dot string)
  -d, [--downcase], [--no-downcase]      # Convert each word in the output filename to lowercase
                                         # Default: --no-downcase
  -t, [--capitalize], [--no-capitalize]  # Capitalize each word in the output filename
                                         # Default: --no-capitalize
  -c, [--commit], [--no-commit]          # Make your changes permanent
                                         # Default: --no-commit
  -v, [--version], [--no-version]        # Display version information

Rename multiple ebook files (pdf,epub,mobi) from a given directory

      EOS
    end

    default_task :usage

    private

    # Rename the file from the given directory
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
        base_name = File.basename(input_file, ".*")
        name = downcase_or_capitalize(base_name, options)
        name = "#{File.dirname(input_file)}/#{name}#{File.extname(input_file)}"
        output_file = File.expand_path(name)
      else
        output_file = compute_name(input_file, meta_hash, options)
      end
      rename_if_not_the_same(input_file, output_file, index:  index,
                                                      total:  total,
                                                      commit: options[:commit])
    end

    def rename_if_not_the_same(input_file, output_file, options = {})
      index  = options[:index]
      total  = options[:total]
      commit = options[:commit]
      if input_file != output_file
        puts "#{index + 1} of #{total} old name : #{input_file}"
        puts "#{index + 1} of #{total} new name : #{output_file}"
        if commit
          if File.exist?(output_file)
            puts "#{index + 1} of #{total} skip     : #{output_file} [File exist locally]"
          else
            FileUtils.mv(input_file, output_file)
          end
        end
      else
        puts "#{index + 1} of #{total} skip name: #{input_file} [title is the same as the filename]"
      end
    end

    # Check and return if we have the title or
    # if the title is the same as the input name
    def identical_name?(input_file, meta_hash = {})
      meta_hash["title"] == File.basename(input_file, ".*")
    end

    # Compute the new name from metadata
    #
    def compute_name(input_file, meta_hash, options)
      extension = File.extname(input_file)
      name = formatted_name(meta_hash, sep_char: " by ")
      name = FilenameCleaner.sanitize(name, options[:sep_string], false)
      name = downcase_or_capitalize(name, options)
      name = "#{File.dirname(input_file)}/#{name}#{extension}"
      File.expand_path(name)
    end

    # Post processing of the name
    def downcase_or_capitalize(name, options)
      downcase   = options[:downcase]
      capitalize = options[:capitalize]
      sep_string = options[:sep_string]
      if capitalize
        name = name.split(sep_string).map(&:capitalize).join(sep_string)
      else
        if downcase
          name = name.split(sep_string).map(&:downcase).join(sep_string)
        end
      end
      name
    end
  end
end
