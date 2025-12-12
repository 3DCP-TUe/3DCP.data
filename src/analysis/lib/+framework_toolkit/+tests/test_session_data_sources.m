% SPDX-License-Identifier: GPL-3.0-or-later
% 3DCP.data
% Project: https://github.com/3DCP-TUe/3DCP.data
%
% Copyright (c) 2025 Eindhoven University of Technology
%
% Authors:
%   - Arjen Deetman (2025)
%
% For license details, see the LICENSE file in the project root.

function test_session_data_sources(session_folder, metadata_file)
% TEST_SESSION_DATA_SOURCES  Validate all data sources in a session folder
%
% INPUTS:
%   session_folder : path to the session folder to validate
%   metadata_file  : path to 'metadata_data_sources.yml'
%
% The function loads YAML metadata and validates:
%   - existence of folders and subfolders
%   - presence of required files
%   - CSV columns
%   - referenced files (is_file)
%
% Uses framework_toolkit.readyaml to load the metadata YAML.

    fprintf('--- Validating session folder: %s ---\n', session_folder);

    % -----------------------------
    % Load YAML metadata
    try
        data = framework_toolkit.readyaml(metadata_file);
    catch
        error('Failed to read metadata YAML: %s', metadata_file);
    end

    data_sources = data.data_sources;

    % -----------------------------
    % Get existing folders in session
    d = dir(session_folder);
    d = d([d.isdir]);
    existing_folders = setdiff({d.name}, {'.', '..'});

    % -----------------------------
    % Validate existing folders against metadata
    metadata_folders = cellfun(@(ds) ds.folder, data_sources, 'UniformOutput', false);
    all_ok = true; % flag to track critical failures

    for i = 1:numel(existing_folders)
        if ~ismember(existing_folders{i}, metadata_folders)
            fprintf('[FAILED] Unexpected folder found in session: %s\n', existing_folders{i});
            all_ok = false;
        else
            fprintf('[ OK ] Folder exists as defined in metadata: %s\n', existing_folders{i});
        end
    end

    if all_ok
        fprintf('✔ All data source folder names are validated successfully.\n\n');
    else
        fprintf('⚠ Some data source folders have incorrect names. See [FAILED] messages above.\n\n');
    end

    % -----------------------------
    % Check each data source folder defined in metadata

    for i = 1:numel(data_sources)
        ds = data_sources{i};
        folder_path = fullfile(session_folder, ds.folder);
        all_ok_data_source = true;

        % -----------------------------
        % Determine if data source folder is optional
        if isfield(ds, 'optional')
            optVal = ds.optional;
            if iscell(optVal)
                optVal = optVal{1};
            end
            isOptional = logical(optVal);
        else
            isOptional = false;
        end

        % -----------------------------
        % Check folder existence
        if ~isfolder(folder_path)
            if isOptional
                % Optional folder missing is not an error
            else
                fprintf('[FAILED] Missing required data source folder: %s\n', ds.folder);
                all_ok = false;
                all_ok_data_source = false;
            end
            continue;
        end

        fprintf('[ OK ] Found data source folder: %s\n', ds.folder);

        % -----------------------------
        % Check subfolders and files recursively
        if isfield(ds, 'subfolders')
            ok = check_subfolders(folder_path, ds.subfolders);
            all_ok = all_ok && ok;
            all_ok_data_source = all_ok_data_source && ok;
        end

        % -----------------------------
        % Per-data-source completion message
        if all_ok_data_source
            fprintf('✔ Data source folder "%s" validated successfully.\n\n', ds.folder);
        else
            fprintf('⚠ Data source folder "%s" is incorrect. See [FAILED] messages above.\n\n', ds.folder);
        end
    end

    % -----------------------------
    % Conclude main check
    if all_ok
        fprintf('✔ All session folders validated successfully.\n\n');
    else
        fprintf('⚠ Some required folders or files were missing. See [FAILED] messages above.\n\n');
    end

    fprintf('--- Finished validating session folder ---\n');

end

% -------------------------------------------------------------------------
function all_ok = check_subfolders(parent_path, subfolders)
% CHECK_SUBFOLDERS  Recursively validate subfolders and files
%
% INPUTS:
%   parent_path : full path to parent folder
%   subfolders  : structure array of expected subfolders and files
%
% OUTPUT:
%   all_ok      : true if all checks pass, false otherwise

    all_ok = true;

    for j = 1:numel(subfolders)
        sub = subfolders{j};
        sub_path = fullfile(parent_path, sub.name);

        % -----------------------------
        % Determine if subfolder is optional
        if isfield(sub, 'optional')
            optVal = sub.optional;
            if iscell(optVal), optVal = optVal{1}; end
            isOptional = logical(optVal);
        else
            isOptional = false;
        end

        % -----------------------------
        % Check subfolder existence
        if ~isfolder(sub_path)
            if ~isOptional
                fprintf('[FAILED] Missing required subfolder: %s\n', sub_path);
                all_ok = false;
            end
        else
            fprintf('[ OK ] Found subfolder: %s\n', sub_path);
        end

        % -----------------------------
        % Check files in this subfolder
        if isfield(sub, 'files')
            for k = 1:numel(sub.files)
                file_info = sub.files{k};
                file_path = fullfile(sub_path, file_info.name);

                % Optional file handling
                if isfield(file_info, 'optional')
                    optVal = file_info.optional;
                    if iscell(optVal), optVal = optVal{1}; end
                    isOptionalFile = logical(optVal);
                else
                    isOptionalFile = false;
                end

                % Check file existence
                if exist(file_path, 'file') ~= 2
                    if isOptionalFile
                        fprintf('[WARN] Optional file missing: %s\n', file_path);
                    else
                        fprintf('[FAILED] Missing required file: %s\n', file_path);
                        all_ok = false;
                    end
                    continue;
                else
                    fprintf('[ OK ] Found file: %s\n', file_path);
                end

                % Check CSV columns if applicable
                if isfield(file_info, 'columns')
                    ok = check_csv_columns(file_path, file_info.columns);
                    all_ok = all_ok && ok;
                end
            end
        end

        % -----------------------------
        % Recursively check nested subfolders
        if isfield(sub, 'subfolders')
            ok_sub = check_subfolders(sub_path, sub.subfolders);
            all_ok = all_ok && ok_sub;
        end
    end
