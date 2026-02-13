# System Components

The system components are stored in a [library](/src/libraries/system_components). A set of system components forms a printing system through which the materials are dosed, mixed, transported, and deposited. The how the system components are connected and where the material is fed into the system is defined in the system data [metdata file](/docs/system_data/metadata_file.md). 

Each system component has its own folder, named using the component’s unique identifier (see naming convention below).  
This folder contains:

- the component’s YAML metadata file  
- at least one photo of the system component  
- optionally a 3D model (e.g. `.stl`)  
- a `docs` subfolder containing supporting documentation 

The `docs` folder may include supplier documentation, electrical schematics, and a `calibration` folder. The calibration folder stores calibration reports. Further details about the metadata structure and the calibration data format are provided below.

## Metadata File

Each system component is described using a dedicated metadata file. This file is written in a structured YAML format that is both human- and machine-readable, making it easy to maintain and integrate. The metadata file captures all relevant details about the component and is organized into the following sections:

- **attributes**: A short description of what the component is and its main function.
- **dimensions**: Physical properties such as volume, which are important for linking processing data to material evolution.
- **couplings**: Lists the inlets and outlets of the component. This helps check compatibility with other components in the system.
- **input/output (I/O)**: Describes the analog or digital interfaces of the component, including signal properties. This ensures accurate calculation of process values from recorded signals.
- **sensors**: Details any measurement devices integrated into or attached to the component. Includes name, type, manufacturer, model, and product number.
- **processed system data**: Lists the process parameters that are logged, including their name, function, unit, and the corresponding header in the log file. This allows for automated data processing.
- **parts**: If the component consists of multiple elements (excluding sensors), they are listed here. 
- **compatible with**: Only for inserts, specifies in which component this insert can be placed.

Other sections focusing on component information can be added to the metadata file as needed. Importantly, not all system components will have the same sections; some may lack sensors, while others might not require processed system data. However, the __io__ and __processed system data__ sections are particularly important for automated data analysis, as they enable matching signal values from the system data log file with component information, such as signal conversion. 

To add a new component, browse the [system components library](/src/libraries/system_components) for similar components. Use them as a reference to fill in the metadata file and structure any related files.

> **Note:**  
> When adding a component from the library to your data records, always verify that its settings match those described in your metadata file. This is especially important for:
> - **Coriolis sensors**: Settings and signal conversions can be changed.
> - **Dosing systems**: Calibration curves (e.g., motor frequency vs. flow rate) depend on the material being fed.
> - **Free programmable parameters**: Some devices (e.g., gantry robot, printhead plc, material delivery plc) have free programmable parameters (readable and writable via OPC UA). Their use depends on the application. Always check and update the function description of these parameters in the `processed_system_data` section of the system component.   

## Calibation data

Calibration data is typically used for calibrating dosing systems that feed material to the printing system. Each calibration is stored in its own directory in the docs folder of a system component and contains:

- a YAML file with the calibration metadata and description
- the calibration data stored next to it (CSV files)
- an optional analysis folder with files used to analyse the calibration data

Calibration directories follow the naming convention `cal-YYYYMMDD-id`, where `id` is a sequential number starting from 1. 

The calibration metadata file is a YAML file with the following sections:

- **attributes:** Unique calibration ID and date of calibration.
- **operators:** Person(s) who performed the calibration.
- **system_component:** ID of the system component that was calibrated.
- **material_component:** ID of the material component used for calibration.
- **system_layout:** Layout of the system used during calibration.
- **procedure:** Textual description of how the calibration was performed.
- **outputs:** Description of the raw calibration data files stored alongside the metadata file.
- **models:** Resulting fitted models (e.g. linear relations between valve position and flowrate).

Existing calibration files that be used as template can be found [here](/src/libraries/system_components/material delivery systems/dosing systems/liquid dosing vertico-1/docs/calibration/cal-20250206-1), [here](/src/libraries/system_components/material delivery systems/dosing systems/liquid dosing watson marlow-1/docs/calibration/cal-20250206-1), [here](/src/libraries/system_components/material delivery systems/dosing systems/solid dosing van-beek-1/calibration/cal-20241009-1), 
[here](/src/libraries/system_components/material delivery systems/mixer pumps/m-tec duomix-1/docs/calibration/cal-20240913-1), and [here](src/libraries/system_components/material delivery systems/mixer pumps/m-tec duomix-1/docs/calibration/cal-20250212-1).

## Library

The [system components library](/src/libraries/system_components) is organized into categories such as conduits, material delivery systems, motion systems, printheads, and sensors. Some of these categories contain subcategories—for example, the material delivery systems and printheads classes include inserts, which contain components like mixing blades and dosing screws that can be placed inside other system components. The complete categorization can be found below. 

```
class: conduit
class: material delivery systems
    main object: material delivery plc
    subclass: dosing systems
    subclass: inserts
    subclass: mixer pumps
    subclass: mixers
    subclass: pumps
    subclass: silos/storage
class: motion systems
class: printheads
    main object: printhead plc
    subclass: inserts
    subclass: nozzles
    subclass: static
    subclass: dynamic
class: sensors
```

### Naming convention

Most system components follow a structured naming format based on the inlet and outlets of the component to make identification and compatibility easier. Here are some examples of the names of the inlets and outlets:

```
mc25f   Mortar coupling, 25 mm, female          (options: 25, 35, 50, female, male)
mc35m   Mortar coupling, 35 mm, male            (options: 25, 35, 50, female, male)
fl40    Flange DN40                             (options: 5, 10, 15, 20, 25, 32, 40, etc.)
tc93    Tri-clamp flange diameter 93 mm         (options: 25, 51, 64, 78, 91, 119, etc.)
pi6     Push-in fitting 6 mm outer diameter     (options: 4, 6, 8, 10, 12, etc.)
so42    Slip-on 42 mm outer diameter
geka    GEKA coupling
pfd     Pressure flange for D-pump              (options: A, B, C, D, R, T, L-pump)
sfr     Suction flange for R-pump               (options: A, B, C, D, R, T, L-pump)
```

The general format for a component's name is: 

```
TYPE COUPLING_IN-COUPLING_OUT-DIAMETER-OPTIONAL_DIAMETER_2-CUSTOM_PROPERTY-ID_NUMBER`. 
```
 
Examples:

```
hose mc35f-mc35m-d35-l5000-1
reducer tc93-tc64-d73-d50-1
elbow mc35f-mc35m-d35-a90-1
adapter fl40-mc35m-d35-1
coriolis sensor fl40-fl40-d35-1
pressure sensor mc35f-mc35m-d35-25bar-1
pressure sensor mc35f-mc35m-d35-25bar-2
pressure sensor mc35f-mc35m-d35-10bar-1
```
