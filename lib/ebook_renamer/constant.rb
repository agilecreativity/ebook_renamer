module EbookRenamer
  # The Calibre metadata extraction tool (epub, mobi, pdf)
  CALIBRE_CLI_BINARY = '/usr/bin/ebook-meta'

  # The Calibre metadata extraction tool
  CALIBRE_META_CLI = '/usr/bin/ebook-meta'

  # Support URL for Calibre's CLI tool
  CALIBRE_CLI_URL = 'http://manual.calibre-ebook.com/cli/cli-index.html'

  # Attribute keys
  META_KEYS = %w[title authors(s) publisher languages published rights identifiers]
end
