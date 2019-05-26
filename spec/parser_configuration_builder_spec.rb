require_relative '../app/parser_configuration'

describe ParserConfigurationBuilder do
  describe '#build' do
    context 'with correct arguments' do
      let(:builder) { ParserConfigurationBuilder.new }

      let(:file_path) { 'path' }
      let(:file_reader_instance) { double('File Reader Instance') }
      let(:file_reader) { double('File Reader', new: file_reader_instance) }
      let(:log_event_parser) { double('Log Event Parser') }
      let(:event_recorder1) { double('Event Recorder 1') }
      let(:summary_formatter1) { double('Summary Formatter 1') }
      let(:event_recorder2) { double('Event Recorder 2') }
      let(:summary_formatter2) { double('Summary Formatter 2') }
      let(:log_mapping_strategy) { double('Log Mapping Strategy') }

      before do
        builder
          .file_path(file_path)
          .file_reader(file_reader)
          .log_event_parser(log_event_parser)
          .log_mapping_strategy(log_mapping_strategy)
          .log_event_recorder(event_recorder1, summary_formatter1)
          .log_event_recorder(event_recorder2, summary_formatter2)
          .build
      end

      it 'builds proper ParserConfiguration' do
        parser_configuration = builder.build

        aggregate_failures do
          expect(parser_configuration.file_reader).to eq(file_reader_instance)
          expect(parser_configuration.log_event_parser).to eq(log_event_parser)
          expect(parser_configuration.log_mapping_strategy).to eq(log_mapping_strategy)

          expect(parser_configuration.log_event_recorders.size).to eq(2)
          expect(parser_configuration.log_event_recorders[0].event_recorder).to eq(event_recorder1)
          expect(parser_configuration.log_event_recorders[0].summary_formatter).to eq(summary_formatter1)
          expect(parser_configuration.log_event_recorders[1].event_recorder).to eq(event_recorder2)
          expect(parser_configuration.log_event_recorders[1].summary_formatter).to eq(summary_formatter2)
        end
      end
    end
  end
end