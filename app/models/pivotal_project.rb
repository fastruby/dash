class PivotalProject < ApplicationRecord
  validates :pivotal_id, presence: true, uniqueness: true
end
