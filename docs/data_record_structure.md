# Data record 

The data record is organized in a folder structure containing: 
  - **yyymmdd_session_i**: A single data record can contain multiple sessions, which may be grouped by topic, theme or publication. A session folder contains a session metadata file that describes the system layout (location of system components), the materials used, and to which system component the materials were fed. Each session contains several folders, each holding the data acquired from a specific data source. Two additional folders are included for videos and photos of the session. These can contain, for example, photos of the printed objects and the assembled system.
  - **data_source**: For each data source folder, three subfolders exist: setupinfo, raw data, processed data, and scripts. The **setupinfo** folder contains metadata that describes the experiment. The **scripts** folder contains only the scripts that process the **raw_data** of that specific experiment and saves it in the **processed_data** folder, allowing for reproducibility. The format of the __process_data__ folder is predefined for the following sources:

    [System data](system_data/README.md) 
      - [system metadata file](system_data/metadata_file.md)
      - [material_components](system_data/material_components.md)
      - [system_components](system_data/system_components.md)
    
    [In-line and on-line measurements](inline_online_measurements/README.md)    
      - [mass_flow_bucket_test](inline_online_measurements/mass_flow_bucket_test.md)
      - [slugs_test](inline_online_measurements/slugs_test.md)
      - [tracer_experiment](inline_online_measurements/tracer_experiment.md)
        
    [In-situ and off-line measurements](insitu_offline_measurements/README.md)
      - [compression_test](insitu_offline_measurements/compression_test.md)
      - [fpit](insitu_offline_measurements/flat_punch_indentation_test.md) (flat punch indentation test)
      - [pocket_shear_vane](insitu_offline_measurements/pocket_shear_vane_test.md)
      - [temperature_point](insitu_offline_measurements/temperature_point.md)
      - [uwtt](insitu_offline_measurements/ultrasonic_wave_transmission_test.md) (ultrasound wave transmission test)
      - [uuct](insitu_offline_measurements/unconfined_uniaxial_compression_test.md) (unconfined uniaxial compression test)
        
- **analysis**: Contains scripts to perform analysis over multiple sessions. For example, to find correlations between experiments. 
- **misc**: An optional folder that contains all other material that is not (yet) categorized, such as small additional experiments, preliminary analyses, or miscellaneous data files.
- **metadata_record.yml**: Each record contains a metadata file that includes information about the creators and a description of the data record, explaining the purpose for which it was created. This metadata file follows the structure of zenodo. A template/example can be found [here](../src/template/metadata_record.yml).

The figure below shows a typical folder structure of a data record. A template/example of a data record can be found [here](src/template).

```
+-- datarecord
|   +-- yyyymmdd_session_i
|   |   +-- system_data
|   |   |   +-- raw_data
|   |   |   |   +-- *.csv
|   |   |   |   +-- *_event_comments.csv
|   |   |   +-- processed_data
|   |   |   |   +-- plot1.pdf
|   |   |   |   +-- ...
|   |   |   +-- setupinfo
|   |   |   |   +-- material_components
|   |   |   |   |   +-- component-1
|   |   |   |   |   +-- component-2
|   |   |   |   +-- system_components
|   |   |   |   |   +-- component-1
|   |   |   |   |   +-- component-2
|   |   |   |   +-- metadata.yml
|   |   |   +-- scripts
|   |   |   |   +-- analysis.m
|   |   +-- tracer_experiment
|   |   |   +-- raw_data
|   |   |   |   +-- *.csv
|   |   |   +-- processed_data
|   |   |   |   +-- *.csv
|   |   |   |   +-- ...
|   |   |   +-- setupinfo
|   |   |   |   +-- metadata.yml
|   |   |   +-- scripts
|   |   |   |   +-- concrete_candy_tracker.m
|   |   +-- slug_test
|   |   |   +-- raw_data
|   |   |   |   +-- *.csv
|   |   |   +-- processed_data
|   |   |   |   +-- *.csv
|   |   |   |   +-- plot1.pdf
|   |   |   |   +-- ...
|   |   |   +-- setupinfo
|   |   |   |   +-- metadata.yml
|   |   |   +-- scripts
|   |   |   |   +-- droplet_detective.m
|   |   +-- photos
|   |   |   +-- photo_1.jpg
|   |   |   +-- ...
|   |   +-- videos
|   |   |   +-- video_1.mp4
|   |   |   +-- ...    
|   |   +-- metadata_session.yml
|   +-- yyyymmdd_session_i+1
|   |   +-- system_data
|   |   +-- metadata_session.yml
|   |   +-- ...
|   +-- misc
|   |   +-- ...
|   +-- analysis
|   |   +-- figures
|   |   +-- tables
|   |   +-- script.m
|   |   +-- ...
|   +-- metadata_record.yml
|   +-- LICENSE
```
