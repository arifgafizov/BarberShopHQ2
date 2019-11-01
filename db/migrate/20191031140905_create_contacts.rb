class CreateContacts < ActiveRecord::Migration[6.0]
  def change
  	  	create_table :contacts do |cont|
	      cont.text :contact_email
	      cont.text :message

	      cont.timestamps
		end
  end
end
