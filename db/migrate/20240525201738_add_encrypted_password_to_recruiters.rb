class AddEncryptedPasswordToRecruiters < ActiveRecord::Migration[6.0]
  def change
    add_column :recruiters, :encrypted_password, :string, null: false
  end
end
