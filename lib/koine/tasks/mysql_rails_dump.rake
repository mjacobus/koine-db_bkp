require 'rake'

namespace :koine do
  namespace :mysql do
    desc 'mysqldump to backup file from rails database'
    task rails_dump: [:environment] do
      file_pattern = ENV.fetch('MYSQL_BACKUP_FILE')
      file_pattern = file

      Koine::DbBkp::Mysql::RailsDump.new.to_sql_file(file)
    end
  end
end
