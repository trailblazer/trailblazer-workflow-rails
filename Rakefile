# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

task default: :test

# test diagram import in different scenarios
Rake::TestTask.new(:test_3) do |t|
  t.test_files = FileList["test/dummies/uninitialized/test/import_test.rb"]
end

Rake::TestTask.new(:test_4) do |t|
  t.test_files = FileList["test/dummies/uninitialized/test/discover_test.rb"]
end
