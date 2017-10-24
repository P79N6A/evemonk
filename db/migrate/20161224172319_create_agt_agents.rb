# frozen_string_literal: true

class CreateAgtAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :agt_agents do |t|
      t.integer :agent_id
      t.integer :agent_type_id
      t.integer :corporation_id
      t.integer :division_id
      t.boolean :is_locator
      t.integer :level
      t.integer :location_id
      t.integer :quality
    end
  end
end
