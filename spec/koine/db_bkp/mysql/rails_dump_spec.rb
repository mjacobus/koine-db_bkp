require 'spec_helper'
require 'support/mock_rails_config'

RSpec.describe Koine::DbBkp::Mysql::RailsDump do
  describe '#to_sql_file' do
    let(:file) { '/foo/dump.sql' }
    let(:hash) { { foo: :bar } }
    let(:config) { double(Koine::DbBkp::Mysql::RailsDump::DatabaseConfig, to_h: hash) }
    let(:dump) { double(Koine::DbBkp::Mysql::Dump) }

    before do
      allow(Koine::DbBkp::Mysql::RailsDump::DatabaseConfig).to receive(:new) { config }
      allow(Koine::DbBkp::Mysql::Dump).to receive(:new) { dump }
      allow(dump).to receive(:to_sql_file).with(file) { 'ok' }
    end

    it 'delegates to Dump' do
      expect(subject.to_sql_file(file)).to eq('ok')
    end
  end

  describe Koine::DbBkp::Mysql::RailsDump::DatabaseConfig do
    subject do
      Koine::DbBkp::Mysql::RailsDump::DatabaseConfig.new
    end

    describe '#to_h' do
      context 'when config is a hash' do
        it 'returns the database configuration for the respective RAILS_ENV' do
          expected_config = {
            foo: 'dev',
            adapter: 'mysql2'
          }

          expect(subject.to_h).to eq(expected_config)
        end

        context 'when config is url' do
          let(:url) { 'mysql2://the_username:the_password@the_hostname/the_database' }

          it 'returns the correct databse configuration' do
            config = { 'development' => { 'url' => url, 'other_config' => 'bar' } }

            allow_any_instance_of(Koine::DbBkp::Mysql::RailsDump::DatabaseConfig)
              .to receive(:database_configuration) { config }

            expected = {
              adapter: 'mysql2',
              hostname: 'the_hostname',
              database: 'the_database',
              username: 'the_username',
              password: 'the_password',
              other_config: 'bar'
            }

            expect(subject.to_h).to eq(expected)
          end
        end
      end
    end
  end
end
