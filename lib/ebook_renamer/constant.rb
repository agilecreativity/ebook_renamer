module EbookRenamer
  # The Calibre metadata extraction tool (epub, mobi)
  CALIBRE_CLI_BINARY = '/usr/bin/ebook-meta'

  # The Calibre metadata extraction tool
  CALIBRE_META_CLI = '/usr/bin/ebook-meta'

  # Support URL for Calibre's CLI tool
  CALIBRE_CLI_URL = 'http://manual.calibre-ebook.com/cli/cli-index.html'

  # Exiftool binary executable (for pdf, also `mdls` on OSX)
  EXIFTOOL_BINARY = '/usr/local/bin/exiftool'

  # On OSX, `brew install exiftool`
  EXIFTOOL_URL = 'http://www.sno.phy.queensu.ca/~phil/exiftool/'

  # Attribute keys
  META_KEYS = %w[title authors(s) publisher languages published rights identifiers]
end
