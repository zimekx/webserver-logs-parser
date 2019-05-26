require_relative '../app/file-reader'

describe FileReader do
  subject { described_class.new(file_path) }

  context 'with missing file path' do
    let(:file_path) { '' }

    it 'raises ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end

  context 'with incorrect file path' do
    let(:file_path) { 'spec/this-file-does-not-exist.log' }

    it 'raises ArgumentError' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end