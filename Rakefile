require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "koine/db_bkp"

import 'lib/koine/tasks/mysql_dump.rake'
import 'lib/koine/tasks/mysql_rails_dump.rake'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
