class Tag < ApplicationRecord
  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags

  scope :with_counts, -> {
    left_outer_joins(:ticket_tags).select("tags.*, COUNT(ticket_tags.id)")
                                  .group("tags.id")
  }

  scope :alphabetical, -> { order(name: :asc) }
  validates :name, presence: true
end