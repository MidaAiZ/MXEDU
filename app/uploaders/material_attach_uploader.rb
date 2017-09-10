class MaterialAttachUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/materials/files/#{model.id}"
  end


  def filename
    if original_filename
      Digest::SHA2.hexdigest(original_filename)[0..12]+Time.now.to_i.to_s+".#{original_filename.split('.')[-1]}"
    end
  end

end
