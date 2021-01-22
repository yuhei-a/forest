class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #フォロー機能
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :followed_user, through: :followed, source: :follower

  #DM機能
  has_many :chats
  has_many :user_rooms

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true

  #フォロー
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@guest.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    end
  end

  #退会済みの場合ログインできない処理
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  enum gender: { '秘密': 0, '男性': 1, '女性': 2 }, _prefix: true
  enum bloodtype: { '秘密': 0, 'A型': 1, 'B型': 2, 'AB型': 3, 'O型': 4 }, _prefix: true
  enum sign: { '秘密': 0, '牡羊座': 1, '牡牛座': 2, '双子座': 3, '蟹座': 4, '獅子座': 5, '乙女座': 6, '天秤座': 7, '蠍座': 8, '射手座': 9, '山羊座':10, '水瓶座': 11, '魚座': 12 }, _prefix: true
  enum prefectures: { '秘密': 0, '北海道': 1, '青森県': 2, '岩手県': 3, '宮城県': 4, '秋田県': 5, '山形県': 6, '福島県': 7, '茨城県': 8, '栃木県': 9, '群馬県': 10, '埼玉県': 11, '千葉県': 12, '東京都': 13, '神奈川県': 14, '新潟県': 15, '富山県': 16, '石川県': 17, '福井県': 18, '山梨県': 19, '長野県': 20, '岐阜県': 21, '静岡県': 22, '愛知県': 23, '三重県': 24, '滋賀県': 25, '京都府': 26, '大阪府': 27, '兵庫県': 28, '奈良県': 29, '和歌山県': 30, '鳥取県': 31, '島根県': 32, '岡山県': 33, '広島県': 34, '山口県': 35, '徳島県': 36, '香川県': 37, '愛媛県': 38, '高知県': 39, '福岡県': 40, '佐賀県': 41, '長崎県': 42, '熊本県': 43, '大分県': 44, '宮崎県': 45, '鹿児島県': 46, '沖縄県': 47 }, _prefix: true
end
