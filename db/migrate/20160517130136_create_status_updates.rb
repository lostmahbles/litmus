class CreateStatusUpdates < ActiveRecord::Migration
  def change
    create_table :status_updates do |t|
      t.string     :system_status, limit: 10, null: false
      t.text       :message
      t.timestamps                 null: false
    end

    #
    # We could probably use the primary key 'id' as the index instead but
    # that would require always remembering to sort on 'id DESC' which isn't
    # all that intuitive and in the long run would probably lead to
    # fetches on a non-indexed 'created_at DESC'. So we'll use the index
    # here in favor of developer friendliness over premature optimization.
    #
    add_index :status_updates, :created_at, order: { created_at: :desc }
  end
end
