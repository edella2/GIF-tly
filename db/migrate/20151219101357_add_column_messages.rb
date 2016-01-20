class AddColumnMessages < ActiveRecord::Migration
  def change
    add_column(:messages, :from_number, :string)
    add_column(:messages, :to_number, :string)

  end
end
