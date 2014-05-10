## ebook_renamer

[![Gem Version](https://badge.fury.io/rb/ebook_renamer.svg)](http://badge.fury.io/rb/ebook_renamer)
[![Dependency Status](https://gemnasium.com/agilecreativity/ebook_renamer.png)](https://gemnasium.com/agilecreativity/ebook_renamer)
[![Code Climate](https://codeclimate.com/github/agilecreativity/ebook_renamer.png)](https://codeclimate.com/github/agilecreativity/ebook_renamer)

Perform bulk rename of ebook files (epub,mobi,pdf) based on the embedded metadata (title, author(s)).
This version depends on the opensource software called [Calibre][] which provide the tools
called [Calibre CLI][] which is very easy to install on OSX or Linux system.

### How the file is renamed

The file will be renamed using the following format `<title>.by.<author(s)>`.`<extension>`

Also the final file name will be sanitized e.g. any multiple occurence of special characters will be
replace by one dot `.`.

For example if the ebook contain the title `Start with Why: How Grate Leader Inspire Everyone to Take Action`
and the author is `Simon Sinek` then the default output will be
`Start.with.Why.How.Great.Leader.Inspire.Everyone.to.Take.Action.by.Simon.Sinek.pdf`
Note that the `:` and one space before the word `How` is replaced with just one dot string.

if the `--sep-string _` is used then the output will be
`Start_with_Why_How_Great_Leader_Inspire_Everyone_to_Take_Action_by_Simon_Sinek.pdf`.

### What you will need

* You will need to install the [Calibre](http://www.calibre-ebook.com/) and
  [Calibre CLI](http://manual.calibre-ebook.com/cli/cli-index.html) on your OS.

  In particular the gem is looking for the `ebook-meta` binary in a path.
  If this is not installed the error will be raised.

* Linux or Mac OSX operating system

### Installation and Usage:

```sh
bundle
gem install ebook_renamer
```

### Quick Usage

The shortest command that you can run to rename files is

```sh
# This will rename any ebook files under the directory `~/Dropbox/ebooks`
# and any sub-directory for (*.epub, *.pdf, *.mobi) using the default settings
cd ~/Dropbox/ebooks
ebook_renamer rename --commit
```

To see what the result would be like without making any changes to any files

```sh
cd ~/Dropbox/ebooks
ebook_renamer rename
```
Which should produce something like

```
```
### Detail Usage

Run the following command from the directory that contain the file(s) that
you want to rename.

```sh
# Cd to the directory containing the file(s) you like to rename
$cd ~/Dropbox/ebooks/

# Or specify the directory as an option from any where you have access to the gem
$ebook_renamer rename --base-dir ~/Dropbox/ebooks/samples

# For help on how to use the gem just type without any options.
$ebook_renamer

# Run the command without making any changes to the files (dry-run) in the current directory
$ebook_renamer rename --base-dir . --recursive

# Once you are happy with the result then
$ebook_renamer rename --base-dir . --recursive --commit

or the short version

$ebook_renamer rename -b . -r -c
```

### Example Outputs

Original files before

```
test/fixtures/
└── ebooks
    ├── demo1.pdf
    ├── demo2.epub
    └── subdir
        ├── demo1.pdf
        └── demo2.epub
2 directories, 4 files
```

Run the command without making any changes

```sh
ebook_renamer rename --base-dir ./test/fixtures/ebooks --recursive
```

You should see the result like the following

```
Changes will not be applied without the --commit option.
[test/fixtures/ebooks/demo1.pdf] -> [test/fixtures/ebooks/Fearless.Refactoring.by.Andrzej.Krzywda.pdf]
[test/fixtures/ebooks/demo2.epub] -> [test/fixtures/ebooks/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub]
[test/fixtures/ebooks/subdir/demo1.pdf] -> [test/fixtures/ebooks/subdir/Reliably.Deploying.Rails.Applications.by.Ben.Dixon.pdf]
[test/fixtures/ebooks/subdir/demo2.epub] -> [test/fixtures/ebooks/subdir/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub]
```

To actually make the actual rename just pass in the `--commit` option like so:

```sh
./bin/ebook_renamer rename --base-dir ./test/fixtures/ebooks --recursive --commit
```
or the short version

```sh
./bin/ebook_renamer rename -b ./test/fixtures/ebooks -r -c
```

The final output should be something like:

```
test/fixtures/
└── ebooks
    ├── Fearless.Refactoring.by.Andrzej.Krzywda.pdf
    ├── EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
    └── subdir
        ├── Fearless.Refactoring.by.Andrzej.Krzywda.pdf
        └── EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
2 directories, 4 files
```

### Sample Usage

To get the help just type `ebook_renamer` without any argument

```
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
```

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
