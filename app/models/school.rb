class School < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  geocoded_by :address

  has_many :calendar_events, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  active_admin_translates :application, :description, :population_total, 
                          :population_yearly, :population_makeup, 
                          :tuition_merit, :tuition_assistance, :tuition_private, :transportation_options,
                          :transportation_public, :transportation_provided, :programming_support, 
                          :programming_academic, :programming_ap, :programming_extracurricular,
                          :programming_athletic,
                          fallbacks_for_empty_translations: true

  default_scope { order(:name) }

  def to_s
    name
  end

  def coordinates
    [longitude, latitude]
  end
end
