# Compression test

Data source folder: `compression_test`

## Description of the data source

Compression tests are performed by placing a cylindrical specimen in a hydraulic press and measuring it's resistance according to EN 12390-3.

## Data collection

The maximum resistance is manually recorded in a csv file that follows the structure described below.

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

| Column                  | Unit       | Description                                          |
|-------------------------|------------|------------------------------------------------------|
| `deposition_date`       | yyyy-MM-dd | Date when the material was deposited                 |
| `deposition_time_start` | HH:mm:ss   | Start time of deposition                             |
| `deposition_time_end`   | HH:mm:ss   | End time of deposition                               |
| `testing_date`          | yyyy-MM-dd | Date when the test was performed                     |
| `testing_time_start`    | HH:mm:ss   | Time when the test started                           |
| `sample_diameter`       | mm         | Diameter of the cylindrical sample                   |
| `sample_height`         | mm         | Height of the cylindrical sample                     |
| `sample_mass`           | g          | Mass of the sample                                   |
| `loading_rate`          | kN/s       | Rate at which load is applied                        |
| `density`               | kg/m³      | Density of the sample                                |
| `failure_load`          | kN         | Maximum load reached at failure                      |
| `compressive_strength`  | MPa        | Compressive strength calculated from the test        |

