require 'csv'

class ImportHelpers

  module EPA
    module Vehicles

      IMPORT_DIR = "data/epa/greenvehicles/"

      def self.csv_load(file, col_sep="\t")
        csv_text = File.read(IMPORT_DIR + file)
        csv = CSV.parse(csv_text, :headers => true, :col_sep => "\t")
        return csv
      end

      # List of makes in source files that run over multiple words
      def self.multiword_makes
        return ['ASTON MARTIN', 'LAND ROVER', 'Azure Dynamics']
      end

      def self.is_multiword_make?(value)
        multiword_makes.each do |m|
          return true if value.include?(m)
        end
        return false
      end

      def self.parse_make_and_model(value)
        # normally first space delimits
        space_to_delimit = 0
        if is_multiword_make?(value)
          multiword_makes.each do |m|
            if value.include?(m)
              space_to_delimit = m.count(" ")
            end
          end
        end

        words = value.split(" ")
        make = words[0..space_to_delimit].join(" ").upcase
        model = words[(space_to_delimit+1)..words.size].join(" ")
        return { :make => make, :model => model }
      end

      # EPA provides booleans in form "yes" or "no"
      def self.to_boolean(value)
        return true if value == "yes"
        return false if value == "no"

        # a slightly unsatisfactory fallback here
        return !!value
      end

      def self.map_vehicle_make_fields(row)
        make_and_model = parse_make_and_model(row["Model"])
        mapping = {
          :make => make_and_model[:make],
          :source => "EPA"
        }
        return mapping
      end

      def self.map_vehicle_class_fields(row)
        mapping = {
          :vehicle_class => row["Veh Class"],
          :source => "EPA"
        }
        return mapping
      end

      def self.map_vehicle_model_fields(row, model_year)
        make_and_model = parse_make_and_model(row["Model"])
        make = make_and_model[:make]
        model = make_and_model[:model]
        veh_class = row["Veh Class"]
        mapping = {
          :vehicle_make_id => VehicleMake.find_by_make(make).id,
          :vehicle_class_id => VehicleClass.find_by_vehicle_class(veh_class).id,
          :model => model,
          :model_year => model_year.to_i,
          :engine_volume => row["Displ"],
          :cylinders => row["Cyl"].to_i,
          :transmission => row["Trans"],
          :drive => row["Drive"],
          :fuel => row["Fuel"],
          :sales_area => row["Sales Area"],
          :stnd => row["Stnd"],
          :description => row["Stnd Description"],
          :underhood_id => row["Underhood ID"],
          :air_pollution_score => row["Air Pollution Score"].to_i,
          :city_mpg => row["City MPG"].to_i,
          :hwy_mpg => row["Hwy MPG"].to_i,
          :combined_mpg => row["Cmb MPG"].to_i,
          :greenhouse_gas_score => row["Greenhouse Gas Score"].to_i,
          :smart_way => to_boolean(row["SmartWay"]),
          :source => "EPA"
        }
        return mapping
      end

    end
  end

end
