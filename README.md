ebook_renamer
=============

[![Gem Version](https://badge.fury.io/rb/ebook_renamer.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/ebook_renamer.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/ebook_renamer.png)][codeclimate]

[gem]: http://badge.fury.io/rb/ebook_renamer
[gemnasium]: https://gemnasium.com/agilecreativity/ebook_renamer
[codeclimate]: https://codeclimate.com/github/agilecreativity/ebook_renamer

Perform bulk rename of ebook files (epub,mobi,pdf) based on the embedded metadata (title, author(s)).
This version depends on the opensource software called [Calibre][] that comes
with [Calibre CLI][] which is very easy to install on OSX or Linux system.

Note: start from version `0.1.7` this gem will release based on [Semantic Versioning][] version.

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

* You will need to install the [Calibre][] and
  [Calibre CLI][] on your OS.

  In particular the gem is looking for the `ebook-meta` binary in a path.
  If this is not installed the error will be raised.

* Linux or Mac OSX operating system

### Installation and Usage:

```sh
gem install ebook_renamer

# Show the list of options
ebook_renamer
```

### Quick Usage

The shortest command that you can run to rename files is

```sh
# This will rename any ebook files under the directory `~/Dropbox/ebooks`
# and any sub-directory for (*.epub, *.pdf, *.mobi) using the default settings
cd ~/Dropbox/ebooks
ebook_renamer --commit
```

To see what the result would be like without making any changes

```sh
cd ~/Dropbox/ebooks/
ebook_renamer --base-dir .
```

Should see the result like

```
-----------------------------------------------------------
 FYI: no changes as this is a dry-run, please use --commit
-----------------------------------------------------------
1 of 4 old name : ./demo1.pdf
1 of 4 new name : ./Fearless.Refactoring.by.Andrzej.Krzywda.pdf
2 of 4 old name : ./demo2.epub
2 of 4 new name : ./EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
3 of 4 old name : ./subdir/demo3.pdf
3 of 4 new name : ./subdir/Reliably.Deploying.Rails.Applications.by.Ben.Dixon.pdf
4 of 4 old name : ./subdir/demo4.epub
4 of 4 new name : ./subdir/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
```

with `--sep-string` option

```sh
cd ~/Dropbox/ebooks/
ebook_renamer --base-dir . --sep-string _
```

Should see the result like

```
-----------------------------------------------------------
 FYI: no changes as this is a dry-run, please use --commit
-----------------------------------------------------------
1 of 4 old name : ./demo1.pdf
1 of 4 new name : ./Fearless_Refactoring_by_Andrzej_Krzywda.pdf
2 of 4 old name : ./demo2.epub
2 of 4 new name : ./EPUB_3_0_Specification_by_EPUB_3_Working_Group.epub
3 of 4 old name : ./subdir/demo3.pdf
3 of 4 new name : ./subdir/Reliably_Deploying_Rails_Applications_by_Ben_Dixon.pdf
4 of 4 old name : ./subdir/demo4.epub
4 of 4 new name : ./subdir/EPUB_3_0_Specification_by_EPUB_3_Working_Group.epub
```

### Detail Usage

Run the following command from the directory that contain the file(s) that
you want to rename.

```sh
# Cd to the directory containing the file(s) you like to rename
cd ~/Dropbox/ebooks/

# Or specify the directory as an option from any where if you set appropriate
# version of ruby (e.g. rbenv local 2.1.1 or rvm use 2.1.1)
ebook_renamer --base-dir ~/Dropbox/ebooks/samples

# For help on how to use the gem just type without any options.
ebook_renamer

# Run the command without making any changes to the files (dry-run) in the current directory
ebook_renamer --base-dir . --recursive

# Once you are happy with the result then
ebook_renamer --base-dir . --recursive --commit

# Or using the short version
ebook_renamer -b . -r -c
```

### Misc Options
In addition to the above usage, you can also use the two new flags `--downcase` or
`--capitalize`

```shell
# Lowercase each word in the result filename
ebook_renamer --base-dir . --recursive --downcase --commit

# Capitalize each word in the result filename
ebook_renamer --base-dir . --recursive --capitalize --commit
```

### Usage/Synopsis

```
Usage:
  ebook_renamer

Options:
  -b, [--base-dir=BASE_DIR]              # Base directory
                                         # Default: . (current directory)
  -r, [--recursive], [--no-recursive]    # Search for files recursively
                                         # Default: --recursive
  -s, [--sep-string=SEP_STRING]          # Separator string between words in output filename
                                         # Default: . (dot string)
  -d, [--downcase], [--no-downcase]      # Convert each word in the filename to lowercase
                                         # Default: --no-downcase
  -t, [--capitalize], [--no-capitalize]  # Capitalize each word in the filename
                                         # Default: --no-capitalize
  -c, [--commit], [--no-commit]          # Make change permanent
                                         # Default: --no-commit
  -v, [--version], [--no-version]        # Display version information

Rename multiple ebook files (pdf,epub,mobi) from a given directory

```

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

[Calibre]: http://www.calibre-ebook.com/
[Calibre CLI]: http://manual.calibre-ebook.com/cli/cli-index.html
[Semantic Versioning]: http://semver.org
