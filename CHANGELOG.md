### Changelog
#### 0.2.3

- Use `require` instead of `require_relative` when possible
- Use underscore instead of dot as the default seperator
- Improve README.md

#### 0.2.2

- Support ruby version 1.9.3+
- Minor code cleanup

#### 0.2.1

- Make ruby 2.1.0+ mandatory due to the refinement support

#### 0.2.0

- Make use of refinement instead of monkeypatching core classes
- Minor code cleanup

#### 0.1.12

- Skip the file if the result filename exist locally.

#### 0.1.11

- Make use of [filename_cleaner][] gem for renaming filename
- Add new options
  * `--downcase` to allow downcase of each word in the filename
  * `--capitalize` to allow capitalization of each word in the filename
- Fix the style with rubocop
- Improve README.md

#### 0.1.10

- Code refactoring

#### 0.1.9

- Skip the rename if the the title is the same as the input file name.

#### 0.1.8

- Simplify the CLI interface
- Consistently use double quote for string
- Update style with rubocop

#### 0.1.7

- First [Semantic Versioning][] release version
- Update development ruby-version to 2.1.2

#### 0.1.6

- Fix the README.md
- Update gemspec

#### 0.1.5

- Simplify the interface to only support epub, pdf and mobi format
- Reduce the options for the CLI
  * remove --exc-words
  * remove --inc_words
  * remove --ignore-case
  * remove --non-exts
- Update gemspec to include files explicitly without using git
- Update 'code_lister' to 0.0.9
- Update 'thor' to 0.19.1
- Code cleanup and refactoring
- Remove list of changes from README.md to CHANGELOGS.md

#### 0.1.4

- Make use of functions from 'agile_utils' to promote code re-use
- Make Rakefile pickup the right code for testing
- Update README.md to include code_climate and gemnasium

#### 0.1.3

- Make sanitize_filename work properly with `--sep-string` option
- Use symbolize_keys from [agile_utils][] gem
- Fix the Guardfile and misc cleanup

#### 0.1.2

- Make use of [agile_utils] gem
- Add TODOs.md

#### 0.1.1

- Make use of the [code_lister][] gem

#### 0.1.0

- Add link to the version badge to link to latest gem.
- Implicitly set the default value for extension to `pdf,epub,mobi` if
  not explicitly set by the user at the command line.

#### 0.0.9

- Make sure the gemspec include the proper dependencies.

#### 0.0.8

- Use Thor instead of OptionParser for parsing of options

#### 0.0.2 - 0.0.7

- Improvement of code and fix a few bugs a long the way

#### 0.0.1

- Initial release

[agile_utils]: https://rubygems.org/gems/agile_utils
[filename_cleaner]: https://rubygems.org/gems/filename_cleaner
[code_lister]: https://rubygems.org/gems/code_lister
[Semantic Versioning]: http://semver.org
