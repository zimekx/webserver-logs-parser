require_relative '../../app/recorders/total_hits_recorder'

describe TotalHitsRecorder do
  let(:recorder) { described_class.new }

  describe '#summary' do
    subject { recorder.summary }

    context 'without anything recorded' do
      it 'returns empty array' do
        expect(subject).to eq([])
      end
    end

    context 'with one entries recorded for one key' do
      before do
        recorder.record('a', 'A')
      end

      it 'returns single result' do
        result = subject

        aggregate_failures do
          expect(result.size).to eq(1)
          expect(result[0].key).to eq('a')
          expect(result[0].value).to eq(1)
        end
      end
    end

    context 'with two entries recorded' do
      context 'for one key' do
        before do
          recorder.record('a', 'A')
          recorder.record('a', 'B')
        end

        it 'returns single result' do
          result = subject

          aggregate_failures do
            expect(result.size).to eq(1)
            expect(result[0].key).to eq('a')
            expect(result[0].value).to eq(2)
          end
        end
      end

      context 'for two different keys' do
        before do
          recorder.record('a', 'A')
          recorder.record('b', 'B')
        end

        it 'returns two results' do
          result = subject

          aggregate_failures do
            expect(result.size).to eq(2)
            expect(result[0].key).to eq('a')
            expect(result[0].value).to eq(1)
            expect(result[1].key).to eq('b')
            expect(result[1].value).to eq(1)
          end
        end
      end
    end

    context 'with complex example' do
      before do
        recorder.record('a', 'A')
        recorder.record('b', 'B')
        recorder.record('a', 'A')
        recorder.record('a', 'A')
        recorder.record('c', 'A')
        recorder.record('c', 'A')
      end

      it 'returns properly sorted result' do
        result = subject

        aggregate_failures do
          expect(result.size).to eq(3)
          expect(result[0].key).to eq('a')
          expect(result[0].value).to eq(3)
          expect(result[1].key).to eq('c')
          expect(result[1].value).to eq(2)
          expect(result[2].key).to eq('b')
          expect(result[2].value).to eq(1)
        end
      end
    end
  end
end