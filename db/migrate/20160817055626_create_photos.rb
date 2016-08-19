class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
    	t.string :image_file_name
    	t.string :image_content_type
		  t.references :product
      t.timestamps
    end
  end
end
