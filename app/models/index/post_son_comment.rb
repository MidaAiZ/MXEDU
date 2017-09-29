class Index::PostSonComment < ApplicationRecord
    belongs_to :father_comment,
                class_name: 'Index:::PostComment',
                foreign_key: :post_cmt_id

    has_many :thumbs, as: :resource,
              class_name: 'Index::Thumb',
			  dependent: :destroy

    def _save user, cmt
        self.user = user
        self.father_comment = cmt
        begin
            ApplicationRecord.transaction do # 出错将回滚
                self.save!
                father_comment.update! comments_count: ((father_comment.comments_count || 0) + 1)
            end
        rescue
            return false
        end
        true
    end

    def _destroy
        ApplicationRecord.transaction do # 出错将回滚
            self.destroy!
            self.father_comment.update! comments_count: (father_comment.comments_count - 1)
        end
    end
end
