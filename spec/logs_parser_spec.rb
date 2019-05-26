require 'tempfile'

require_relative '../app/logs_parser'
require_relative '../app/recorders/total_hits_recorder'
require_relative '../app/recorders/unique_hits_recorder'
require_relative '../app/formatters/total_visits_formatter'
require_relative '../app/formatters/unique_views_formatter'
require_relative '../app/mapping_strategies/page_by_user_ip_strategy'

describe LogsParser do
  describe '#run' do
    subject { described_class.new(file_reader, page_view_entry_class, page_by_user_ip_strategy, recorders).run }

    let(:file_reader) { FileReader.new(log_file_path) }
    let(:page_view_entry_class) { PageViewEntry }
    let(:page_by_user_ip_strategy) { PageByUserIpStrategy }
    let(:recorders) {
      [
        {recorder: TotalHitsRecorder.new, formatter: TotalVisitsFormatter},
        {recorder: UniqueHitsRecorder.new, formatter: UniqueViewsFormatter}
      ]
    }

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

    let(:log_file_path) {test_log_file.path}

    after { test_log_file.unlink }

    let(:expected_output) do
      <<-OUTPUT
/help_page/1 2 visits
/about/2 1 visits
/help_page/1 1 unique views
/about/2 1 unique views
      OUTPUT
    end

    it 'lists webpages with most page views ordered from most pages views to less page views' do
      expect { subject }.to output(expected_output).to_stdout
    end
  end
end
