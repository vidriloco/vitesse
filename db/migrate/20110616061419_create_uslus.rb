class CreateUslus < ActiveRecord::Migration
  def self.up
    create_table :uslus do |t|
      t.integer :usuario_id
      t.integer :lugar_id
      t.integer :permisos

      t.timestamps
    end
    
    execute "ALTER TABLE uslus ADD CONSTRAINT uslus_unique_identificador
              UNIQUE(usuario_id, lugar_id)"
  end

  def self.down
    drop_table :uslus
  end
end
