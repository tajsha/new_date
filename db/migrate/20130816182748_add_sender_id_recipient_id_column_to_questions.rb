class AddSenderIdRecipientIdColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :sender_id, :integer
    add_column :questions, :recipient_id, :integer
  end
end
