class Document < ApplicationRecord
  belongs_to :user
  belongs_to :generator

  scope :generated_length, -> {order(length: :desc)}

end
