require 'rails_helper'

RSpec.describe Vocabulary, type: :model do
  let!(:vocabulary) {create :vocabulary}

  it 'does not save the record and returns error if word has duplication' do
    duplication = vocabulary.dup
    duplication.save
    expect(duplication.errors).not_to be_empty
  end
end
