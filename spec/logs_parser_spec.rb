require_relative '../app/logs_parser'

describe LogsParser do
  subject { described_class.new(log_file_name).run }
  let(:log_file_name) { 'dummy.log' }

  it 'runs' do
    subject
  end
end
