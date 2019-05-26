require_relative '../../app/events_recorders/events_recorder'

describe EventsRecorder do
  let(:recorder) { described_class.new }

  describe '#summary' do
    subject { recorder.summary }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end

  describe '#record' do
    subject { recorder.record }

    it 'raises NotImplementedError' do
      expect { subject }.to raise_error(NotImplementedError)
    end
  end
end