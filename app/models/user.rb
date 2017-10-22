class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@unist\.ac\.kr\z/, message: "유니스트 이메일을 입력해주세요." }
end
