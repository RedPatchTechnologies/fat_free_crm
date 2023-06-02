require 'csv'

namespace :import do
  namespace :ontario do
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
  

  namespace :alberta do
    desc "Import data from CSV"
    task :data => :environment do
      file_path = "./avma_output.csv"

      CSV.foreach(file_path, headers: true) do |row|
        
        name = row['name']
        phone = row['phone']
        email = row['email']
        website = row['website']
        
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
          email: email,
          cf_website: website
        #  my_notes: my_notes,
          #contacted: contacted
        )
      end

      puts "Import finished!"
    end
  end
end

namespace :vca do 
  
  desc "exclude vetstrategy clinics"
  task :exclude => :environment do 
    leads = Lead.where("email LIKE '%@vca.com'")
    leads.each do |lead|
      puts "lead: " + lead.first_name.to_s
      lead.status = "rejected"
      lead.save!
    end
  end
end




namespace :vetstrategy do 
  namespace :ontario do
    desc "exclude vetstrategy clinics"
    task :data => :environment do 
      file_path = "./vet_strategy_on.csv"

      CSV.foreach(file_path, headers: true) do |row|
      
        #name = row['name']
      
        puts "importing " + row.to_s

        # You can create or update your object here
        # Let's say you have a 'Company' model
        company = Lead.find_by(first_name: row.to_s.strip)
        
        if(company.present? )
          puts "company is: " + company.first_name.to_s
          company.status = "rejected"
          company.save!
        else
          puts "don't have " + row.to_s + " in db"
        end
      end

      puts "Import finished!"
    end
  end
  
  namespace :alberta do
    desc "exclude vetstrategy clinics"
    task :data => :environment do 
      file_path = "./vet_strategy_ab.csv"

      CSV.foreach(file_path, headers: true) do |row|
      
        #name = row['name']
      
        puts "importing " + row.to_s

        # You can create or update your object here
        # Let's say you have a 'Company' model
        company = Lead.find_by(first_name: row.to_s.strip)
        
        if(company.present? )
          puts "company is: " + company.first_name.to_s
          company.status = "rejected"
          company.save!
        else
          puts "don't have " + row.to_s + " in db"
        end
      end

      puts "Import finished!"
    end
  end
end