class FAQ < ApplicationRecord
  acts_as_list
  
  active_admin_translates :question, :answer do
    validates :question, presence: true, uniqueness: true
    validates :answer, presence: true
  end
end
