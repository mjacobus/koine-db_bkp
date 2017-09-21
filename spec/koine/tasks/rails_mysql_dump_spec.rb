require 'spec_helper'
require 'support/mock_rails_config'

RSpec.describe Koine::Tasks::RailsMysqlDump do
  before do
    Rake::Task['mysql:dump'].clear if Rake::Task.task_defined?('mysql:dump')
    Rake::Task['some_task'].clear if Rake::Task.task_defined?('some_task')
  end

  describe '#task_name' do
    it 'defaults to mysql:dump' do
      expect(subject.task_name).to eq('mysql:dump')
    end
  end

  describe '#dependencies' do
    it 'defaults to :environment' do
      expect(subject.dependencies).to eq([:environment])
    end
  end

  describe '#output_file' do
    it 'raises when not set' do
      expect do
        subject.output_file
      end.to raise_error(Koine::Tasks::MysqlDump::OutputFileNotSetError)
    end
  end

  describe '#initialize' do
    subject do
      described_class.new do |t|
        t.task_name    = 'some_task'
        t.database     = 'theDatabase'
        t.url          = 'theUrl'
        t.hostname     = 'theHostname'
        t.username     = 'theUsername'
        t.password     = 'thePassword'
        t.output_file  = 'theOutputFile'
        t.dependencies = ['foo']
      end
    end

    it 'initializes task' do
      subject

      expect(Rake::Task.task_defined?('some_task')).to eq(true)
    end

    it 'can mutate task_name' do
      expect(subject.task_name).to eq('some_task')
    end

    it 'can mutate database' do
      expect(subject.database).to eq('theDatabase')
    end

    it 'can mutate hostname' do
      expect(subject.hostname).to eq('theHostname')
    end

    it 'can mutate username' do
      expect(subject.username).to eq('theUsername')
    end

    it 'can mutate password' do
      expect(subject.password).to eq('thePassword')
    end

    it 'can mutate output_file' do
      expect(subject.output_file).to eq('theOutputFile')
    end

    it 'can mutate dependencies' do
      expect(subject.dependencies).to eq(['foo'])
    end

    it 'can mutate url' do
      expect(subject.url).to eq('theUrl')
    end
  end

  describe 'running task' do
    subject do
      described_class.new do |t|
        t.task_name = 'some_task'
        t.output_file = 'outputFile'
        t.database = 'newName'
      end
    end

    it 'runs dump with merged config from rails' do
      assert_runs_with(
        url: 'mysql2://user:pwd@rails/db',
        database: 'newName',
        output_file: 'outputFile',
      )

      Rake::Task[subject.task_name].execute
    end
  end

  private

  def assert_runs_with(configuration)
    output_file = configuration.delete(:output_file)

    mock = double(Koine::DbBkp::Mysql::Dump)

    expect(Koine::DbBkp::Mysql::Dump).to receive(:new).with(configuration) { mock }
    expect(mock).to receive(:to_sql_file).with(output_file)
  end
end
