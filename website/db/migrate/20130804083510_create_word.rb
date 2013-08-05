class CreateWord < ActiveRecord::Migration
  def change
    create_table :word , :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
        t.string  :text
        t.string  :chText
        t.string  :soundmark
        t.string  :soundUrl
        t.string :lang
        t.integer :classId
        t.timestamps
    end
    
    add_index :word, [:text, :classId], :unique => true
    
  end
end
