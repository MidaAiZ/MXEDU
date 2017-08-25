class ProductsCoverUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

    '/assets/default/product'
  end

  process resize_to_fill: [270, 180]

  # Create different versions of your uploaded files:
  version :thumb do
      process resize_to_fill: [120, 60]
  end

  def filename
    if original_filename
      Digest::SHA2.hexdigest(original_filename)[0..12] + Time.now.to_i.to_s + ".#{original_filename.split('.')[-1]}"
    end
  end
end