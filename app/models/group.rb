class Group < ActiveRecord::Base
  groupify :group, members: [:users, :assignments], default_members: :users
end
