require 'rake'
require 'rake/tasklib'
require 'shellwords'

module Koine
  module Tasks
    class MysqlDump < Rake::TaskLib
      OutputFileNotSetError = Class.new(StandardError)

      attr_accessor :task_name
      attr_accessor :dependencies
      attr_accessor :hostname
      attr_accessor :database
      attr_accessor :username
      attr_accessor :password
      attr_accessor :url
      attr_writer :output_file

      def initialize(env: ENV)
        self.task_name    ||= 'mysql:dump'
        self.dependencies ||= []
        self.url          ||= env['DB_URL']
        self.hostname     ||= env['DB_HOST']
        self.database     ||= env['DB_NAME']
        self.username     ||= env['DB_USER']
        self.password     ||= env['DB_PASSWORD']
        self.output_file = env['MYSQL_BACKUP_FILE']
        yield(self) if block_given?
        define_task
      end

      def output_file
        @output_file || raise(OutputFileNotSetError)
      end

      private

      def define_task
        desc 'Mysqldump to backup file'
        task task_name => dependencies do
          execute_task
        end
      end

      def execute_task
        backup = Koine::DbBkp::Mysql::Dump.new(configuration)
        backup.to_sql_file(output_file)
      end

      def configuration
        {
          url: url,
          hostname: hostname,
          database: database,
          username: username,
          password: password
        }
      end
    end
  end
end
