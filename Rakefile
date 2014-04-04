require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/ebook_renamer'
  t.test_files = FileList['test/lib/ebook_renamer/*_test.rb']
  t.verbose = true
end

task :default => :test

## see: http://erniemiller.org/2014/02/05/7-lines-every-gems-rakefile-should-have/
task :irb do
  require 'irb'
  require 'awesome_print'
  require 'irb/completion'
  require 'ebook_renamer'
  include EbookRenamer
  ARGV.clear
  IRB.start
end

## see: http://lucapette.com/pry/pry-everywhere/
task :pry do
  require 'pry'
  require 'awesome_print'
  require 'ebook_renamer'
  include EbookRenamer
  ARGV.clear
  Pry.start
end
