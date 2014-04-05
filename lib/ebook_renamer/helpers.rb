require 'open3'
require 'fileutils'
require 'shellwords'

module EbookRenamer
  class Helpers

    EbookMetaNotInstall = Class.new(StandardError)

    class << self

      # Extract meta data from the input file using the ebook-meta tool
      #
      # @param [String] filename the input file name
      # @param [String] binary the executable for use to extract the metadata
      # @return [String] result of the output from running the command
      def meta(filename, binary = 'ebook-meta')
        raise EbookMetaNotInstall, "Need to install ebook-meta to use this gem" if which(binary).nil?
        command = [
          binary,
          Shellwords.escape(filename)
        ]

        stdout_str, stderr_str, status = Open3.capture3(command.join(" "))
        raise "Problem processing #{filename}" unless status.success?
        stdout_str
      end

      # Convert the output string to hash
      #
      # @param [String] text output string from the 'ebook-meta' command
      # @return [Hash<String,String>] hash pair for the input string
      def meta_to_hash(text)
        hash = {}
        return hash if text.nil?
        result_list = []

        text.split(/\n/).each do |meta|
          # split by the first ':' string
          list = meta.split /^(.*?):/

          # ignore the empty string element
          list.delete_at(0)

          unless list.empty?
            list.map(&:strip!)
            # downcase the first item to make it easy
            result_list << [list[0].downcase, list[1]]
            hash = Hash[*result_list.flatten]
          end
        end
        hash
      end

      # Clean the filename to remove the special characters
      #
      # @param [String] filename input file
      # @param [String] sep_char separator character to use
      #
      # @return [String] the new file name with special characters replaced or removed.
      def sanitize_filename(filename, sep_char = nil)
        dot = "."

        # Note exclude the '.' (dot)
        filename.gsub!(/[^0-9A-Za-z\-_ ]/, dot)

        # replace multiple occurrences of a given char with a dot
        ['-','_',' '].each do |c|
          filename.gsub!(/#{Regexp.quote(c)}+/, dot)
        end

        # replace multiple occurrence of dot with one dot
        filename.gsub!(/#{Regexp.quote(dot)}+/, dot)

        if sep_char
          # File.basename("demo.txt", ".*") #=> "demo"
          name_only = File.basename(filename, ".*")
          # File.extname("demo.txt")        #=> ".txt"
          ext_only = File.extname(filename)
          name_only.gsub!(/#{Regexp.quote(dot)}+/, sep_char)
          return "#{name_only}#{ext_only}"
        end

        filename.strip
      end

      # Cross-platform way of finding an executable in the $PATH.
      #
      # @param command [String] the command to look up
      # @return [String, NilClass] full path to the executable file or nil if the
      #  executable is not valid or available.
      # Example:
      #   which('ruby')           #=> /usr/bin/ruby
      #   which('bad-executable') #=> nil
      def which(command)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each { |ext|
            exe = File.join(path, "#{command}#{ext}")
            return exe if File.executable? exe
          }
        end
        return nil
      end

      # Return formatted file name using the metadata values
      #
      # @param [Hash<Symbol,String>] meta_hash output from the program 'ebook-meta' or 'exiftoo'
      # @param [Hash<Symbol,String>] fields list of fields that will be used to set the name
      def formatted_name(meta_hash = {}, fields = {})
        if hash.nil? || fields.nil?
          raise ArgumentError.new("Argument must not be nil")
        end

        # The keys that we get from the 'mdls' or 'exiftool'
        args = {
          keys: ['title',
                 'author(s)'],
          sep_char: ' '
        }.merge(fields)

        keys = args[:keys]
        sep_char = args[:sep_char]

        # Note: only show if we have the value for title
        result = []
        if meta_hash.fetch('title', nil)
          keys.each do |k|
            value = meta_hash.fetch(k, nil)
            # Note: don't add 'Author(s)' => 'Unknown' to keep the result clean
            if value && value.downcase != 'unknown'
              result << meta_hash[k]
            end
          end
          return result.join(sep_char)
        end
        # Note: if no title we choose to return empty value for result
        return ""
      end

      # Ensure that the values in hash are sanitized
      #
      # @param [Hash<Symbol,String>] hash input hash to be sanitized
      # @return [Hash<Symbol,String>] original hash with values sanitized
      # @see #sanitize_filename
      def sanitize_values(hash = {})
        hash.each do |key, value|
          hash[key] = sanitize_filename(value, " ")
        end
        hash
      end

      # List files base on given options
      # options:
      #  :recursive - process the directory recursively (default false)
      #  :exts - list of extensions to be search (default ['epub','mobi','pdf'])
      #
      # @param base_dir [String] the starting directory
      # @param options [Hash<Symbol,Object>] the options to be used
      # @return [List<String>] list of matching files or empty list if none are found
      def files(base_dir = Dir.pwd, options = {})
        args = {
          recursive: false,
          exts: %w(epub mobi pdf).join(',')
        }.merge(options)

        raise ArgumentError.new("Invalid directory #{base_dir}") unless File.directory?(base_dir)

        wildcard = args[:recursive] ? '**' : ''
        patterns = File.join(base_dir, wildcard, "*.{#{args[:exts]}}")
        Dir.glob(patterns) || []
      end
    end
  end
end
