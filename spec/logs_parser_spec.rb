require 'tempfile'

require_relative '../app/logs_parser'
require_relative '../app/total-page-views-recorder'
require_relative '../app/unique-page-views-recorder'
require_relative '../app/page-view-entry'

describe LogsParser do
  describe '#run' do
    subject { described_class.new(file_reader, page_view_entry_class, recorders).run }

    let(:file_reader) { FileReader.new(log_file_path) }
    let(:page_view_entry_class) { PageViewEntry }
    let(:recorders) {
      [
        TotalPageViewsRecorder.new,
        UniquePageViewsRecorder.new
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
