require "rails_helper"

describe Railgun do

 subject { Railgun.new }
  it " shoots using rails " do
   expect(subject).to receive(:booom)
   subject.booom
  end

  it "  reloads " do
   expect(subject).to receive(:reload).with(1,2)
   subject.reload
  end

  it " tests fake method" do
   allow(subject).to receive(:fire).and_return("Fire!!!")
   expect(subject.fire).to eq "Fire!!!"
  end

  it " tests fake object" do
    answer = double(Answer, content:"Erum dom dom", user: "Pablo")
    allow(Answer).to receive(:find){answer}
    expect(Answer.find(100500)).to eq answer
  end

end
#
#
# def booom
#   puts "BOOOM!!!"
# end
#
# def reload
#   puts "Reloading!"
# end
