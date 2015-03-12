class AddMessageConversationToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :conversation_id, :integer
  end
end
