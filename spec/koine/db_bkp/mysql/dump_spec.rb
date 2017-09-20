require 'spec_helper'

RSpec.describe Koine::DbBkp::Mysql::Dump do
  let(:cli) { double(Koine::DbBkp::Cli) }

  before do
    allow(cli).to receive(:execute)
    allow(Koine::DbBkp::Cli).to receive(:new).and_return(cli)
  end

  describe '#to_sql_file' do
    it 'executes mysqldump with correct params' do
      backup = described_class.new(hostname: 'host', database: 'db', password: '')
      backup.to_sql_file('/tmp/foo.sql')

      cmd = 'mysqldump -h host db > /tmp/foo.sql'

      cli.execute('foo')
      expect(cli).to have_received(:execute).with(cmd)
    end

    it 'executes mysqldump with correct params' do
      backup = described_class.new(hostname: 'host', database: 'db', password: 'pwd')
      backup.to_sql_file('/tmp/foo.sql')

      cmd = 'mysqldump -h host -ppwd db > /tmp/foo.sql'

      cli.execute('foo')
      expect(cli).to have_received(:execute).with(cmd)
    end
  end
end
