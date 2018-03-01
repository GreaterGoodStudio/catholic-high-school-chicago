class CalendarEvent < ApplicationRecord
  belongs_to :school, optional: true

  active_admin_translates :name, :description do
    validates :name, presence: true
  end

  validates :starts_at, presence: true
  validates :ends_at, presence: true

  default_scope { order(starts_at: :asc) }
  scope :universal, -> { where(school: nil) }

  def self.for_school(school)
    # Include general events too
    where(school: [school, nil]).where("starts_at >= ?", Date.today)
  end
end
