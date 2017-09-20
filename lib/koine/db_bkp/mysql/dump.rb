module Koine
  module DbBkp
    module Mysql
      class Dump
        def initialize(config = {})
          config = config.reject { |_k, v| ['', nil].include?(v) }

          @hostname = config[:hostname]
          @database = config.fetch(:database)
          @password = config[:password]
          @cli = Cli.new
        end

        def to_sql_file(file)
          parts = ['mysqldump']

          parts.push("-h #{@hostname}") if @hostname
          parts.push("-p#{@password}") if @password

          parts.push(@database)
          parts.push("> #{file}")

          @cli.execute(parts.join(' '))
        end
      end
    end
  end
end
