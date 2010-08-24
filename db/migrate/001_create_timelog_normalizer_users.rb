class CreateTimelogNormalizerUsers < ActiveRecord::Migration
  def self.up
    create_table :timelog_normalizer_users do |t|
      t.references :user
    end
  end

  def self.down
    drop_table :timelog_normalizer_users
  end
end
