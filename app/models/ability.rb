# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can(:read, Article, status: "public")
    return unless user.present?

    can(:read, Article)
    can(:create, Article, user: user)
    can(:destroy, Article, user: user)
    can(:update, Article, user: user)
  end
end
