class AddSeoColumnToMeetup < ActiveRecord::Migration
    def change
        add_column :meetups, :seo, :string
    end
end
