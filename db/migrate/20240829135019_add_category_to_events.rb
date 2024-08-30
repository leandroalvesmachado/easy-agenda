class AddCategoryToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :category, null: false, foreign_key: true

    # mesma coisa de utilizar o add_reference
    # add_column :events, :category_id, :integer, null: false
    # add_foreign_key :events, :category
  end
end
