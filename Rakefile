require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'lib/ebook_renamer'
  t.test_files = FileList['test/lib/ebook_renamer/*_test.rb']
  t.verbose = true
end

task :default => :test

task :pry do
  require 'pry'
  require 'awesome_print'
  require 'ebook_renamer'
  include EbookRenamer
  ARGV.clear
  Pry.start
end
