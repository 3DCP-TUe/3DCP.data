# 3DCP.data

<p align="left"> 
  <img src="https://img.shields.io/github/v/release/3DCP-TUe/3DCP.data?label=latest&include_prereleases">
</p>

## Introduction 

This repository contains the templates, libraries, and structure information for _3DCP.data - A database framework for 3D concrete printing_. The aim of this project is to collect experimental data 3D concrete printing processes in a structured way and distribute this data to the community. This repository includes the component libraries of the equipment and materials at TU/e and the templates for data records and software packages. The corresponding paper describing the database framework is published in _Results in Engineering_ and explains the concept behind the framework while providing example use cases. The paper can be found [here](https://doi.org/10.1016/j.rineng.2025.108669). 

An overview of all available data records that follow this framework can be found [here](docs/available_data_records.md).

## Documentation

In the following README, the structure and more detailed information of the various parts of this project are provided. 

- [Data record structure](docs/data_record_structure.md)
- [System data](docs/system_data/README.md)
    - [System metadata file](docs/system_data/metadata_file.md)
    - [Material components](docs/system_data/material_components.md)
    - [System components](docs/system_data/system_components.md)
- [In-line and on-line measurements](docs/inline_online_measurements/README.md)
    - [Mass flow bucket test](docs/inline_online_measurements/mass_flow_bucket_test.md)
    - [Slugs test](docs/inline_online_measurements/slugs_test.md)
    - [Tracer experiment](docs/inline_online_measurements/tracer_experiment.md)
- [In-situ and off-line measurements](docs/insitu_offline_measurements/README.md)
    - [Compression test](docs/insitu_offline_measurements/compression_test.md)
    - [Flat punch indentation test](docs/insitu_offline_measurements/flat_punch_indentation_test.md) (FPIT)
    - [Pocket shear vane test](docs/insitu_offline_measurements/pocket_shear_vane_test.md)
    - [Temperature single-point](docs/insitu_offline_measurements/temperature_point.md)
    - [Ultrasound wave transmission test](docs/insitu_offline_measurements/ultrasonic_wave_transmission_test.md) (UWTT)
    - [Unconfined uniaxial compresstion test](docs/insitu_offline_measurements/unconfined_uniaxial_compression_test.md) (UUCT)
- [Software structure](docs/software.md)

## Explanation of the files

[**docs**](docs): Contains a detailed description of the database structure and various data sources. Importantly, it contains the predefined structure of the _processed_data_ folder, which is critical to allow for automated data processing.

[**src**](src): 
- [**src/analysis**](src/analysis): Contains files to perform analysis over a session and data record.
- [**src/libraries**](src/libraries): Containing the material and system component libraries.
- [**src/template**](src/template): A folder structure that can be used as a template for constructing a data record.

[**utils**](utils): This folder contains helper files and resources used throughout the project, such as figures for README files and the scripts used to generate them.

## Framework development rules and workflow

This section describes the rules and workflow for developing the 3DCP.data framework.

- **main**: Protected branch reflecting the latest stable framework version.  
- **next-release**: Active development branch for _finalized_ updates, improvements, and new features.

We use the following workflow:

1. Implement and test changes in your own branch or fork.  
2. Once fully working, open a pull request to the `next-release` branch.  
3. Changes will be reviewed and merged if approved.  
4. The `next-release` branch is merged into `main` when a new release is made.

Both `main` and `next-release` are always fully functional, with `main` always reflecting the latest released version.

## Version numbering

This project uses the following versioning scheme: 

```
0.x.x ---> MAJOR version: Incompatible changes; for example, restructuring the database format and metadata files.
x.0.x ---> MINOR version: Functionality added in a backward-compatible manner; for example, new system components.
x.x.0 ---> PATCH version: Small backward-compatible changes; for example, small corrections in a component property.
```

## Contact information

If you have any questions or comments about this project, please open an issue on the repository’s issue page. This can include questions about the content, such as missing information, and the data structure. We encourage you to open an issue instead of sending us emails to help establish an open community. By keeping discussions open, everyone can contribute and see the feedback and questions of others. In addition to this, please see our open science statement below.

## How to cite

The database framework and its underlying concept are described in a journal paper. For generic references to the database framework, this paper can be cited. The BibTeX entry is provided below:

```bibtex
@article{3DCPdata_RINENG,
    title = {A database framework for {3D} concrete printing},
    author = {A. Deetman and D. Bos and S. Lucas and T. Salet and R. Wolfs},
    journal = {Results in Engineering},
    year = {2025},
    doi = {10.1016/j.rineng.2025.108669}
}
```

This repository contains the detailed information of the database framework, and it is the implementation that is and will continue to be updated over time. For specific aspects or implementations that are not part of a scientific publication, this repository can be referenced directly. This repository is mirrored on Zenodo. For citations of specific versions of the framework and their DOIs, please visit the Zenodo page. To cite the overall repository, the Zenodo project can be referenced using the following BibTeX:

```bibtex
@misc{3DCPdata_Zenodo,
    title = {3DCP.data - A database framework for {3D} concrete printing},
    author = {A. Deetman and D. Bos and S. Lucas and T. Salet and R. Wolfs},
    publisher = {Zenodo},
    year = {2025},
    doi = {10.xxxx/xxxxx} % To do after first release. 
    note = {Zenodo. doi:10.xxxx/xxxxx} % To do after first release. 
}
```

All data records that follow this framework are also published on Zenodo. They can be cited using the DOI listed on their respective Zenodo pages. An overview is provided [here](docs/available_data_records.md). 

## Funding

This project could be developed and maintained with the financial support of the following projects:

- The project _"Additive manufacturing of functional construction materials on-demand"_ (with project number 17895) of the research program _"Materialen NL: Challenges 2018"_ which is financed by the [Dutch Research Council](https://www.nwo.nl/en) (NWO).
- The project _"Just Press Print - A multi-scale framework towards first time right 3D Concrete Printing"_ (with project number 20202) of the Veni talent program, which is financed by the [Dutch Research Council](https://www.nwo.nl/en) (NWO).

## Open science statement

We are committed to the principles of open science to ensure that our work can be reproduced and built upon by others, by sharing detailed methodologies, data, and results generated with the unique equipment that is available in our lab. To spread Open Science, we encourage others to do the same to create an (even more) open and collaborative scientific community. 
Since it took a lot of time and effort to make our data and software available, we license our software under the General Public License version 3 or later (free to use, with attribution, share with source code) and our data and documentation under CC BY-SA (free to use, with attribution, share-alike), which requires you to apply the same licenses if you use our resources and share its derivatives with others.

## License

### Documentation

The documentation of 3DCP.data is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

Copyright (c) 2024-2025 [3D Concrete Printing Research Group at Eindhoven University of Technology](https://www.tue.nl/en/research/research-groups/structural-engineering-and-design/3d-concrete-printing)

You are free to:
- Share — copy and redistribute the material in any medium or format
- Adapt — remix, transform, and build upon the material for any purpose, even commercially.

Under the following terms:
- Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.

To view a copy of this license, visit <http://creativecommons.org/licenses/by-sa/4.0/>.

### Source code

The software components are licensed under the GNU General Public License version 3.0.

Copyright (c) 2024-2025 [3D Concrete Printing Research Group at Eindhoven University of Technology](https://www.tue.nl/en/research/research-groups/structural-engineering-and-design/3d-concrete-printing)

3DCP.data contains free software; you can redistribute it and/or modify it under the terms of the GNU General Public License version 3.0 as published by the Free Software Foundation. 

The software components are distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with 3DCP.data; If not, see <http://www.gnu.org/licenses/>.

@license GPL-3.0 <https://www.gnu.org/licenses/gpl-3.0.html>

### Readyaml

The [readyaml](src/analysis/lib/+framework_toolkit/readyaml.m) file to import YAML metadata into MATLAB is obtained via [Maarten Jongeneel](https://github.com/MaartenJongeneel/readyaml). 

BSD 3-Clause License

Copyright (c) 2023 Maarten Jongeneel

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
