require_relative '../../app/recorders/log_recorder'

describe LogRecorder do
  let(:recorder) { described_class.new }

  describe '#summary' do
    subject { recorder.summary }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#record' do
    subject { recorder.summary }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end