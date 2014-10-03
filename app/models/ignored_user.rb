# coding: utf-8
# == Schema Information
#
# Table name: ignored_users
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  ignorable_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class IgnoredUser < ActiveRecord::Base
  include Concerns::AsJson

  belongs_to :user
  belongs_to :ignored_user, class_name: "User", foreign_key: :ignorable_id
end
