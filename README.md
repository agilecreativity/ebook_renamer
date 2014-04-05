## Ebook_Renamer

Simple utility to perform bulk rename of the ebooks(epub,mobi,pdf) based on
the metadata within the ebook itself (if available).

### Why do I wrote this gem

Almost always when I purchase an ebook (or download a file from the internet) it always came with the
bad name. I really like the meaningful name to the file that I have and really hate to rename them manually.

I wrote this gem just to make it easy to rename the files in bulk and recursively.

This gem will rename any ebook files (pdf, epub, mobi) using the available
meta-data that embedded within them.

So if you don't like to spend time renaming them manually then this gem is for you.

### How the file is renamed

The file will be renamed using the following format `<title>.by.<author(s)>`.`<extension>`

Also the final file name will be sanitized e.g. any multiple occurence of special characters will be
replace by one dot `.`.

For example if the meta-data of the ebook contain the title `Start with Why: How Grate Leader Inspire Everyone to Take Action`
and the author is `Simon Sinek` then the output will be `Start.with.Why.How.Great.Leader.Inspire.Everyone.to.Take.Action.by.Simon.Sinek.pdf`
Note that the `:` and one space before the word `How` is replaced with just one dot string.

### What you will need

* You will need to install the [Calibre](http://www.calibre-ebook.com/) and
  [Calibre CLI](http://manual.calibre-ebook.com/cli/cli-index.html) on your OS.

* Linux or Mac OSX operating system

### Problems/Issues

- Error may be raised if the combined meta-data is too long.
e.g. if your files is stored in NTFS drive then you may get the error indicate the file is too long
or something similar. I will try to handle this error in the next few release.

### Installation and Usage:

```sh
bundle
gem install ebook_renamer
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

# Run the command without making any changes to the files (dry-run)
ebook_rename  --recursive

# Once you are happy with what you see, then
ebook_renamer --recusive --commit
```

### Example Outputs

Original files before

```
test/fixtures/
└── ebooks
    ├── demo1.pdf
    ├── demo2.epub
    └── subdir
        ├── demo3.pdf
        └── demo4.epub
2 directories, 4 files
```

Run the command without making any changes

```sh
./bin/ebook_renamer --base-dir ./test/fixtures/ebooks --recursive
```

You should see the result like the following

```
Your options: {:base_dir=>"test/fixtures/ebooks/", :meta_binary=>"ebook-meta", :recursive=>true, :commit=>false}
Input :test/fixtures/ebooks/demo1.pdf
Output:test/fixtures/ebooks/Fearless.Refactoring.by.Andrzej.Krzywda.pdf
Input :test/fixtures/ebooks/demo2.epub
Output:test/fixtures/ebooks/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
Input :test/fixtures/ebooks/subdir/demo3.pdf
Output:test/fixtures/ebooks/subdir/Reliably.Deploying.Rails.Applications.by.Ben.Dixon.pdf
Input :test/fixtures/ebooks/subdir/demo4.epub
Output:test/fixtures/ebooks/subdir/EPUB.3.0.Specification.by.EPUB.3.Working.Group.epub
```

To actually rename the files using the following command

```sh
./bin/ebook_renamer --base-dir ./test/fixtures/ebooks --recursive --commit
# or short version
./bin/ebook_renamer -b ./test/fixtures/ebooks -r -c
```

Note:

The file will be renamed using the following format `<title>.by.<author(s)>`.`<extension>`
Also the final file name will be sanitized e.g. any special characters will be
converted to one dot `.`.

For example if the title is `Start with Why: How Grate Leader Inspire Everyone to Take Action` and the author is `Simon Sinek` then
the output will be something like `Start.with.Why.How.Great.Leader.Inspire.Everyone.to.Take.Action.by.Simon.Sinek.pdf` etc.

### Sample Usage (from `ebook_renamer --help`)

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

  6) $ebook_renamer --base-dir ~/Dropbox/ebooks
                    --recursive
                    --commit

  7) $ebook_renamer --base-dir ~/Dropbox/ebooks
                    --recursive
                    --sep-string '_'
                    --commit
 Options:

    -b, --base-dir directory         Starting directory [default - current directory]
    -s, --sep-string string          Separator string [default - '.']
    -r, --recursive                  Process the files recursively [default - false]
    -c, --commit                     Perform the actual rename [default - false]
    -v, --version                    Display version number
    -h, --help                       Display this screen
```

### Changelog

#### 0.0.7

- More improvement and code cleanup

#### 0.0.6

- Fix and update README.md

#### 0.0.5

- Update the README.md to include usage example

#### 0.0.4

- fix the stupid bug with the `which` method which raise invalid error
- update README.md to reflect the change

#### 0.0.3

- make it possible to change the path to the binary

#### 0.0.2

- fix the silly refactoring bug

#### 0.0.1
- Initial release

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Make sure that you add the tests and ensure that all tests are passed
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
