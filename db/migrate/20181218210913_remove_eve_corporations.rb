# frozen_string_literal: true

class RemoveEveCorporations < ActiveRecord::Migration[5.2]
  def change
    drop_table :eve_corporations do |t|
      t.string :name
      t.string :ticker
      t.integer :member_count
      t.integer :ceo_id
      t.integer :alliance_id
      t.text :description
      t.decimal :tax_rate
      t.datetime :date_founded
      t.integer :creator_id
      t.string :corporation_url
      t.integer :faction_id
      t.integer :home_station_id
      t.integer :shares
      t.timestamps
      t.integer :corporation_id
      t.index :corporation_id, unique: true
    end
  end
end
