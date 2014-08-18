require 'nc'

describe Nc do
  let(:formatter)   { Nc.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }

  # emoji
  let(:success) { "\u2705" }
  let(:failure) { "\u26D4" }

  it 'returns the summary' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n3 examples, 1 failure, 1 pending",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    summary = double('summary',
                     duration: 0.0001,
                     examples: [1,2,3],
                     failed_examples: [1],
                     pending_examples: [1]
                    )
    formatter.dump_summary(summary)
  end

  it 'returns a failing notification' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 1 failure",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    summary = double('summary',
                     duration: 0.0001,
                     examples: [1],
                     failed_examples: [1],
                     pending_examples: []
                    )
    formatter.dump_summary(summary)
  end

  it 'returns a success notification' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 0 failures",
      :title => "#{success} #{current_dir}: Success"
    )

    summary = double('summary',
                     duration: 0.0001,
                     examples: [1],
                     failed_examples: [],
                     pending_examples: []
                    )
    formatter.dump_summary(summary)
  end

  it 'handles dump_pending call' do
    expect{ formatter.dump_pending('one arg') }.not_to raise_error
  end

  it 'handles dump_failures call' do
    expect{ formatter.dump_failures('one arg') }.not_to raise_error
  end

  it 'handles message call' do
    expect{ formatter.message('one arg') }.not_to raise_error
  end
end
