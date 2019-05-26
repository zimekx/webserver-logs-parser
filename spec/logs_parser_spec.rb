require 'tempfile'

require_relative '../app/logs_parser'
require_relative '../app/events_recorders/total_hits_recorder'
require_relative '../app/events_recorders/unique_hits_recorder'
require_relative '../app/formatters/total_visits_formatter'
require_relative '../app/formatters/unique_views_formatter'
require_relative '../app/mapping_strategies/page_by_user_ip_strategy'
require_relative '../app/mapping_strategies/user_ip_by_page_strategy'
require_relative '../app/parser_configuration'

describe LogsParser do
  describe '#run' do
    subject { described_class.new(parser_configuration).run }
    let(:parser_configuration) { ParserConfiguration.new(file_reader, page_view_entry_class, mapping_strategy, events_recorders) }

    let(:file_reader) { FileReader.new(log_file_path) }
    let(:page_view_entry_class) { PageViewEvent }
    let(:events_recorders) {
      [
        LogEventRecorder.new(TotalHitsRecorder.new, TotalVisitsFormatter),
        LogEventRecorder.new(UniqueHitsRecorder.new, UniqueViewsFormatter)
      ]
    }

    context 'with dummy data and PageByUserIpStrategy strategy' do
      let(:mapping_strategy) { PageByUserIpStrategy }

      let(:logs) do
        <<-LOGS
/help_page/1 126.318.035.038
/about/2 444.701.448.104
/help_page/1 126.318.035.038
        LOGS
      end

      let(:test_log_file) do
        file = Tempfile.new
        file << logs
        file.close
        file
      end

      let(:log_file_path) { test_log_file.path }

      after { test_log_file.unlink }

      let(:expected_output) do
        <<-OUTPUT
/help_page/1 2 visits
/about/2 1 visits
/help_page/1 1 unique views
/about/2 1 unique views
        OUTPUT
      end

      it 'returns lists of webpages with most page views ordered from most pages views to less page views and list of webpages with most unique page views also ordered ' do
        expect { subject }.to output(expected_output).to_stdout
      end
    end

    context 'with webserver.log example' do
      let(:log_file_path) { 'spec/webserver.log.example' }

      context 'with PageByUserIpStrategy' do
        let(:mapping_strategy) { PageByUserIpStrategy }

        let(:expected_output) do
          <<-OUTPUT
/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits
/help_page/1 23 unique views
/contact 23 unique views
/home 23 unique views
/index 23 unique views
/about/2 22 unique views
/about 21 unique views
          OUTPUT
        end

        it 'returns expected output' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end

      context 'with UserIpByPageStrategy' do
        let(:mapping_strategy) { UserIpByPageStrategy }

        let(:expected_output) do
          <<-OUTPUT
158.577.775.616 31 visits
722.247.931.582 31 visits
184.123.665.067 29 visits
451.106.204.921 29 visits
543.910.244.929 27 visits
382.335.626.855 27 visits
316.433.849.805 25 visits
836.973.694.403 25 visits
016.464.657.359 22 visits
200.017.277.774 21 visits
444.701.448.104 21 visits
336.284.013.698 21 visits
682.704.613.213 20 visits
235.313.352.950 19 visits
897.280.786.156 19 visits
061.945.150.735 19 visits
646.865.545.408 19 visits
126.318.035.038 18 visits
555.576.836.194 18 visits
802.683.925.780 17 visits
715.156.286.412 16 visits
217.511.476.080 14 visits
929.398.951.889 12 visits
217.511.476.080 6 unique views
184.123.665.067 6 unique views
016.464.657.359 6 unique views
682.704.613.213 6 unique views
126.318.035.038 6 unique views
722.247.931.582 6 unique views
061.945.150.735 6 unique views
646.865.545.408 6 unique views
235.313.352.950 6 unique views
543.910.244.929 6 unique views
316.433.849.805 6 unique views
836.973.694.403 6 unique views
802.683.925.780 6 unique views
555.576.836.194 6 unique views
382.335.626.855 6 unique views
336.284.013.698 6 unique views
715.156.286.412 6 unique views
451.106.204.921 6 unique views
158.577.775.616 6 unique views
897.280.786.156 6 unique views
444.701.448.104 5 unique views
929.398.951.889 5 unique views
200.017.277.774 5 unique views
          OUTPUT
        end

        it 'returns expected output' do
          expect { subject }.to output(expected_output).to_stdout
        end
      end
    end
  end
end
