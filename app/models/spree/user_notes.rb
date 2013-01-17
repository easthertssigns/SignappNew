module Spree
  class UserNotes < ActiveRecord::Base
    attr_accessible :added_at, :note_text, :spree_user_id
    belongs_to :user, :foreign_key => 'spree_user_id'
  end
end
