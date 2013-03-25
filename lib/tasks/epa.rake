require 'import_helpers'
require 'debugger'
require 'colorize'

namespace :epa do

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
      2012 => "all_alpha_12.txt"
    }

    task :import_all => [:create_makes, :create_classes, :create_models] do
      puts I18n.t("epa.vehicles.import_complete").green
    end

    task :delete_all => [:delete_models, :delete_classes, :delete_makes] do
      puts I18n.t("epa.vehicles.data_deleted").green
    end

    task :create_makes => :environment do
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          row = row.to_hash.with_indifferent_access
          data = ImportHelpers::EPA::Vehicles::map_vehicle_make_fields(row)
          VehicleMake.where(data).first_or_create! { i += 1 }
        end
      end
      puts I18n.t("epa.vehicles.imported_makes", :count => i)
    end

    task :delete_makes => :environment do
      VehicleMake.delete_all
      puts I18n.t("epa.vehicles.deleted_makes")
    end

    task :create_classes => :environment do
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          row = row.to_hash.with_indifferent_access
          data = ImportHelpers::EPA::Vehicles::map_vehicle_class_fields(row)
          VehicleClass.where(data).first_or_create! { i += 1 }
        end
      end
      puts I18n.t("epa.vehicles.imported_classes", :count => i)
    end

    task :delete_classes => :environment do
      VehicleClass.delete_all
      puts I18n.t("epa.vehicles.deleted_classes")
    end

    task :create_models => :environment do
      i = 0
      IMPORT_FILES.each do |year, file|
        csv = ImportHelpers::EPA::Vehicles::csv_load file
        csv.each do |row|
          row = row.to_hash.with_indifferent_access
          data = ImportHelpers::EPA::Vehicles::map_vehicle_model_fields(row, year)
          VehicleModel.where(data).first_or_create! { i += 1 }
        end
      end
      puts I18n.t("epa.vehicles.imported_models", :count => i)
    end

    task :delete_models => :environment do
      VehicleModel.delete_all
      puts I18n.t("epa.vehicles.deleted_models")
    end

  end
end
