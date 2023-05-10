require 'csv'

namespace :import do
  desc "Import data from CSV"
  task :data => :environment do
    file_path = "./ontariovet.csv"

    CSV.foreach(file_path, headers: true) do |row|
      id = row['id']
      name = row['name']
      city = row['city']
      phone = row['phone']
      notes = row['notes']
      email = row['email']
      website = row['website']
      my_notes = row['my notes']
      contacted = row['Contacted?']
      
      puts "importing " + name

      # You can create or update your object here
      # Let's say you have a 'Company' model
      company = Lead.find_or_initialize_by(first_name: name)
      company.update(
        first_name: name[0,63],
        last_name: "clinic",
       # city: city,
        phone: phone,
      #  notes: notes,
        email: email
     #   website: website,
      #  my_notes: my_notes,
        #contacted: contacted
      )
    end

    puts "Import finished!"
  end
end
