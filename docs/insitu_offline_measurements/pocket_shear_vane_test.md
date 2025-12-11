# Pocket shear vane

Data source folder: `pocket_shear_vane`

## Description of the data source

The pocket shear vane test estimates the shear strength of cohesive materials by pressing a vane into the surface and rotating it until failure occurs, with the maximum torque recorded to determine shear strength. For printed samples, the vane is pressed into the concrete as soon as possible after deposition. The test is then conducted at distinct concrete ages by rotating the vane and recording the torque value. The test follows the ASTM D8121/D8121M-19 standard. 

## Data collection

Torque values are manually recorded during the pocket shear vane test. 

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

|Columns                        | Units      |
|-------------------------------|------------|
| deposition_date               | yyyy-MM-dd |
| deposition_time_start         | HH:mm:ss   |
| deposition_time_end           | HH:mm:ss   |
| insertion_time                | HH:mm:ss   |
| testing_date                  | yyyy-MM-dd |
| testing_time_start            | HH:mm:ss   |
| vane_diameter                 | mm         |
| vane_height                   | mm         |
| vane_material                 | mm         |
| shear_strength                | kPa        |
