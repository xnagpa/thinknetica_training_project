require 'rails_helper'

RSpec.describe Attachment, type: :model do  

  it 'belong_to ' do
 	 expect(subject).to belong_to(:attachable)  	 
  end
 

end
