# Unconfined uniaxial compresstion test (UUCT)

Data source folder: `uuct`

## Description of the data source

The UUCT is typically used to determine the early-age mechanical properties of the concrete within the first hours. In this destructive test, cylindrical specimens are made and compressed at distinct concrete ages. From this, the stiffness modulus and unconfined compressive strength can be derived. Details can be found in [Wolfs et al. (2018)](https://doi.org/10.1016/j.cemconres.2018.02.001). The test can be conducted in several test rigs and is selected depending on laboratory availability. From the test, the load-displacement data during sample loading is obtained. Additionally, optical measurements are used to measure the sample width during loading to calculate the true stress and strain.

## Data collection

Data collection depends on the test rig that is used. 

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

| Column                  | Unit       | Description                                   |
|-------------------------|------------|-----------------------------------------------|
| `deposition_date`       | yyyy-MM-dd | Date when the material was deposited          |
| `deposition_time_start` | HH:mm:ss   | Start time of deposition                      |
| `deposition_time_end`   | HH:mm:ss   | End time of deposition                        |
| `testing_date`          | yyyy-MM-dd | Date when the test was performed              |
| `testing_time`          | HH:mm:ss   | Time when the test was performed              |
| `file_name`             | –          | Filename containing the detailed test data    |
| `loading_rate`          | mm/min     | Loading rate applied during the compression   |
| `sample_radius`         | mm         | Radius of the cylindrical sample              |
| `sample_height`         | mm         | Height of the cylindrical sample              |
| `stiffness_modulus`     | MPa        | Calculated stiffness modulus                  |
| `compressive_strength`  | MPa        | Calculated compressive strength               |

---

**`sample_i.csv`**

| Column         | Unit         | Description                         |
|----------------|--------------|-------------------------------------|
| `time`         | HH:mm:ss.SSS | Clock time of each measurement      |
| `load`         | N            | Applied compression load            |
| `displacement` | mm           | Vertical displacement of the sample |
| `width`        | mm           | Sample width                        |
