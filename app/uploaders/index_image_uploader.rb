# encoding: utf-8
class IndexImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/index/images/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process resize_to_fit: [600, 1200]
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [250, 500]
  end
  #
  # version :content do
  #   process :resize_to_limit => [800, 800]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def filename
    if original_filename
      Digest::SHA2.hexdigest(original_filename)[0..12] + Time.now.to_i.to_s + ".#{original_filename.split('.')[-1]}"
    end
  end

  private

  def check_resize(limit_width, limit_height)
    img_width = width
    img_height = height
    if img_width > limit_width || img_height > limit_height
      begin
        img_width *= 0.9
        img_height *= 0.9
      end until img_width < limit_width && img_height < limit_height

      resize_to_fit(img_width, img_height)
    end
  end
end