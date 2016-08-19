class Photo < ApplicationRecord
  belongs_to :product
  has_attached_file :image, styles: {:small => "150x150>", :large => "320x240>"}
  # validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
