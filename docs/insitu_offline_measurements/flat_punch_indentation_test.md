# Flat Punch Indentation Test (FPIT)

Data source folder: `fpit`

## Description of the data source

The FPIT is a compression test where a cylindrical flat punch indenter is pressed into the surface of a significantly larger molded sample. As for the UUCT, this is a single-point destructive test used to assess the early-age mechanical properties of the material by testing several samples at different ages. From the measured indentation response, the stiffness modulus, cohesion, and friction angle can be derived. The experiment can be conducted in similar test rigs, identical to those used for the UUCT, as only the indentation load and depth need to be recorded. The theory and methodology to derive the mechanical properties from the indentation response are described in detail in Deetman & Suiker (publication in preperation). 

## Data collection

Data collection depends on the test rig that is used. 

## Data storage

### Processed data file format

The `processed_data` folder contains at least the following files:

---

**`overview.csv`**

| Column                  | Unit       | Description                                                     |
|-------------------------|------------|-----------------------------------------------------------------|
| `deposition_date`       | yyyy-MM-dd | Date when the material was deposited                            |
| `deposition_time_start` | HH:mm:ss   | Start time of deposition                                        |
| `deposition_time_end`   | HH:mm:ss   | End time of deposition                                          |
| `testing_date`          | yyyy-MM-dd | Date when the test was performed                                |
| `testing_time`          | HH:mm:ss   | Time when the test started                                      |
| `file_name`             | –          | Name of the file containing the sample response                 |
| `loading_rate`          | mm/s       | Rate at which the indenter is displaced into the sample         |
| `indenter_radius`       | mm         | Radius of the flat punch indenter                               |
| `sample_radius`         | mm         | Radius of the sample being tested                               |
| `stiffness_modulus`     | MPa        | Stiffness modulus derived from the indentation response         |
| `cohesion`              | MPa        | Cohesion derived from the indentation response                  |
| `friction_angle`        | degrees    | Friction angle derived from the indentation response            |


---

**`sample_i.csv`**

| Column | Unit         | Description                          |
|--------|--------------|--------------------------------------|
| `time` | HH:mm:ss.SSS | Clock time of the measurement        |
| `load` | N            | Indentation load applied             |
| `depth`| mm           | Indentation depth measured           |

