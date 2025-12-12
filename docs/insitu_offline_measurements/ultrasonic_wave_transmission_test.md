# Ultrasonic wave transmission test (UWTT)

Data source folder: `uwtt`

## Description of the data source

The UWTT can be used in-situ, but is used in our facilities as an off-line test on material sampled from the system. With this test, ultrasonic waves are continuously sent through objects from which the material stiffness can be predicted. The test is performed using compression (P) waves according to NEN-EN 12504-4 in a commercially available system (IP-8 Measuring System from UltraTest GmbH, Germany). Details can be found in [Wolfs et al. (2018)](https://doi.org/10.1016/j.conbuildmat.2018.06.060).  

## Data collection

The commercially available software that comes with the device is used to acquire the data.

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

| Column                 | Unit       | Description                                   |
|------------------------|------------|-----------------------------------------------|
| `deposition_date`      | yyyy-MM-dd | Date when the material was deposited          |
| `deposition_time_start`| HH:mm:ss   | Start time of deposition                      |
| `deposition_time_end`  | HH:mm:ss   | End time of deposition                        |
| `testing_date`         | yyyy-MM-dd | Date when the test was performed              |
| `testing_time_start`   | HH:mm:ss   | Start time of the test                        |
| `file_name`            | –          | Filename containing the detailed test data    |
| `distance`             | mm         | Distance between transducers                  |


---

**`sample_i.csv`**

| Column        | Unit       | Description                              |
|---------------|------------|------------------------------------------|
| `time`        | HH:mm:ss   | Clock time of each measurement           |
| `age`         | HH:mm:ss   | Age of the sample at the time of testing |
| `velocity`    | m/s        | Measured ultrasonic pulse velocity       |
| `acceleration`| m/s²       | Measured acceleration of the pulse       |
| `temperature` | °C         | Temperature of the sample during testing |

