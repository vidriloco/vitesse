class CreateLugares < ActiveRecord::Migration
  def self.up
    create_table :lugares do |t|
      t.string :nombre
      t.text :detalles
      t.string :twitter
      t.string :facebook
      t.string :correo
      t.integer :telefono_uno
      t.integer :telefono_dos
      t.string :string
      t.string :sitio_web

      t.timestamps
    end
  end

  def self.down
    drop_table :lugares
  end
end
