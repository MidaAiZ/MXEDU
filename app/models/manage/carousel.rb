class Manage::Carousel < ApplicationRecord
	mount_uploader :image, CarouselImageUploader
end
