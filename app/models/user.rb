# coding: utf-8
class User < ActiveRecord::Base
  has_many :profiles
  has_many :ignored_users
end