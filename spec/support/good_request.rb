shared_examples_for 'good request' do
  it 'returns 200' do
    expect(response).to be_success
  end
end
