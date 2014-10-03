class AddInitialTables < ActiveRecord::Migration
  def change

  	create_table(:users) do |t|
      t.string     :mobile_number
      t.string     :access_token
      t.string     :operating_system, default: 'Android', null: false
      t.string     :device_token
      t.boolean    :active, default: false, null: false

      t.timestamps
    end
    add_index       :users, :mobile_number

    create_table(:profiles) do |t|
      t.string      :profile_type, default: 'Personal', null: false
      t.string      :name
      t.string      :email
      t.attachment  :avatar
      t.string      :website
      t.string      :company
      t.string      :job_title
      t.boolean     :default, default: false, null: false
      t.integer     :user_id

      t.timestamps
    end
    add_index       :profiles, :user_id

    create_table(:ignored_users) do |t|
      t.integer     :user_id
      t.integer     :ignorable_id

      t.timestamps
    end
    add_index       :ignored_users, :user_id
    add_index       :ignored_users, :ignorable_id


    create_table(:verification_codes) do |t|
      t.string      :mobile_number
      t.string      :code
      t.string      :name

      t.timestamps
    end

	end
end