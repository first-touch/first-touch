require_relative '../../lib/file_type_detector'

describe 'FileTypeDetector' do
  describe 'mime_type' do
    let(:fake_terrapin) { double(run: "application/spreadsheetml.sheet\n") }
    let(:command) { FileTypeDetector.mime_type('file.xlsx') }

    before do
      allow(Terrapin::CommandLine).to receive(:new).and_return(fake_terrapin)
      command
    end

    it 'initializes terrapin with `file` command' do
      expect(Terrapin::CommandLine).to have_received(:new)
        .with('file --brief --mime-type', 'file.xlsx')
    end

    it 'runs the command' do
      expect(command).to eq 'application/spreadsheetml.sheet'
    end
  end
end