end

% -------------------------------------------------------------------------
function all_ok = check_csv_columns(file_path, columns_struct)
% CHECK_CSV_COLUMNS  Validate CSV file columns against metadata definition
% Also handles 'is_file' references in columns
%
% INPUTS:
%   file_path       : full path to CSV file
%   columns_struct  : structure from YAML describing expected columns
%
% OUTPUT:
%   all_ok          : true if all required columns exist, false otherwise

    all_ok = true;  % assume success
    fprintf('  -> Checking CSV columns: %s\n', file_path);

    if ~exist(file_path, 'file')
        fprintf('     [SKIP] File does not exist, cannot check columns.\n');
        all_ok = false;
        return;
    end

    % Read CSV table
    try
        T = readtable(file_path);
    catch
        warning('     [WARN] Failed to read CSV file: %s', file_path);
        all_ok = false;
        return;
    end

    csv_cols = T.Properties.VariableNames;
    yaml_cols = fieldnames(columns_struct);

    % Check each expected column
    for i = 1:numel(yaml_cols)
        col_name = yaml_cols{i};
        col_info = columns_struct.(col_name);

        % Determine if column is optional (safe scalar conversion)
        if isfield(col_info, 'optional')
            optVal = col_info.optional;
            if iscell(optVal)
                optVal = optVal{1};
            end
            if ~isscalar(optVal)
                optVal = optVal(1);
            end
            isOptionalCol = logical(optVal);
        else
            isOptionalCol = false;
        end

        % Check column existence
        if ~ismember(col_name, csv_cols)
            if isOptionalCol
                fprintf('     [WARN] Optional column missing: %s\n', col_name);
            else
                fprintf('     [FAILED] Missing required column: %s\n', col_name);
                all_ok = false;
            end
        else
            fprintf('     [ OK ] Column exists: %s (%s, unit=%s)\n', ...
                col_name, col_info.description, col_info.unit);

            % -----------------------------
            % Check if this column is a file reference
            if isfield(col_info, 'is_file')
                is_file_info = col_info.is_file;

                % Set default column if not specified
                if ~isfield(is_file_info, 'column')
                    is_file_info.column = col_name;
                end

                % Set default base_folder if not specified
                if ~isfield(is_file_info, 'base_folder')
                    is_file_info.base_folder = '';
                end

                % Recursively check referenced files
                ok_ref = check_file_reference(file_path, is_file_info);
                all_ok = all_ok && ok_ref;
            end
        end
    end

    % Report extra columns
    extra_cols = setdiff(csv_cols, yaml_cols);
    if ~isempty(extra_cols)
        fprintf('     [WARN] Extra columns found in CSV: %s\n', strjoin(extra_cols, ', '));
    end
end

% -------------------------------------------------------------------------
function all_ok = check_file_reference(file_path, is_file_info)
% CHECK_FILE_REFERENCE  Validate referenced filenames in a CSV column
% Only checks existence and nested columns, ignores filename format
%
% INPUTS:
%   file_path    : full path to CSV file containing file references
%   is_file_info : structure from YAML:
%       - column       : name of the column containing file references
%       - base_folder  : folder relative to which existence is checked
%       - columns      : schema of referenced file
%
% OUTPUT:
%   all_ok       : true if all references exist and nested columns valid

    all_ok = true;  % assume success

    if ~exist(file_path, 'file')
        fprintf('     [SKIP] File does not exist, cannot check references: %s\n', file_path);
        all_ok = false;
        return;
    end

    % Read CSV table
    try
        T = readtable(file_path);
    catch
        warning('     [WARN] Failed to read CSV file: %s', file_path);
        all_ok = false;
        return;
    end

    % Ensure column specified
    if ~isfield(is_file_info, 'column')
        warning('     [WARN] No column specified in is_file info.');
        all_ok = false;
        return;
    end
    col_name = is_file_info.column;

    if ~ismember(col_name, T.Properties.VariableNames)
        warning('     [WARN] Column "%s" not found in %s', col_name, file_path);
        all_ok = false;
        return;
    end

    % Convert filenames to cellstr
    filenames = T.(col_name);
    if ~iscell(filenames)
        filenames = cellstr(string(filenames));
    end

    % Base folder for checking file existence
    if isfield(is_file_info, 'base_folder')
        base_folder = fullfile(fileparts(file_path), is_file_info.base_folder);
    else
        base_folder = fileparts(file_path);
    end

    % Loop over each referenced file
    for i = 1:numel(filenames)
        fname = filenames{i};

        % Skip empty filenames
        if isempty(fname)
            fprintf('     [FAILED] Empty filename found in column "%s"\n', col_name);
            all_ok = false;
            continue;
        end

        % Check file existence
        fpath = fullfile(base_folder, fname);
        if exist(fpath, 'file') ~= 2
            fprintf('     [FAILED] Referenced file does not exist: %s\n', fpath);
            all_ok = false;
            continue;
        else
            fprintf('     [ OK ] Referenced file exists: %s\n', fpath);
        end

        % Check columns of referenced file (nested check)
        if isfield(is_file_info, 'columns')
            ref_ok = check_csv_columns(fpath, is_file_info.columns);
            all_ok = all_ok && ref_ok;
        end
    end
end
