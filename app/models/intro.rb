class Intro < ApplicationRecord
  ALLOWED_PAGES = %w{home apply schools scholarships}

  mount_uploader :image, ImageUploader

  validates :page, presence: true,
                   uniqueness: true,
                   inclusion: { in: ALLOWED_PAGES }

  active_admin_translates :copy do
    validates :copy, presence: true
  end
end
