require 'rake'

namespace :koine do
  namespace :mysql do
    desc 'mysqldump to backup file'
    task :dump do

      hostname = ENV.fetch('DB_HOST')
      database = ENV.fetch('DB_NAME')
      username = ENV.fetch('DB_USER')
      password = ENV.fetch('DB_PASSWORD') { nil }
      file_pattern = ENV.fetch('MYSQL_BACKUP_FILE')

      file_pattern = file

      backup = Koine::DbBkp::Mysql::Dump.new(
        hostname: hostname,
        database: database,
        username: username,
        password: password,
      )

      backup.to_sql_file(file)
    end
  end
end
