# Slugs test

Data source folder: `slugs_test`

## Description of the data source

Upon extrusion, material droplets are analyzed using the "slugs test", where a load cell measures the droplet mass as it falls into a bucket placed on a load cell, and a camera captures images to estimate its volume under the assumption of axisymmetry, for details see [Bos & Wolfs (2022)](https://doi.org/10.1007/978-3-031-06116-5_67). From the droplet mass, the tensile strength and mass flow rate are predicted. Additionally, the density and volumetric flow rate are calculated from the droplet mass and volume. The use of the camera and image analysis are optional and the corresponding files are not present when the camera is not used.

## Data collection

Data acquisition is managed by a Python program that reads load cell data from its OPC UA server, while images are captured using NI Vision Builder for Automated Inspection. All tools required for data acquisition and analysis are integrated into the software package [Droplet Detective](https://github.com/3DCP-TUe/DropletDetective). 

## Data storage


The __raw_data__ folder for the slugs test typically contains a time series file with load cell data and a subfolder with captured images. The __setupinfo__ folder contains a metadata file in YAML file format that details the hardware used and its settings, including the load cell and its signal filters, as well as the camera and its settings. The __processed_data__ folder contains four files with time series data: the first file provides the yield stress derived from the droplet mass; the second, the mass flow rate; the third, the volume of a droplet obtained from the acquired images; and the last, the volume flow rate. The __scripts__ folder contains all the analysis files used to get these properties from the raw data.

### Processed data file format

The `processed_data` folder contains the following files:
   
---

**`yield_stress.csv`** contains droplet mass and yield stress measurement data over time.

| Column         | Unit         | Description                             |
|----------------|--------------|-----------------------------------------|
| `time`         | HH:mm:ss.SSS | Time of measurement                     |
| `droplet_mass` | N            | Individual droplet mass                 |
| `yield_stress` | kPa          | Corresponding yield stress              |


---

**`mass_flow.csv`** contains mass flow rate calculated per bucket.

| Column                  | Unit         | Description                                             |
|-------------------------|--------------|---------------------------------------------------------|
| `deposition_time_start` | HH:mm:ss.SSS | Starting time of collecting material in the bucket      |
| `deposition_time_mid`   | HH:mm:ss.SSS | Mean time of collecting material in the bucket          |
| `deposition_time_end`   | HH:mm:ss.SSS | Ending time of collecting material in the bucket        |
| `mass_flow`             | kg/min       | Mean mass flow over the defined time window             |


---

**`volumes.csv`** contains droplet volume data over time. Present when camera is used.

| Column                | Unit         | Description                              |
|-----------------------|--------------|------------------------------------------|
| `time`                | HH:mm:ss.SSS | Time of measurement                      |
| `mean_droplet_volume` | cm³          | Mean droplet volume                      |
| `std_droplet_volume`  | cm³          | Standard deviation of droplet volume     |


---

**`volumes_grouped.csv`** contains droplet volume data that are grouped when duplicate measures of the same droplet have been taken. Present when camera is used.

| Column                | Unit         | Description                              |
|-----------------------|--------------|------------------------------------------|
| `time`                | HH:mm:ss.SSS | Time of measurement                      |
| `mean_droplet_volume` | cm³          | Mean droplet volume                      |
| `std_droplet_volume`  | cm³          | Standard deviation of droplet volume     |


---

**`volumetric_flow.csv`** contains volumetric flow rate calculated per bucket. Present when camera is used.

| Column                  | Unit         | Description                                             |
|-------------------------|--------------|---------------------------------------------------------|
| `deposition_time_start` | HH:mm:ss.SSS | Starting time of collecting material in the bucket      |
| `deposition_time_mid`   | HH:mm:ss.SSS | Mean time of collecting material in the bucket          |
| `deposition_time_end`   | HH:mm:ss.SSS | Ending time of collecting material in the bucket        |
| `volumetric_flow_rate`  | L/min        | Volumetric flow rate over the time window               |

