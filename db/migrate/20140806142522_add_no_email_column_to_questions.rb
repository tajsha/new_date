class AddNoEmailColumnToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :no_email, :boolean
  end
end
