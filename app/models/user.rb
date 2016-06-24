class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :personal_profile
  accepts_nested_attributes_for :personal_profile

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :posts

  delegate :first_name, :middle_name, :last_name, to: :personal_profile, allow: nil

  before_save :update_search_string, if: -> { email_changed? }

  def follow user
    active_relationships.create followed_id: user.id
  end

  def unfollow user
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following? user
    following.include? user
  end

  # NOTE: For now this is good enough as it gets all the recent posts
  # TODO: Build a more meaningful feed
  def feed
    relevant_user_ids = following_ids + [self.id]
    Post.where(user_id: relevant_user_ids).order('updated_at DESC')
  end

  def update_search_string
    # Email, First Name, Last Name, Middle Name
    email_local_part = self.email[/[^@]+/]
    self.search_string = "#{email_local_part.normalize} #{first_name.normalize} #{middle_name.normalize} #{last_name.normalize}".strip
  end
end
