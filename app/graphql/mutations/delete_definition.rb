module Mutations
  class DeleteDefinition < Mutations::BaseMutation
    argument :id, ID, required: true

    field :errors, [String], null: false
    field :message, String, null: false

    def resolve(id:)
      return unless context[:current_user]
      definition = Definition.find(id)

      if definition.destroy!
        {
          message: 'Successfully deleted',
          errors: []
        }
      else
        { errors: ['there was an error while deleting definitions'] }
      end
    end
  end
end
