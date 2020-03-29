require 'timer'

describe Timer do

  it 'creates a log file' do
    subject.log
    expect{ File.open(subject.log_file) }.not_to raise_error
  end
  it 'knows time and date to seconds' do
    expect(subject.time).to eq(Time.now.to_s.split(" +").first)
  end

  it 'logs start of bugfix period' do
    subject.log_bugfix_start
    expect( File.read(subject.log_file) ).to include("debug start,#{subject.time}")
  end
  
  it 'logs start of bugfix period' do
    subject.log_bugfix_end
    expect( File.read(subject.log_file) ).to include("debug end,#{subject.time}")
  end
end
