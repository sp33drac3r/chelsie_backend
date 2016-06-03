class CreateServiceProviders < ActiveRecord::Migration
  def change
    create_table :service_providers do |t|
      t.string   :name, null: false
      t.string   :address, null: false
      t.decimal  :lat
      t.decimal  :lng
      t.string   :place_id

      t.timestamps null: false
    end
  end
end
