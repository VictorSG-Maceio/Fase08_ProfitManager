class Api::V2::ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :description, :value, :date, :created_at, :updated_at, :is_late

  def is_late
    Date.current > object.date if object.date.present?
  end
  belongs_to :user
end
