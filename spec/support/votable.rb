shared_examples_for "Votable" do
  let!(:another_vote) { FactoryGirl.create(:vote, votable: subject, user: user) }

  it 'can return previous vote of the user' do
    expect(subject.previous_vote(user)).to eq (another_vote)
  end

  it 'calculates rating' do
    expect(subject.rating).to eq (1)
  end
#message expectation
  it 'receives :rating' do
    expect(subject).to receive(:rating)
    subject.rating
  end

  it 'receives :previous_vote' do
    expect(subject).to receive(:previous_vote)
    subject.previous_vote(user)
  end

end
