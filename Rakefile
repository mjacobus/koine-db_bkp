require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "koine/db_bkp"

Koine::Tasks::MysqlDump.new

Koine::Tasks::RailsMysqlDump.new do |t|
  t.task_name = 'rails:mysql_dump'
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
