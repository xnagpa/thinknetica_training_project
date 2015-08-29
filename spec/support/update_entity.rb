shared_examples_for 'Entity updater' do
  let(:user) { FactoryGirl.create(:user) }

  it 'assign @instance ' do
    sign_in(user)
    do_update_request
    # patch :update, id: question_to_update, question: FactoryGirl.attributes_for(:question), format: :js
    expect(assigns(entity_to_update.class.to_s.downcase.to_sym)).to eq entity_to_update
  end

  it 'render template update' do
    sign_in(user)
    do_update_request
    expect(response).to render_template :update
  end
  #
  it 'changes the original content off the entity' do
    sign_in(user)
    do_change_content_request
    # patch :update, id: question_to_update, question: { title: 'crap', content: 'new crap' }, format: :js
    entity_to_update.reload
    expect(entity_to_update.content).to eq 'new crap'
    expect(entity_to_update.title).to eq 'crap' if entity_to_update.respond_to?(:title)
  end
  #
  it 'doesnt change if another user tries to change it' do
    sign_in(another_user)
    do_change_content_request
    entity_to_update.reload
    expect(entity_to_update.content).not_to eq 'new crap'
  end
end
