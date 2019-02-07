require 'addressable/uri'

module Koine
  module DbBkp
    module Mysql
      class Dump
        def initialize(config = {})
          config = normalize_config(config)

          @hostname = config.fetch(:hostname)
          @database = config.fetch(:database)
          @username = config[:username]
          @password = config[:password]
          @cli = Cli.new
        end

        def to_sql_file(file)
          parts = ['mysqldump']

          parts.push("-h #{escape(@hostname)}") if @hostname
          parts.push("-u #{escape(@username)}") if @username
          parts.push("-p#{escape(@password)}") if @password

          parts.push(@database)

          file = FileName.new(file)
          parts.push("> #{file}")

          @cli.execute(parts.join(' '))
        end

        private

        def escape(string)
          Shellwords.escape(string)
        end

        def normalize_config(config)
          config = config.reject { |_k, v| ['', nil].include?(v) }
          merge_url(symbolize_keys(config))
        end

        def merge_url(config)
          url = config.delete(:url)

          return config unless url

          url = Addressable::URI.parse(url)

          config.merge(
            adapter: url.scheme,
            hostname: url.host,
            database: url.path.split('/').join(''),
            username: url.user,
            password: url.password
          )
        end

        def symbolize_keys(hash)
          {}.tap do |new_hash|
            hash.each { |key, value| new_hash[key.to_sym] = value }
          end
        end
      end
    end
  end
end
