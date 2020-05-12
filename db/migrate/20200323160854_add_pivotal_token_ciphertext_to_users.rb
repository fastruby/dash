class AddPivotalTokenCiphertextToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pivotal_token_ciphertext, :text
  end
end
