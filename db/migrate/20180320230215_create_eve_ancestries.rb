# frozen_string_literal: true

class CreateEveAncestries < ActiveRecord::Migration[5.2]
  def change
    create_table :eve_ancestries do |t|
      t.integer :ancestry_id
      t.string :name
      t.integer :bloodline_id
      t.text :description
      t.string :short_description
      t.integer :icon_id

      t.timestamps
    end
  end
end
