class CreateUserword < ActiveRecord::Migration
  def change
    create_table :userword, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
        t.string    :word
        t.integer   :user_id
        t.timestamps
    end

    add_index :userword, [:user_id, :word], :unique => true
  end
end
