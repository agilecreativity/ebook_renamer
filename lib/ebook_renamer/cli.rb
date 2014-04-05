module EbookRenamer
  class CLI

    attr_accessor :config

    # Constructor for the class
    #
    # @param [Configuration] config the configuration class
    def initialize(config = Configuration.new)
      @config = config
    end

    # Rename the file from the given directory
    # Using the with the argurment options as follow
    #   :recursive - perform the rename recursively (true|false)
    #   :commit    - make the rename permanent (true|false)
    #   :exts      - list of extensions to be processed default to ['epub,mobi,pdf']
    #
    # @param base_dir [String] base directory default to current directory
    # @param args [Hash<Symbol, Object>] options argument
    def rename(base_dir = Dir.pwd, args = {})
      options = {
        recursive: false,
        commit: false,
        exts: %w(epub mobi pdf).join(",")
      }.merge(args)

      input_files = Helpers.files(base_dir, options).sort

      unless options[:commit]
        puts "Changes will not be applied without the --commit option."
      end

      input_files.each do |file|
        extension = File.extname(file)
        begin
          hash = Helpers.meta_to_hash(Helpers.meta(file, config.meta_binary))
          formatted_name = Helpers.formatted_name(hash, sep_char: " by ")
          formatted_name = "#{formatted_name}#{extension}"
          new_name = "#{File.dirname(file)}/#{Helpers.sanitize_filename(formatted_name, config.sep_string)}"
          puts "[#{file}] -> [#{new_name}]"

          # TODO: handle this properly!
          # skip if the filename is too long '228'
          # see: https://github.com/rails/rails/commit/ad95a61b62e70b839567c2e91e127fc2a1acb113
          max_allowed_file_size = 220
          if new_name && new_name.size > max_allowed_file_size
            puts "FYI: skip file name too long [#{new_name.size}] : #{new_name}"
            next
          end

          FileUtils.mv(file,new_name) if options[:commit] && file != new_name && new_name.size < max_allowed_file_size
        rescue RuntimeError => e
          puts e.backtrace
          next
        end
      end
    end
  end
end
