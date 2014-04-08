require 'thor'
require 'ap'
module EbookRenamer
  class Command < Thor
    desc "rename", "Rename ebook files (pdf,epub,mobi)"

    method_option :base_dir,
                  aliases: "-b",
                  desc: "Base directory",
                  default: Dir.pwd

    method_option :exts,
                  aliases: "-e",
                  desc: "List of extensions to search for",
                  type: :array,
                  default: %w(pdf epub mobi)

    method_option :sep_string,
                  aliases: "-s",
                  desc: "Separator string between words in filename",
                  default: "."

    method_option :commit,
                  aliases: "-c",
                  desc: "Make change permanent",
                  type: :boolean,
                  default: false

    method_option :recursive,
                  aliases: "-r",
                  desc: "Search for files recursively",
                  type: :boolean,
                  default: false

    method_option :version,
                  aliases: "-v",
                  desc: "Display version information",
                  type: :boolean,
                  default: false

    def rename
      args = options.symbolize_keys
      puts "Your argument: #{args}"

      if options[:version]
        puts EbookRenamer::VERSION
        exit
      end

      execute(args)
    end

    desc "help", "Display help screen"
    def help
      puts <<-EOS
Usage:
  ebook_renamer rename

Options:
  -b, [--base-dir=BASE_DIR]            # Base directory
                                       # Default: /home/bchoomnuan/Dropbox/spikes/ebooks-renamer
  -e, [--exts=one two three]           # List of extensions to search for
                                       # Default: ["pdf", "epub", "mobi"]
  -s, [--sep-string=SEP_STRING]        # Separator string between words in filename
                                       # Default: .
  -c, [--commit], [--no-commit]        # Make change permanent
  -r, [--recursive], [--no-recursive]  # Search for files recursively
  -v, [--version], [--no-version]      # Display version information

Rename ebook files (pdf,epub,mobi)
      EOS
    end

    default_task :help

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
    def execute(args = {})
      meta_binary = "ebook-meta"
      options = default_options.merge(args)

      input_files = files(options[:base_dir], options).sort

      if input_files.empty?
        puts "No file found for your option:", options
        ap options
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

    def default_options
      options = {
        base_dir: Dir.pwd,
        recursive: false,
        commit: false,
        exts: %w(epub mobi pdf),
        sep_string: '.'
      }
    end
  end
end
