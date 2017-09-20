require 'addressable/uri'

module Koine
  module DbBkp
    module Mysql
      class RailsDump
        def initialize(config = DatabaseConfig.new.to_h)
          @backup = Dump.new(config)
        end

        def to_sql_file(file)
          @backup.to_sql_file(file)
        end

        class DatabaseConfig
          InvalidAdapter = Class.new(StandardError)
          def to_h
            config = symbolize_keys(database_configuration[env].to_h)
            config = merge_url(config) if config[:url]
            assert_adapter(config[:adapter])
            config
          end

          def env
            Rails.env.to_s
          end

          def database_configuration
            Rails.configuration.database_configuration
          end

          private

          def symbolize_keys(hash)
            {}.tap do |new_hash|
              hash.each do |key, value|
                new_hash[key.to_sym] = value
              end
            end
          end

          def merge_url(config)
            url = config.delete(:url)
            url = Addressable::URI.parse(url)

            config.merge(
              adapter: url.scheme,
              hostname: url.host,
              database: url.path.split('/').join(''),
              username: url.user,
              password: url.password
            )
          end

          def assert_adapter(adapter)
            raise InvalidAdapter unless adapter.to_s =~ /mysql/
          end
        end
      end
    end
  end
end
