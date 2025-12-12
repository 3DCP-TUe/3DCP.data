# Temperature: single-point

Data source folder: `temperature_point`

## Description of the data source

Single-point temperature measurements. 

## Data collection

Data collection depends on used measurement setup. 

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

| Column                  | Unit       | Description                                                       |
|-------------------------|------------|-------------------------------------------------------------------|
| `deposition_date`       | yyyy-MM-dd | Date when the material was deposited                              |
| `deposition_time_start` | HH:mm:ss   | Start time of deposition                                          |
| `deposition_time_end`   | HH:mm:ss   | End time of deposition                                            |
| `testing_date`          | yyyy-MM-dd | Date when the test was performed                                  |
| `testing_time_start`    | HH:mm:ss   | Start time of the test                                            |
| `file_name`             | –          | Filename containing the detailed measurement data                 |
| `position_x`            | mm         | X-coordinate of the measurement point (NaN if not applicable)     |
| `position_y`            | mm         | Y-coordinate of the measurement point (NaN if not applicable)     |
| `position_z`            | mm         | Z-coordinate of the measurement point (NaN if not applicable)     |


*Note:* If the sample position is not applicable (e.g., a non-spatial, off-line measurement), the position_x/y/z columns should still exist and be filled with `NaN`.

---

**`sample_i.csv`** or **`measurement_i.csv`**

| Column       | Unit         | Description                              |
|--------------|--------------|------------------------------------------|
| `time`       | HH:mm:ss.SSS | Clock time of measurement                |
| `age`        | HH:mm:ss.SSS | Age of the sample at measurement         |
| `temperature`| °C           | Measured temperature                     |

