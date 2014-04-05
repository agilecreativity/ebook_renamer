## Ebook_Renamer

Simple utility to perform bulk rename of the ebooks(epub,mobi,pdf) based on
the metadata within the ebook itself (if available).

### Why do I wrote this gem

Almost alwasy when I purchase a new ebooks (or download them from the internet) they always came with the
bad name. I really like the meaningful name to the file that I have. This make it easy to search for them
and give you the context to the content of the file.

I wrote this gem just to make it possible to rename in bulk and recursively.

This gem will rename any ebook files (currently only pdf, epub, mobi) using the available
meta-data that embedded within the ebook.

So if you don't like to spend time renaming them manually then this gem is for you.

### What you will need

* You will need to install the [Calibre](http://www.calibre-ebook.com/) and
  [Calibre CLI](http://manual.calibre-ebook.com/cli/cli-index.html) on your OS.

* This gem should work on OSX/Linux like system. It may work with Windows system but I can't confirm
as I don't use windows for quite sometime now.

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

# Run the command without to see what will be changed without making any changes (dry-run)
ebook_rename  --recursive

# Once you are happy with what you see, then
ebook_renamer --recusive --commit
```

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
                    --meta-binary ebook-meta
                    --recursive
                    --commit

 Options:

    -b, --base-dir directory         Starting directory [default - current directory]
    -m, --meta-binary path           The ebook-meta executable [default - 'ebook-meta']
    -r, --recursive                  Process the files recursively [default - false]
    -c, --commit                     Perform the actual rename [default - false]
    -v, --version                    Display version number
    -h, --help                       Display this screen
```

### Changelog

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
