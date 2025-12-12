# System data

Data source folder: `system_data`

## Description of the data source

System data is a specialized type of data source that tends to be more complex to describe than a typical experiment. It provides a structured and comprehensive record of the materials used, the system components involved, and a description of the system layout. In addition to this descriptive information, system data also includes all measurements and control signals acquired from the processing system. This covers the operational state of motors, readings from in-line sensors, and other relevant signals captured during the session. By combining detailed metadata with real-time process data, system data enables a deeper understanding of how materials and components interact during operation. 

## Data collection

At TU/e the system data is collected via the software package [Node-RED 3DSeeP](https://github.com/3DCP-TUe/Node-RED-3DSeeP) which is developed within the open-source Node-RED programming environment and runs on a desktop computer. In Node-RED, OPC UA clients are configured to read and write data to the various OPC UA servers distributed across the system. Data is collected at a sampling frequency of 10 Hz and is displayed in real-time on a dashboard. The equipment and standard outputs of the distributed I/O can also be controlled via the Node-RED dashboard. Additionally, since all data from the various devices is available on this platform, Node-RED is functionally programmed to synchronize components, for example, aligning the behavior of a dosing system with that of a mixing pump that both have their own OPC UA interface. 

## Data storage

The __raw data__ contains a log file with time-series data collected using the Node-RED-based data logger. The __setupinfo__ folder includes subfolders for material components and system components, where all used materials and system components are described. Alongside these, a YAML metadata file defines how materials and components interact—specifically, which component each material was fed into and how the components were assembled. The __processed data__ consists of a cleaned time-series table derived from the raw log file. Cleaning typically involves removing columns related to unused system components and applying corrections if errors occurred during data logging (e.g., incorrect signal conversion settings in the data logger). The __scripts__ folder contains the files used to generate the processed data from the raw data.

### Setupinfo structure

The __setupinfo__ data is organized into a structured folder layout designed to support both documentation and automated processing. Inside the `setupinfo` folder, two subfolders exist: `material_components` and `system_components`. These hold the respective material and system components.  

For each component, a dedicated folder is created. This folder always contains a base YAML metadata file with the necessary component details. Additional resources may also be included. For system components, at least one photo is always added. Depending on the component’s characteristics and available resources, extra files may be added—such as a 3D model (`.stl`), or a `docs` folder with schematics, calibration reports, or manufacturer documentation. The general structure for both material and system components looks like this:

```
+-- component-name
|   +-- docs
|   |   +-- doc.pdf
|   |   +-- ...
|   +-- metadata.yml
|   +-- name.stl
|   +-- name.jpg
|   +-- ...
```

System components are described using metadata files that define attributes, dimensions, couplings, I/O interfaces, sensors, and logged data. These follow a standardized format, as outlined in the [system components documentation](system_components.md). Material components are also described by metadata files; however, their content and sections differ depending on the nature of the component, as explained in the [material components documentation](system_components.md).

The overall system setup—including material flow, component connections, and configuration—is defined in a dedicated system data metadata file. This file contains structured sections describing materials, motion systems, software, system layout, and I/O configuration. These sections allow the system setup to be fully reconstructed and the relationships between materials, components, and signals to be understood. More details can be found in the [system metadata file documentation](metadata_file.md).

### Processed data format

The `processed_data` folder contains a `.csv` log file with **time-series data** captured during processing. Each column (i.e., each header) corresponds to a specific system component. Reading this data typically does **not** start directly with the log file. Instead, the workflow begins by reading the **system layout** from the **system metadata file**, along with the **component metadata**.  

#### Example 1: Direct sensor reading

The system metadata file indicates the overall **system layout**, including how components are connected and where they are located. Within the `processed_system_data` section of an individual system component, the metadata specifies which data is saved, in which log file, and in wich column of the log file it can be found. As an example, a snippet of a component metadata file:  

```yaml
attr:
  class: sensor
  name: coriolis sensor fl40-fl40-d35-1
  description: Coriolis mass flow sensor with in-line viscosity measurement. 

processed_system_data:
  - name: mass flow rate
    function: mass flow rate measurement
    unit: kg/min
    damping: 0
    filename: system_data.csv
    header: material_coriolis_mass_flow_kg_min
```

This example indicates that the data logged is the mass flow rate in kg/min, and the time series data can be found in the data log file under the header `material_coriolis_mass_flow_kg_min`.

#### Example 2: I/O

The processing system uses modular inputs and outputs (i/o) where sensors and devices can be connected to control or read data from them. As these can be connected to different locations in the system, it needs to be documented where a modular input or output is connected to, what its signals represent, and from which system component the signal is sent or received. This is illustrated below for a pressure sensor.  

First, in the system metadata file, in the section `io_configuration`, the system components are listed that can receive and send data to and from other system components, and log this data to the main system logger. Below, an example is given (a snippet from the material delivery plc component). The system component `material delivery plc` receives a signal from the system component `pressure sensor mc35f-mc35m-d35-25bar-1`. In the example, it is an analog input (AI). The material delivery plc receives a signal from the pressure sensor on channel `AI0` from the channel `pressure sensor` of the pressure sensor.  

```yaml
# IO configuration
io_configuration:
  - component: material delivery plc
    channels:
      - name: AI0
        component: pressure sensor mc35f-mc35m-d35-25bar-1
        channel: pressure sensor
      - name: AI1
        component: ...
        channel: ...
```

Next, in the system component `material delivery plc`, the section `io` lists all input and output channels and the corresponding headers where the signals are stored in the data log file. See below, as an example, a snippet of the material delivery plc. Under the `io` section, the channel `AI0` is listed where the pressure sensor is connected. The type, function, and connector are provided. The signal from this channel is saved under the column `material_io_ai0_ma` of the system data log file.

```yaml
attr:
  class: material delivery systems
  name: material delivery plc
  description: PLC for data acquiston and control. 

io:
  - name: AI0
    type: analog input 4-20 mA active
    function: free-to-use
    connector: Weipu SP2112/S4
    filename: system_data.csv
    header: material_io_ai0_ma
```

In the metadata file of the pressure sensor (see snippet below), under `io`, the channel `pressure sensor` is listed that is connected to the channel `AI0` of the material delivery plc. From the pressure sensor metadata it can be read from the field `signal_limits` that the lower and upper limits of the signal are 4 and 20 mA, respectively, with corresponding process value readings of 0 and 25 bar. The field `interpolation` specifies that linear interpolation needs to be used to calculate the correct intermediate pressure readings from the stored signal. 

```yaml
attr:
  class: sensor
  name: pressure sensor mc25f-mc25m-d25-25bar-1
  description: Mortar pressure sensor. 

io:
  - name: pressure sensor
    connector: Weipu SP2112/P4
    type: analog output 4-20 mA active
    signal_limits: [4, 20]
    reading_limits: [0, 25]
    interpolation: linear
    unit: bar
```