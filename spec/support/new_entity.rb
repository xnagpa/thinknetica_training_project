shared_examples_for "New entity creator" do
    #answer

    before do
      sign_in(user)

      get :new, params
    end
    #question
    it 'assigns new variable to @#{entity.downcase} ' do
      expect(assigns(entity.to_sym)).to be_a_new(Object.const_get(entity.capitalize))
    end

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'assigns new variable to @attachment' do
      expect(assigns(entity.to_sym).attachments.first).to be_a_new(Attachment)
    end


end
