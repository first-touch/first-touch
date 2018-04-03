class User < ApplicationRecord
  rolify
  has_secure_password

  has_one :personal_profile
  accepts_nested_attributes_for :personal_profile

  has_many :career_entries
  accepts_nested_attributes_for :career_entries
  has_many :active_relationships,
           class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy

  has_many :passive_relationships,
           class_name: 'Relationship',
           foreign_key: 'followed_id',
           dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :connections
  has_many :known_people,
           -> { where status: 'accepted' },
           through: :connections

  has_many :posts, as: :author
  has_many :sent_messages, class_name: 'Message', foreign_key: 'creator_id'
  has_many :messages_to_receive,
           class_name: 'MessageRecipient',
           foreign_key: 'recipient_id'

  has_many :club_users
  has_many :clubs, through: :club_users

  has_many :managed_clubs, foreign_key: :account_owner_id, class_name: 'Club'

  has_many :team_users
  has_many :teams, through: :team_users

  has_many :notes
  has_many :reports
  has_many :orders

  #@TODO put this in team when they are ready
  has_many :reports_buy, foreign_key: :customer_id, class_name: 'Order'

  before_save :update_search_string, if: -> { email_changed? }

  def connection_status(user)
    status = Connection.where(user_id: user.id).or(
      Connection.where(connected_to_id: user.id)
    ).pluck(:status)
    return 'not_connected' if status.empty?
    return 'connected' if status.uniq.length == 1 && status[0] == 'accepted'
    'pending'
  end

  def follow(user)
    active_relationships.create followed_id: user.id
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include? user
  end

  # NOTE: For now this is good enough as it gets all the recent posts
  # TODO: Build a more meaningful feed
  def feed
    relevant_user_ids = following_ids + [id]
    Post.where(
      author_id: relevant_user_ids,
      author_type: 'User'
    ).order('updated_at DESC')
  end

  def received_messages
    messages_to_receive.joins(:message).map(&:message)
  end

  def inbox
    full_inbox = sent_messages.includes(:message_recipient).group_by do |ms|
      ms.message_recipient.recipient
    end
    messages_to_add = received_messages.group_by(&:creator)
    messages_to_add.each do |sender_id, messages|
      full_inbox[sender_id] ||= []
      full_inbox[sender_id] += messages
      full_inbox[sender_id].sort_by!(&:created_at)
    end
    full_inbox
  end

  # NOTE: simple network graph.
  # TODO: Get a more efficient way of building the network graph
  def network
    {
      following: following,
      followers: followers
    }
  end

  def full_chat_with(user)
    outgoing = sent_messages.includes(:message_recipient)
                            .where(message_recipients: { recipient: user })
    incoming = received_messages.select { |m| m.creator_id == user.id }
    (outgoing + incoming).sort_by!(&:created_at)
  end

  def first_name
    personal_profile.try(:first_name) || ''
  end

  def middle_name
    personal_profile.try(:middle_name) || ''
  end

  def last_name
    personal_profile.try(:last_name) || ''
  end

  def full_name
    [first_name, middle_name, last_name].join ' '
  end

  def email_local_part
    email[/[^@]+/] || ''
  end

  def display_name
    name = [first_name, middle_name, last_name]
           .join(' ')
           .squish
    name = email_local_part if name.empty?
    name
  end

  def update_search_string
    f_name = first_name.try(:normalize) || ''
    m_name = middle_name.try(:normalize) || ''
    l_name = last_name.try(:normalize) || ''

    self.search_string = "#{email_local_part.normalize} "\
                         "#{f_name.normalize} #{m_name.normalize} "\
                         "#{l_name.normalize}".strip
  end

  def career_history
    career_entries.order(start_date: :desc)
  end
end
