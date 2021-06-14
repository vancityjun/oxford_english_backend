require 'rails_helper'

RSpec.describe Mutations::AddVocabulary, type: :request do
  let!(:user) {create :user}
  let!(:query) do 
    <<-GQL
      mutation addVocabulary($input: AddVocabularyInput!) {
        addVocabulary(input: $input) {
          vocabulary{
            id
            word
            pos
            level
            ox5000
            celpip
            note {
              updatedAt
              definitions {
                content
                form
                examples {
                  content
                }
              }
            }
          }
          errors
        }
      }
    GQL
  end

  it 'creates vocabulary' do
    variables = {
      word: 'infer',
      pos:'verb',
      celpip: true,
      definitionAttributes: {
        content: "to leave somebody, especially somebody you are responsible for, with no intention of returning",
        form: 'verb',
        languageCode: 'en',
      },
      examples: [
        {content: "The baby had been abandoned by its mother."},
        {content: "People often simply abandon their pets when they go abroad."}
      ]
    }
    result = nil
    expect do
      result = ServerSchema.execute(
        query,
        variables: {input: variables},
        context: {current_user: user}
      ).to_h.deep_symbolize_keys[:data][:addVocabulary]
    end.
      to change {Vocabulary.count}.by(1).
      and change {Example.count}.by(2).
      and change {Definition.count}.by(1).
      and change {Note.count}.by(1)

    expect(result[:errors]).to be_empty

    vocabulary = Vocabulary.last
    expect(result[:vocabulary]).to match vocabulary_attr(vocabulary.reload)
  end

  context 'if same vocabulary is exist' do
    let!(:vocabulary) {create :vocabulary}

    it 'updates the existing one' do
      variables = {
        word: 'abandon',
        pos:'verb',
        celpip: true,
        definitionAttributes: {
          content: "test",
          form: 'verb',
          languageCode: 'en',
        },
        examples: [
          {content: "test1"},
          {content: "test2"}
        ]
      }
      result = nil
      expect do
        result = ServerSchema.execute(
          query,
          variables: {input: variables},
          context: {current_user: user}
        ).to_h.deep_symbolize_keys[:data][:addVocabulary]
      end.
        to_not change {Vocabulary.count}
        # and_not change {Note.count}.
        # and change {Example.count}.by(2).
        # and change {Definition.count}.by(1)
  
      expect(result[:errors]).to be_empty
  
      expect(result[:vocabulary]).to match vocabulary_attr(vocabulary.reload)
    end
  end

  def vocabulary_attr(vocabulary)
    {
      id: vocabulary.id.to_s,
      word: vocabulary.word,
      pos: vocabulary.pos,
      level: vocabulary.level,
      ox5000: vocabulary.ox5000,
      celpip: vocabulary.celpip,
      note: {
        updatedAt: vocabulary.updated_at.iso8601,
        definitions: definitions_attr(vocabulary.definitions)
      }      
    }
  end

  def definitions_attr(definitions)
    definitions.map do |definition|
      {
        content: definition.content,
        examples: examples(definition.examples),
        form: definition.form
      }
    end
  end

  def examples(examples)
    examples.map do |example|
      { content: example.content }
    end
  end
end
