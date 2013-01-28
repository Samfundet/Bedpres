# encoding: utf-8
#
# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  presentation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Participation < ActiveRecord::Base
  attr_accessible :user, :presentation, :presentation_id
  belongs_to :user
  belongs_to :presentation

  validates_presence_of :user_id, :user, :presentation_id, :presentation

  validate :presentation_canceled
  validate :presentation_date_passed
  validate :presentation_guest_limit
  validate :presentation_contains_user

  before_destroy :presentation_canceled
  before_destroy :presentation_date_passed

  private

  def presentation_canceled
    if presentation and presentation.canceled
      errors.add(:base, "Denne presentasjonen er desverre avlyst og påmelding/avmelding har derfor avsluttet..")
    end

    errors.blank?
  end

  def presentation_date_passed
    if presentation and ( Time.now >= presentation.presentation_date )
      errors.add(:base, "Denne presentasjonen er dessverre over og påmelding/avmelding har derfor avsluttet.")
    end

    errors.blank?
  end

  def presentation_guest_limit
    if presentation and ( presentation.users.size >= presentation.guest_limit )
      errors.add(:base, "Denne presentasjonen er desverre full.")
    end
  end

  def presentation_contains_user
    if presentation and ( presentation.users.include? user )
      errors.add(:base, "Du er allerede påmeldt denne presentasjonen.")
    end
  end

end
