# Analysis

This folder contains files to perform analysis over a session and data record. The purpose is to store a collection of standard functions that act as a library. Store these files together with your dataset and adjust them if needed. If you add new functionality, please push these updates to the templates provided here so that others can also benefit from them.

## Explanation of the files and folders

- **[lib](lib):** This folder contains a collection of standard utility functions for analyzing sessions and preparing data records within the DFC.data framework.
- **[check_file_formats.m](check_file_formats.m):** Example script to check that processed experimental data is correctly formatted by verifying that required files exist and contain all necessary columns.
- **[record_update_libs.m](record_update_libs.m):** Example script that can be used to update/replace all lib folders in a data record.
- **[record_fill_system_components_folders.m](record_fill_system_components_folders.m):** Example script that fills all system component folders in the system data of every session within a data record.
- **[session_create_system_ontology.m](session_create_system_ontology.m):** Demonstrates how to generate an ontology graph from the defined system metadata of a session. 
- **[session_fill_system_components_folder.m](session_fill_system_components_folder.m):** Example script that populates the system component folder for the system data of a specific session. 
- **[session_read_io_configuration.m](session_read_io_configurationm):** Reads the I/O configuration from a session’s system data. This example shows how to navigate the configuration and distinguish between hosts (e.g., data acquisition units) and clients (e.g., sensors)
- **[test_readyaml.m](test_readyaml.m):** Test script for reading a YAML file. Demonstrates how to navigate its structure and validate its correctness.
- **[test_remove_files.m](test_remove_files.m):** Utility script to remove files with a specific extension—useful for cleaning up files like `.asv` from a data record. 
- **[test_rename_files.m](test_rename_files.m):** Renames files in a folder sequentially. Handy for renaming session photos or other files that require consistent numbering.


