require 'carrierwave/processing/mini_magick'

class CoursesUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    asset_host('fallback/' + [version_name, 'default-photo.png'].compact.join('_'))
  end
end
