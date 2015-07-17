ebook_renamer
=============

[![Gem Version](https://badge.fury.io/rb/ebook_renamer.svg)][gem]
[![Dependency Status](https://gemnasium.com/agilecreativity/ebook_renamer.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/agilecreativity/ebook_renamer.png)][codeclimate]

[gem]: http://badge.fury.io/rb/ebook_renamer
[gemnasium]: https://gemnasium.com/agilecreativity/ebook_renamer
[codeclimate]: https://codeclimate.com/github/agilecreativity/ebook_renamer

Bulk rename of ebook files (epub,mobi,pdf) using embedded meta-data (title, author(s)).
This version depends on the opensource software called [Calibre][] that comes
with [Calibre CLI][] which is very easy to install on OSX or Linux system.

Release based on [Semantic Versioning][] version.

### How the file is renamed

The file will be renamed using the following format `<title>.by.<author(s)>`.`<extension>`

Also the final file name will be sanitized e.g. any multiple occurence of special characters will be
replace by given separator char (default to dot) .

For example if the ebook contain the title `Start with Why: How Grate Leader Inspire Everyone to Take Action`
and the author is `Simon Sinek` then the default output will be
`Start.with.Why.How.Great.Leader.Inspire.Everyone.to.Take.Action.by.Simon.Sinek.pdf`
Note that the `:` and one space before the word `How` is replaced by one dot string.

If the `--sep-string _` is used then the above output will be
`Start_with_Why_How_Great_Leader_Inspire_Everyone_to_Take_Action_by_Simon_Sinek.pdf`.

### What you will need

- You will need to install [Calibre][] and
  [Calibre CLI][] on your OS. Please download Calibre binary from [http://calibre-ebook.com/download][]

Alternatively if you are using Ubuntu try:

```shell
sudo apt-get install calibre calibre-bin

# check your installation
which ebook-meta #=> /usr/bin/ebook-meta
```

In particular the gem is looking for the `ebook-meta` binary in a path.
If this is not installed the error will be raised.

#### Tips for OSX installation

If you install using the binary above you will need to create a symlink to the
`ebook-meta` binary like the following:

```shell
# Assume that /usr/local/bin is in your $PATH varaiable
cd /usr/local/bin
sudo ln -fs /Applications/calibre.app/Contents/MacOS/ebook-meta /usr/local/bin/ebook-meta
source ~/.zshrc # or source ~/.bashrc
which ebook-meta
```

### Installation and Usage:

```sh
gem install ebook_renamer

# Show the list of options
ebook_renamer
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
  -s, [--sep-string=SEP_STRING]          # Separator string between each word in output filename
                                         # Default: '_' (underscore)
  -d, [--downcase], [--no-downcase]      # Convert each word in the output filename to lowercase
                                         # Default: --no-downcase
  -t, [--capitalize], [--no-capitalize]  # Capitalize each word in the output filename
                                         # Default: --no-capitalize
  -c, [--commit], [--no-commit]          # Make your changes permanent
                                         # Default: --no-commit
  -v, [--version], [--no-version]        # Display version information

Rename multiple ebook files (pdf,epub,mobi) from a given directory
```

### Quick Usage

The shortest command that you can run to rename files is

```sh
# This will rename any ebook files under the directory `~/Dropbox/ebooks`
# and any sub-directory for (*.epub, *.pdf, *.mobi) using the default settings
cd ~/Dropbox/ebooks
ebook_renamer --commit
```

To see what the result would be like without making any changes (dry-run)

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

should result in something like

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
ebook_renamer --base-dir . --sep-string '_' --recursive --downcase --commit
```

will produce the result filename like `start_with_why_how_great_leader_inspire_everyone_to_take_action_by_simon_sinek.pdf`.

```shell
# Capitalize each word in the result filename
ebook_renamer --base-dir . --sep-string '_' --recursive --capitalize --commit
```

will produce the result filename like `Start_With_Why_How_Great_Leader_Inspire_Everyone_To_Take_Action_by_Simon_Sinek.pdf`.

### Alternative

- Check out my other gem called [ebooks_renamer][] which provides similar functionality but implemented in pure ruby.
- [ebooks_renamer][] does not rely on the external software like [Calibre CLI][] to be install before use!

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

[Calibre]: http://www.calibre-ebook.com/
[Calibre CLI]: http://manual.calibre-ebook.com/cli/cli-index.html
[http://calibre-ebook.com/download]: http://calibre-ebook.com/download
[ebooks_renamer]: http://rubygems.org/gems/ebooks_renamer
[Semantic Versioning]: http://semver.org
