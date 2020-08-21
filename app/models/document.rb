class Document < ApplicationRecord
  belongs_to :user
  belongs_to :generator

  validates :name, presence: true
  validates :name, uniqueness: true   
  validates :prompt, presence: true
  validates :prompt, length: { in: 10..1000 }
  validates :length, numericality: { only_integer: true }
  validates :length, numericality: { greater_than: 10 }
  validates :length, numericality: { less_than: 1000 }
  validates :top_p, numericality: true
  validates :top_p, numericality: { greater_than_or_equal_to: 0.0 }
  validates :top_p, numericality: { less_than_or_equal_to: 1.0 }
  validates :temperature, numericality: true
  validates :temperature, numericality: { greater_than_or_equal_to: 0.001 }
  validates :temperature, numericality: { less_than_or_equal_to: 100.0 }

  scope :generated_length, -> {order(length: :desc)}

end