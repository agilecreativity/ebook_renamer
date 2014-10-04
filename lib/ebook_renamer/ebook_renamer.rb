module EbookRenamer
  # Extract meta data from the input file using the ebook-meta tool
  #
  # @param [String] filename the input file name
  # @param [String] binary the executable for use to extract the metadata
  # @return [String] result of the output from running the command
  def meta(filename, binary = "ebook-meta")
    fail Errors::EbookMetaNotInstall, "Need to install ebook-meta to use this gem" if AgileUtils::Helper.which(binary).nil?
    command = [
      binary,
      Shellwords.escape(filename)
    ]

    stdout_str, stderr_str, status = Open3.capture3(command.join(" "))
    fail "Problem processing #{filename}" unless status.success?
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

  # Return formatted file name using the metadata values
  #
  # @param [Hash<Symbol,String>] meta_hash output from the program 'ebook-meta' or 'exiftoo'
  # @param [Hash<Symbol,String>] fields list of fields that will be used to set the name
  def formatted_name(meta_hash = {}, fields = {})
    if hash.nil? || fields.nil?
      fail ArgumentError.new("Argument must not be nil")
    end
    # Let's not continue if we have no title metadata
    fail "No title found" unless meta_hash.fetch("title", nil)

    # The keys that we get from the 'mdls' or 'exiftool'
    args = {
      keys: [
        "title",
        "author(s)"
      ],
      sep_char: " "
    }.merge(fields)

    keys = args[:keys]
    sep_char = args[:sep_char]

    # Note: only show if we have the value for title
    result = []
    keys.each do |key|
      value = meta_hash.fetch(key, nil)
      # Note: don't add 'Author(s)' => 'Unknown' to keep the result clean
      if value && value.downcase != "unknown"
        result << meta_hash[key]
      end
    end
    result.join(sep_char)
  end
end
