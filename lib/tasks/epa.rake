require 'import_helpers'
require 'debugger'
require 'colorize'

namespace :epa do
  namespace :vehicles do

    task :import_all => [:create_makes, :create_classes, :create_models] do
      puts I18n.t("epa.vehicles.import_complete").green
    end

    task :delete_all => [:delete_models, :delete_classes, :delete_makes] do
      puts I18n.t("epa.vehicles.data_deleted").green
    end

    task :create_makes => :environment do
      i = 0
      csv = ImportHelpers::EPA::Vehicles::csv_load
      csv.each do |row|
        row = row.to_hash.with_indifferent_access
        data = ImportHelpers::EPA::Vehicles::map_vehicle_make_fields(row)
        VehicleMake.where(data).first_or_create! { i += 1 }
      end
      puts I18n.t("epa.vehicles.imported_makes", :count => i)
    end

    task :delete_makes => :environment do
      VehicleMake.delete_all
      puts I18n.t("epa.vehicles.deleted_makes")
    end

    task :create_classes => :environment do
      i = 0
      csv = ImportHelpers::EPA::Vehicles::csv_load
      csv.each do |row|
        row = row.to_hash.with_indifferent_access
        data = ImportHelpers::EPA::Vehicles::map_vehicle_class_fields(row)
        VehicleClass.where(data).first_or_create! { i += 1 }
      end
      puts I18n.t("epa.vehicles.imported_classes", :count => i)
    end

    task :delete_classes => :environment do
      VehicleClass.delete_all
      puts I18n.t("epa.vehicles.deleted_classes")
    end

    task :create_models => :environment do
      i = 0
      csv = ImportHelpers::EPA::Vehicles::csv_load
      csv.each do |row|
        row = row.to_hash.with_indifferent_access
        data = ImportHelpers::EPA::Vehicles::map_vehicle_model_fields(row)
        VehicleModel.where(data).first_or_create! { i += 1 }
      end
      puts I18n.t("epa.vehicles.imported_models", :count => i)
    end

    task :delete_models => :environment do
      VehicleModel.delete_all
      puts I18n.t("epa.vehicles.deleted_models")
    end

  end
end
