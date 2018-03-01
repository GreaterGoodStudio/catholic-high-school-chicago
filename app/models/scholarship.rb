class Scholarship < ApplicationRecord
  active_admin_translates :description do
    validates :description, presence: true
  end

  validates :name, presence: true, uniqueness: true
  validates :website, presence: true
end
