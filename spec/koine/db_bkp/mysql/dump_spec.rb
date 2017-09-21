require 'spec_helper'

RSpec.describe Koine::DbBkp::Mysql::Dump do
  let(:cli) { double(Koine::DbBkp::Cli) }
  let(:filename) { 'file_2001-02-03_04-05-06.sql'  }
  let(:file_pattern) { 'file_{timestamp}.sql'  }

  before do
    allow(cli).to receive(:execute)
    allow(Koine::DbBkp::Cli).to receive(:new).and_return(cli)
    time = Time.new(2001, 0o2, 0o3, 0o4, 0o5, 0o6)
    allow(Time).to receive(:now) { time }
  end

  describe '#to_sql_file' do
    it 'executes mysqldump with correct params' do
      backup = described_class.new(hostname: 'host', database: 'db', password: '')
      backup.to_sql_file(file_pattern)

      cmd = "mysqldump -h host db > #{filename}"

      cli.execute('foo')
      expect(cli).to have_received(:execute).with(cmd)
    end

    it 'executes mysqldump with correct params' do
      backup = described_class.new(hostname: 'host', database: 'db', 'password' => 'pwd')
      backup.to_sql_file('/tmp/foo.sql')

      cmd = 'mysqldump -h host -ppwd db > /tmp/foo.sql'

      cli.execute('foo')
      expect(cli).to have_received(:execute).with(cmd)
    end

    describe 'when database config is throug the :url key' do
      it 'executes mysqldump with correct params' do
        backup = described_class.new('url' => 'mysql2://username:password@hostname/database')
        backup.to_sql_file('/tmp/foo.sql')

        cmd = 'mysqldump -h hostname -u username -ppassword database > /tmp/foo.sql'

        cli.execute('foo')
        expect(cli).to have_received(:execute).with(cmd)
      end
    end
  end
end
