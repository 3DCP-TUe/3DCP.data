# Material Components

The material components are stored in a [library](/src/libraries/material_components). A combination of material components defines the material composition used during processing. Material components can represent individual raw materials such as water, binders, aggregates, admixtures, and additives, or pre-mixed formulations that consist of multiple material components. These pre-mixed formulations are reffered to as blends. 

The specific material components used in a session, where they are fed into the processing system, and how they interact with the system are defined in the [system data](/docs/system_data/metadata_file.md).

Each material component has its own folder, named using the component’s unique identifier (see naming convention below).

This folder contains:

- The material component YAML metadata file.
- Optionally a particle size distribution file (`psd.csv`).
- Optionally a `docs` folder containing supporting documentation.

The general folder structure is:

```text
+-- component-name
|   +-- docs
|   |   +-- datasheet.pdf
|   |   +-- certificate.pdf
|   |   +-- ...
|   +-- metadata.yml
|   +-- psd.csv
|   +-- ...
```

The metadata file contains the information required to identify the material, describe its properties, and reproduce experimental work. Since different categories of materials require different information, the exact structure of the metadata file depends on the material category.

## Metadata File

Each material component is described using a dedicated metadata file. The metadata format is designed to be both human-readable and machine-readable to support automated processing and data analysis.

The metadata file commonly contains the following sections:

- **attributes**: General identification information such as name, category, and description.
- **general properties**: Supplier information, physical state, and blend information.
- **physical properties**: Density, color, bulk density, particle size distribution, and other physical characteristics.
- **chemical properties**: Chemical composition, mineral composition, or other chemistry-related information when relevant.
- **mechanical properties**: Material parameters relevant for reinforcement materials such as fibers.
- **blend**: Definition of premixed materials as a combination of other material components.

Not all material components contain the same sections. For example, aggregates typically contain particle size distribution information, binders may contain chemical or mineral composition data, and fibers may contain geometry and mechanical properties. Additional sections may be added when required.

### Attributes

The attributes section provides the identification and classification of the material component.

Example:

```yaml
attr:
  class: binders
  subclass: cementitious binders
  name: cement-i-42.5-n-1
  friendly_name: Cement type I 42.5 N
  description: Portland cement type I 42.5 N
```

### General Properties

The `general_properties` section contains general information about the material.

Example:

```yaml
general_properties:
  supplier: ENCI      # Material supplier 
  state: dry          # Physical state (`dry` or `wet`)
  blend: false        # Indicates whether the material is composed of multiple material components
```

### Physical Properties

The `physical_properties` section contains physical material characteristics.

Example:

```yaml
physical_properties:
  color: grey
  density: 3030
  bulk_density: unknown
  psd:
    available: true      # Indicates whether the 'psd.csv' files is available
    d10: 7.0
    d50: 28.8
    d90: 81.6
```

Densities are provided in kg/m³ and particle sizes in micrometer. 

#### Particle size distribution

If particle size distribution (PSD) data is available, it is stored in a `psd.csv` file next to the metadata file.

The metadata file should indicate whether PSD data is available and provide the characteristic particle sizes:

```yaml
psd:
  available: true
  d10: 166.6
  d50: 287.1
  d90: 368.2
```

The PSD file contains the complete particle size distribution and allows for detailed particle size analysis, while the metadata file provides commonly used summary values.

An example `psd.csv` file is shown below:

```csv
size,fraction
1,0.001
2,0.004
5,0.018
...
```

### Blends

Blends are material components composed of multiple material components. Instead of repeatedly defining the composition in each data record, blend formulations can be stored in the material library and reused across multiple sessions.

Example:

```yaml
attr:
  class: blends
  name: custom-mortar-1
  friendly_name: Custom mortar

general_properties:
  supplier: Saint-Gobain Weber-Beamix
  state: dry
  blend: true

blend:
  - component:
      name: cement-i-42.5-n-1
      mass_fraction: 0.219
  - component:
      name: blast-furnace-slag-1
      mass_fraction: 0.438
  - component:
      name: silica-fume-1
      mass_fraction: 0.073
  - component:
      name: limestone-powder-1
      mass_fraction: 0.146
  - component:
      name: sand-53-500-1
      mass_fraction: 0.124
```

For blend definitions:

- Each referenced material component must exist in the material components library.
- The mass fractions should sum to 1.0.
- Blend components can themselves be blends, although direct definitions are preferred where possible.

## Library

The material components library is organized into categories:

```text
class: water
class: binders
    subclass: cementitious binders
    subclass: supplementary cementitious materials
class: aggregates
class: admixtures
  subclass: accelerators
  subclass: retarders
  subclass: superplasticizers
  sublcass: viscosity modifying agents
class: additives
  subclass: fibers
  subclass: pigments
class: blends
```

Additional categories and subclasses can be added when needed.

## Naming convention

Material component names should be unique and stable over time.

The general naming convention is:

```text
MATERIAL-NAME-ID
```

Examples:

```text
cement-i-42.5-n-1
blast-furnace-slag-1
silica-fume-1
limestone-powder-1
sand-53-500-1
custom-mortar-1
```

The final identifier should only be incremented when multiple distinct variants of the same material need to be stored.
