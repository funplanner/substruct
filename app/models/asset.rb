# Represents any type of user upload that's not an image.
#
class Asset < UserUpload
  
  MAX_SIZE = 10.megabyte

  has_attached_file :upload # TODO: Set :url and :path
  attr_protected :upload_file_name, :upload_content_type, :upload_size  
  validates_attachment_size :upload, :less_than=>MAX_SIZE
end