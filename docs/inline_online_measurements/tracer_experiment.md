# Tracer experiments

Data source folder: `tracer_experiment`

## Description of the data source

Tracer experiments are used to analyze material flow within the system. In this experiment, a dye or pigment is injected at a specific location into the system, and digital image processing (DIP) is used to detect its presence at the nozzle outlet. By correlating the color intensity of the material from the images to the tracer concentration, the residence time functions can be determined. From impulse inputs, the residence time distribution is obtained, while step-up and step-down inputs provide the cumulative residence function and wash-out function, respectively. The experiment can be performed both in-line and on-line, though on-line measurements are more practical, as in-line implementation would require the camera to rotate with the nozzle to follow the printing trajectory. The experiment is described in detail in [Deetman et al. (2024)](https://doi.org/10.1617/s11527-024-02378-y)

## Data collection

For this experiment, the software package [Concrete Candy Tracker](https://github.com/3DCP-TUe/ConcreteCandyTracker) was developed. Concrete Candy Tracker is developed in Python and built around pypylon, the official Python wrapper for Basler cameras. It calculates mean color values (RGB, CIELAB, and CIEXYZ) in real-time within a specified region of interest at a frequency of 10 to 60 Hz, depending on camera settings. The software includes functionality for writing measured color values to an external or local OPC UA server, enabling real-time visualization and interaction on a Node-RED dashboard with the system data. 

## Data storage

The __raw data__ contains a log file providing time-series data of the measured color values. Additionally, short measurements on grey and white cards used for color calibration can be stored. The __setupinfo__ folder contains a YAML metadata file describing the hardware and software settings. The hardware described includes the camera, lens, filters, and lighting, while the software settings include, among others, the white balance ratios, gain level, and exposure time. The __processed data__ consists of a time series table with the color values but with outliers removed. Additionally, for each experiment, a separate file is stored that contains, depending on how the tracer material was applied, the residence time distribution, step-up response, or step-down response in a time series format. An overview file is provided, listing the experiments with details such as start time, end time, input type used, and a reference to the individual experiment file. The __scripts__ folder contains the files used to produce the files in the processed data folder from the raw data. 

### Processed data file format

The `processed_data` folder contains the following files:

---

**`color_values.csv`** contains color measurement data over time.

| Column | Unit      | Description                               |
|--------|-----------|-------------------------------------------|
| `time` | HH:mm:ss  | Clock time of measurement                 |
| `R`    | –         | Red value (RGB color space)               |
| `G`    | –         | Green value (RGB color space)             |
| `B`    | –         | Blue value (RGB color space)              |
| `X`    | –         | X value (CIE 1931 XYZ color space)        |
| `Y`    | –         | Y value (CIE 1931 XYZ color space)        |
| `Z`    | –         | Z value (CIE 1931 XYZ color space)        |
| `L`    | –         | L* value (CIELAB color space)             |
| `a`    | –         | a* value (CIELAB color space)             |
| `b`    | –         | b* value (CIELAB color space)             |

---

**`overview.csv`** contains metadata and statistical summaries for each tracer experiment.

| Column                   | Unit        | Description                                              |
|--------------------------|-------------|----------------------------------------------------------|
| `experiment`             | –           | Identifier for the experiment number                     |
| `serie`                  | –           | Series number the experiment belongs to                  |
| `input`                  | –           | Input type (`impulse`, `step_up`, `step_down`)           |
| `material_component`     | –           | Material component used as tracer                        |
| `system_component`       | –           | System component where tracer was added                  |
| `system_component_inlet` | –           | Inlet of the system component                            |
| `size`                   | g or g/min  | Impulse size (g) or step size (g/min)                    |
| `time_start`             | HH:mm:ss    | Start time of experiment                                 |
| `time_end`               | HH:mm:ss    | End time of experiment                                   |
| `file_name`              | –           | Filename containing the response data                    |
| `mean`                   | HH:mm:ss    | Mean residence time                                      |
| `variance`               | HH:mm:ss    | Variance of the residence time                           |
| `std`                    | HH:mm:ss    | Standard deviation of the residence time                 |
| `p1`                     | HH:mm:ss    | 1st percentile of the residence time                     |
| `p5`                     | HH:mm:ss    | 5th percentile                                           |
| `p50`                    | HH:mm:ss    | Median (50th percentile)                                 |
| `p95`                    | HH:mm:ss    | 95th percentile                                          |
| `p99`                    | HH:mm:ss    | 99th percentile                                          |

---

**File containing the response data**

Each experiment has a corresponding CSV file containing the response values over time.

| Column         | Unit     | Description                               |
|----------------|----------|-------------------------------------------|
| `time`         | HH:mm:ss | Clock time of measurement                 |
| `time_response`| HH:mm:ss | Time since start of experiment            |
| `value`        | –        | Normalized response value                 |
| `R`            | –        | Red value (RGB color space)               |
| `G`            | –        | Green value (RGB color space)             |
| `B`            | –        | Blue value (RGB color space)              |
| `X`            | –        | X value (CIE 1931 XYZ color space)        |
| `Y`            | –        | Y value (CIE 1931 XYZ color space)        |
| `Z`            | –        | Z value (CIE 1931 XYZ color space)        |
| `L`            | –        | L* value (CIELAB color space)             |
| `a`            | –        | a* value (CIELAB color space)             |
| `b`            | –        | b* value (CIELAB color space)             |


