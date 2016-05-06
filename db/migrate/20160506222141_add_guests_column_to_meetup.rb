class AddGuestsColumnToMeetup < ActiveRecord::Migration
    def change
        add_column :meetups, :guests, :text
    end
end
