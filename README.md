## EbookRenamer

Simple utility to perform bulk rename of the ebooks(epub,mobi,pdf) based on
the metadata within the ebook itself (if available).

### Installation

* You will need to install the [Calibre](http://www.calibre-ebook.com/) and
  [Calibre CLI](http://manual.calibre-ebook.com/cli/cli-index.html)

* Then install the gem

```sh
$bundle
$gem install ebook_renamer
```

### Usage

Run the following command from the directory that contain the file(s) that
you want to rename.

```sh
# cd to the directory containing the file you like to rename
cd ~/Dropbox/ebooks/

# or specify the directory as an option
ebook_renamer --base-dir ~/Dropbox/ebooks/samples

# If you like to see the usage try
ebook_renamer --help

# Run the command without to see what will be changed without making any changes (dry-run)
ebook_rename  --recursive

# Once you are happy with what you see, then
ebook_renamer --recusive --commit
```

### Output of `ebook_renamer --help`

```
 Usage: ebook_renamer [options]

 Examples:

  1) $ebook_renamer

  2) $ebook_renamer --base-dir ~/Dropbox/ebooks

  3) $ebook_renamer --base-dir ~/Dropbox/ebooks
                    --recursive

  4) $ebook_renamer --base-dir ~/Dropbox/ebooks
                    --recursive

  5) $ebook_renamer --base-dir ~/Dropbox/ebooks
                    --recursive
                    --commit
 Options:

    -b, --base-dir directory         Starting directory [default - current directory]
    -r, --recursive                  Process the files recursively [default - false]
    -c, --commit                     Perform the actual rename [default - false]
    -v, --version                    Display version number
    -h, --help                       Display this screen
```

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
