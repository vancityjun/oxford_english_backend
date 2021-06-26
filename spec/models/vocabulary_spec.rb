require 'rails_helper'

RSpec.describe Vocabulary, type: :model do
  let!(:vocabulary) {create :vocabulary}

  it 'does not save the record and returns error if word has duplication' do
    duplication = vocabulary.dup
    duplication.save
    expect(duplication.errors).not_to be_empty
  end

  context 'if name is same but pos is different' do
    it 'save the record' do
      duplication = Vocabulary.new word: vocabulary.word, pos: 'noun'
      expect(duplication.valid?).to be_truthy
      expect do
        duplication.save
      end.
        to change {Vocabulary.count}.by(1)
    end
  end
end
