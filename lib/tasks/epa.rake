require 'import_helpers'
require 'debugger'
require 'colorize'
require 'net/http'

namespace :epa do

  task :delete_all => ["vehicles:delete_all"] do
    puts I18n.t("epa.delete_completed").green
  end

  task :download_all => ["vehicles:download_all"] do
    puts I18n.t("epa.download_completed").green
  end

  task :import_all => ["vehicles:import_all"] do
    puts I18n.t("epa.import_completed").green
  end

  namespace :vehicles do

    IMPORT_FILES = {
      2000 => "all_alpha_00.txt",
      2001 => "all_alpha_01.txt",
      2002 => "all_alpha_02.txt",
      2003 => "all_alpha_03.txt",
      2004 => "all_alpha_04.txt",
      2005 => "all_alpha_05.txt",
      2006 => "all_alpha_06.txt",
      2007 => "all_alpha_07.txt",
      2008 => "all_alpha_08.txt",
      2009 => "all_alpha_09.txt",
      2010 => "all_alpha_10.txt",
      2011 => "all_alpha_11.txt",
      2012 => "all_alpha_12.txt",
      2013 => "all_alpha_13.txt",
      2014 => "all_alpha_14.txt"
    }

    task :download_all => :environment do
      app_path = Rake.application.original_dir
      save_path = "#{app_path}/data/epa/greenvehicles"
      (0..14).each do |i|
        yr = "%02d" % i
        filename = "all_alpha_#{yr}.txt"
        uri = URI("http://www.fueleconomy.gov/feg/EPAGreenGuide/txt/#{filename}")
        content = Net::HTTP.get(uri)
        f = File.new("#{save_path}/#{filename}", "w")
        f.write(content)
        f.close
      end
      puts I18n.t("epa.vehicles.download_complete").green
    end

    task :import_all => [:create_makes, :create_classes, :create_models] do
      puts I18n.t("epa.vehicles.import_complete").green
    end

    task :delete_all => [:delete_models, :delete_classes, :delete_makes] do
      puts I18n.t("epa.vehicles.data_deleted").green
    end

    task :create_makes => :environment do
      puts I18n.t("epa.vehicles.importing_makes").blue
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          unless row.empty?
            row = row.to_hash.with_indifferent_access
            data = ImportHelpers::EPA::Vehicles::map_vehicle_make_fields(row)
            VehicleMake.where(data).first_or_create! { i += 1 }
          end
        end
        puts I18n.t("epa.vehicles.imported_makes_year", :year => year)
      end
      puts I18n.t("epa.vehicles.imported_makes", :count => i).green
    end

    task :delete_makes => :environment do
      VehicleMake.delete_all
      puts I18n.t("epa.vehicles.deleted_makes")
    end

    task :create_classes => :environment do
      puts I18n.t("epa.vehicles.importing_classes").blue
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          unless row.empty?
            row = row.to_hash.with_indifferent_access
            data = ImportHelpers::EPA::Vehicles::map_vehicle_class_fields(row)
            VehicleClass.where(data).first_or_create! { i += 1 }
          end
        end
        puts I18n.t("epa.vehicles.imported_classes_year", :year => year)
      end
      puts I18n.t("epa.vehicles.imported_classes", :count => i).green
    end

    task :delete_classes => :environment do
      VehicleClass.delete_all
      puts I18n.t("epa.vehicles.deleted_classes")
    end

    task :create_models => :environment do
      puts I18n.t("epa.vehicles.importing_models").blue
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          unless row.empty?
            row = row.to_hash.with_indifferent_access
            data = ImportHelpers::EPA::Vehicles::map_vehicle_model_fields(row, year)
            VehicleModel.where(data).first_or_create! { i += 1 }
          end
        end
        puts I18n.t("epa.vehicles.imported_models_year", :year => year)
      end
      puts I18n.t("epa.vehicles.imported_models", :count => i).green
    end

    task :delete_models => :environment do
      VehicleModel.delete_all
      puts I18n.t("epa.vehicles.deleted_models")
    end

  end
end
