class AddLdapLoginToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ldap_login, :string
    add_column :users, :ldap_password, :string
  end
end
