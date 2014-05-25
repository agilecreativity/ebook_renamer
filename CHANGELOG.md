### Changelog

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
[code_lister]: https://rubygems.org/gems/code_lister
[Semantic Versioning]: http://semver.org
