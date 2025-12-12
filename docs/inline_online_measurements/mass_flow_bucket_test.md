# Mass flow bucket test

Data source folder: `mass_flow_bucket_test`

## Description of the data source

The mass flow bucket test is a simple method used to determine the mass flow rate of material exiting a nozzle. Material is collected in a bucket over a specified time interval and then weighed. Dividing the collected mass by the duration of the time window yields the mass flow rate. This test can be performed before and after printing, or for example between prints when producing multiple elements.

## Data collection

The test can be performed manually by collecting material in a bucket and weighing it afterward. Higher-frequency measurements can also be carried out (semi-)automatically using the same setup as the slugs test, which uses a load cell on which the bucket is placed while material is continuously deposited in it. For this setup, example file for data acquisition and analysis are available in the software package [Droplet Detective](https://github.com/3DCP-TUe/DropletDetective). 

## Data storage

The __raw_data__ folder typically contains a time-series file with load-cell data if the test is performed using the slugs test setup. If the test is conducted manually, it contains notes and records of the measured masses. The __setupinfo__ folder contains a metadata file in YAML format describing the hardware configuration and settings. For semi-automated tests, this includes details on the load cell and any applied signal filters. For manual tests, it includes information about the scale used. The __processed_data__ folder contains a file time series data that contains calculated the mass flow rate. The __scripts__ folder contains all the analysis files used to get these properties from the raw data.

### Processed data file format

The `processed_data` folder contains the following files:
   
---

**`mass_flow.csv`** contains mass flow rate calculated per bucket.

| Column                  | Unit         | Description                                        |
|-------------------------|--------------|----------------------------------------------------|
| `deposition_time_start` | HH:mm:ss.SSS | Starting time of collecting material in the bucket |
| `deposition_time_mid`   | HH:mm:ss.SSS | Mean time of collecting material in the bucket     |
| `deposition_time_end`   | HH:mm:ss.SSS | Ending time of collecting material in the bucket   |
| `mass_flow`             | kg/min       | Mass flow rate over the time window                |
