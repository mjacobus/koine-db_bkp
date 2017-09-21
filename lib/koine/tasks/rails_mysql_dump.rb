require 'rake'
require 'rake/tasklib'

module Koine
  module Tasks
    class RailsMysqlDump < MysqlDump
      def initialize(*args)
        self.dependencies ||= [:environment]
        super(*args)
      end

      private

      def configuration
        config = super.reject { |_k, v| v.nil? }
        rails_config.merge(config)
      end

      def rails_config
        env = Rails.env.to_s
        Rails.configuration.database_configuration[env].symbolize_keys
      end
    end
  end
end
