## Ebook_Renamer

Simple utility to perform bulk rename of the ebooks(epub,mobi,pdf) based on
the metadata within the ebook itself (if available).

### Why do I wrote this gem

Almost always, when I get an ebook it does not have a good file name.
This is very annoying as it does not work well when you want to search for it later.

I wrote this gem just to make it possible to rename multiple ebook files at once using the
available meta-data from each file. I like to be able to use this on the single folder or recursively from
a given folder.

### How the file is renamed

The file will be renamed using the following format `<title>.by.<author(s)>`.`<extension>`

Also the final file name will be sanitized e.g. any multiple occurence of special characters will be
replace by one dot `.`.

For example if the ebook contain the title `Start with Why: How Grate Leader Inspire Everyone to Take Action`
and the author is `Simon Sinek` then the default output will be `Start.with.Why.How.Great.Leader.Inspire.Everyone.to.Take.Action.by.Simon.Sinek.pdf`
Note that the `:` and one space before the word `How` is replaced with just one dot string.

if the `--sep-string` is used then the output will be `Start_with_Why_How_Great_Leader_Inspire_Everyone_to_Take_Action_by_Simon_Sinek.pdf` for `--sep-string _` argument.

### What you will need

* You will need to install the [Calibre](http://www.calibre-ebook.com/) and
  [Calibre CLI](http://manual.calibre-ebook.com/cli/cli-index.html) on your OS.

* Linux or Mac OSX operating system

### Installation and Usage:

```sh
bundle
gem install ebook_renamer
```

### Usage

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

# Once you are happy with what result then
$ebook_renamer rename --base-dir . --recursive --commit
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
./bin/ebook_renamer rename --base-dir ./test/fixtures/ebooks --recursive
```

You should see the result like the following

```
Your argument: {:base_dir=>".", :exts=>["pdf", "epub", "mobi"], :sep_string=>".", :commit=>false, :recursive=>true, :version=>false}
Changes will not be applied without the --commit option.
[./test/fixtures/ebooks/demo1.pdf] -> [./test/fixtures/ebooks/Fearless.Refactoring.by.Andrzej.Krzywda.pdf]
[./test/fixtures/ebooks/demo2.epub] -> [./test/fixtures/ebooks/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub]
[./test/fixtures/ebooks/subdir/demo1.pdf] -> [./test/fixtures/ebooks/subdir/Reliably.Deploying.Rails.Applications.by.Ben.Dixon.pdf]
[./test/fixtures/ebooks/subdir/demo2.epub] -> [./test/fixtures/ebooks/subdir/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub]
```

To actually make the actual rename just pass in the `--commit` option like

```sh
./bin/ebook_renamer rename --base-dir ./test/fixtures/ebooks --recursive --commit
./bin/ebook_renamer rename -b ./test/fixtures/ebooks -r -c
```

The final output should be like

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

```
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
```

### Changelog

#### 0.0.8

- Use Thor instead of OptionParser for parsing of options

#### 0.0.2 - 0.0.7

- Improvement of code and fix the few bugs a long the way

#### 0.0.1

- Initial release

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
