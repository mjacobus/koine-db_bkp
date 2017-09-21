require 'koine/db_bkp/version'

module Koine
  module Tasks
    autoload :MysqlDump, 'koine/tasks/mysql_dump'
    autoload :RailsMysqlDump, 'koine/tasks/rails_mysql_dump'
  end

  module DbBkp
    autoload :Cli, 'koine/db_bkp/cli'
    autoload :FileName, 'koine/db_bkp/file_name'

    module Mysql
      autoload :Dump, 'koine/db_bkp/mysql/dump'
      autoload :RailsDump, 'koine/db_bkp/mysql/rails_dump'
    end
  end
end
