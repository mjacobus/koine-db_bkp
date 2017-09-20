require 'spec_helper'

RSpec.describe Koine::DbBkp::FileName do
  subject do
    described_class.new('some_{timestamp}.sql')
  end

  before do
    time = Time.new(2001, 0o2, 0o3, 0o4, 0o5, 0o6)
    allow(Time).to receive(:now) { time }
  end

  describe '#to_s' do
    it 'returns the pattern with the timestamp' do
      expected = 'some_2001-02-03_04-05-06.sql'

      expect(subject.to_s).to eq(expected)
    end
  end
end
