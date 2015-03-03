require_relative '../../lib/simple_scrubber'

describe SimpleScrubber do
  it "scrubs emails" do
    text = SimpleScrubber.scrub("foo bar adam.pash@gmail.com baz bat", [:email])
    expect(text).to eq "foo bar xxx@xxx.xxx baz bat"

    text = SimpleScrubber.scrub("adam.pash+foo@gmail.com.", [:email])
    expect(text).to eq "xxx@xxx.xxx."
  end

  it "scrubs phone numbers" do
    text = SimpleScrubber.scrub("foo bar 1(555)555-1234 baz bat", [:phone])
    expect(text).to eq "foo bar XXX-XXX-XXXX baz bat"
  end

  it "scrubs email and phone numbers" do
    text = SimpleScrubber.scrub("contact bar at 1(555)555-1234 or pash@gawker.com", [:email, :phone])
    expect(text).to eq "contact bar at XXX-XXX-XXXX or xxx@xxx.xxx"
  end
end
