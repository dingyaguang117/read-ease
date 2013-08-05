class CreateUser < ActiveRecord::Migration
  def change
    create_table :user , :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
        t.string :username
        t.string :password
        t.string :nickname
        t.string :email
        t.string :avatar
        t.time   :birthday
        t.integer   :knownWords
        t.time      :createTime
        t.time      :lastLoginTime
        t.time      :loginTime

        t.string    :weiboId
        t.string    :weiboName
        t.string    :weiboToken

        t.timestamps
    end

    add_index :user, [:username] , unique: true
    add_index :user, [:weiboId] , unique: true
  end
end
