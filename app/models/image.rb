# Represents an image
#
class Image < UserUpload

  has_many :product_images, :dependent => :destroy
  has_many :products, :through => :product_images
  
  MAX_SIZE = 10.megabyte

  has_attached_file :upload, :styles => { :thumb => '50x50>', :small => '200x200' } # TODO: Set :url and :path
  attr_protected :upload_file_name, :upload_content_type, :upload_size  
  validates_attachment_size :upload, :less_than=>MAX_SIZE
end
