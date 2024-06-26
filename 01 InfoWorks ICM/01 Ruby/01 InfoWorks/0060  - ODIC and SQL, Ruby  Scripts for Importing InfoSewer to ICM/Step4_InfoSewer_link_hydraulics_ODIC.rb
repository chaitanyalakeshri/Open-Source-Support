# Access the current open network in the application
open_net = WSApplication.current_network

# Define the configuration and CSV file paths
# The user is prompted to select the folders containing the configuration and CSV files
csv = WSApplication.prompt("InfoSewer PipeHyd File", [
    ['Pick the Folder', 'String', nil, nil, 'FOLDER', 'PipeHyd File']
  ], false)
cfg = WSApplication.prompt("InfoSewer CFG File Folder", [
    ['Pick the Folder', 'String', nil, nil, 'FOLDER', 'Scenario Folder']
  ], false)
  puts csv
  puts cfg

# List of import steps
import_steps = [
    ['Conduit', 'Step4_InfoSewer_link_hydraulics_pipehyd_csv.cfg', 'pipehyd.csv']
]

import_steps.each do |layer, cfg_file, csv_file|
    begin
        open_net.odic_import_ex('csv', File.join(cfg, cfg_file), nil, layer, File.join(csv, csv_file))
        puts "Imported #{layer} layer from #{cfg_file}"
    rescue StandardError => e
        puts ("An error occurred during the import of #{layer} from #{cfg_file}: #{e.message}")
    end
end

# Indicate the completion of the import process
puts "Finished Import of InfoSewer to ICM InfoWorks"
