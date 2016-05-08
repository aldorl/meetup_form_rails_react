class AddTechnologyColumnToMeetup < ActiveRecord::Migration
    def change
        add_column :meetups, :technology, :string, null: false, default: "Rails"
    end
end
