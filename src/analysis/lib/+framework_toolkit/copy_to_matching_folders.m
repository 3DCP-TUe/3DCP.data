function copy_to_matching_folders(source_dir, destination_dir, wipe)
%COPY_TO_MATCHING_FOLDERS Copy files to all destination folders with matching name
%
% This function searches recursively under DESTINATION_DIR for folders whose
% name matches the final folder name in SOURCE_DIR. For each matched folder,
% it optionally wipes its existing contents and then copies all files from
% the SOURCE_DIR (non-recursive) into that folder. The search does not
% descend further into a folder once a match is found.
%
% Syntax: copy_to_matching_folders(source_dir, destination_dir, wipe)
%
% Inputs:
%   source_dir      - Path to the source folder whose files will be copied
%   destination_dir - Root of the destination tree to search for matching folders
%   wipe            - (optional) logical flag; if true, remove all existing
%                     contents of each matched folder before copying (default: false)
%
% Outputs:
%   (none)
%
% Notes:
%   - A "matching folder" is any folder under DESTINATION_DIR whose name is
%     equal to the last path component (folder name) of SOURCE_DIR.
%   - Only files in the top-level SOURCE_DIR are copied (non-recursive).
%   - If WIPE is true, all files and subfolders inside each matched folder
%     are deleted before copying; the folder itself is kept.
%   - Copying uses COPYFILE with the 'f' flag to force overwrite of existing files.
%   - The recursive search stops descending below a folder once it matches
%     the target name.
%   - If a matched folder is the same as SOURCE_DIR, it is skipped to avoid
%     copying into itself.
%
% Example:
%   % Given:
%   %   source_dir = 'D:\folder\lib';
%   %   destination_dir = 'D:\record';
%   % This finds all folders named 'lib' under D:\record, optionally wipes them,
%   % then copies all files from D:\folder\lib into each:
%   copy_to_matching_folders('D:\folder\lib', 'D:\record', true)
%
%------------- BEGIN CODE --------------

    if nargin < 3 || isempty(wipe)
        wipe = false;
    end

    % Normalize inputs to char for compatibility
    if isstring(source_dir)
        source_dir = char(source_dir);      
    end
    if isstring(destination_dir)
        destination_dir = char(destination_dir); 
    end

    % Validate folders
    if ~isfolder(source_dir)
        error('Source folder does not exist: %s', source_dir);
    end
    if ~isfolder(destination_dir)
        error('Destination root folder does not exist: %s', destination_dir);
    end

    % Determine the target folder name from the source path
    [~, target_name, ~] = fileparts(source_dir);
    if isempty(target_name)
        error('Could not determine the source folder name from: %s', source_dir);
    end

    % Gather all matching folders under destination_dir
    matches = collect_matches(destination_dir, target_name);

    if isempty(matches)
        fprintf('No folders named "%s" found under: %s\n', target_name, destination_dir);
        return;
    end

    % Get list of files in source (non-recursive)
    entry_list = dir(fullfile(source_dir, '*'));
    src_files = entry_list(~[entry_list.isdir]);

    if isempty(src_files)
        fprintf('No files found in source: %s\n', source_dir);
    end

    % Process each match
    for m = 1:numel(matches)
        tgt = matches{m};

        % Skip copying into the source folder itself (defensive)
        if strcmpi(normalize_path(tgt), normalize_path(source_dir))
            fprintf('Skipping source folder itself: %s\n', tgt);
            continue;
        end

        if wipe
            wipe_folder_contents(tgt);
        end

        % Copy each file, forcing overwrite
        nCopied = 0;
        for k = 1:numel(src_files)
            src_path = fullfile(source_dir, src_files(k).name);
            dst_path = fullfile(tgt,        src_files(k).name);
            [ok, msg] = copyfile(src_path, dst_path, 'f');
            if ~ok
                warning('Failed to copy "%s" to "%s": %s', src_path, dst_path, msg);
            else
                nCopied = nCopied + 1;
            end
        end

        fprintf('Copied %d file(s) to: %s\n', nCopied, tgt);
    end

    %--------- Nested functions ---------

    function matches = collect_matches(root, wanted)
        % Recursively collect folders named WANTED under ROOT.
        % Do NOT recurse inside a matched folder (stop at that level).
        matches = {};
        items = dir(root);
        for ii = 1:numel(items)
            name = items(ii).name;
            if strcmp(name, '.') || strcmp(name, '..')
                continue;
            end
            if items(ii).isdir
                p = fullfile(root, name);
                if strcmpi(name, wanted)
                    matches{end+1} = p; %#ok<AGROW>
                    % Stop descent here (do not recurse into this matched folder)
                else
                    sub = collect_matches(p, wanted);
                    if ~isempty(sub)
                        matches = [matches, sub]; %#ok<AGROW>
                    end
                end
            end
        end
    end

    function wipe_folder_contents(folderPath)
        % Delete all contents of folderPath but keep the folder itself.
        items = dir(folderPath);
        for jj = 1:numel(items)
            nm = items(jj).name;
            if strcmp(nm, '.') || strcmp(nm, '..')
                continue;
            end
            p = fullfile(folderPath, nm);
            if items(jj).isdir
                status = rmdir(p, 's'); %#ok<NASGU>
                if ~exist(p, 'dir')
                    % removed
                else
                    warning('Failed to remove subfolder: %s', p);
                end
            else
                delete(p);
                if exist(p, 'file')
                    warning('Failed to delete file: %s', p);
                end
            end
        end
    end

    function p = normalize_path(p)
        % Normalize path for comparison (resolve separators/case on Windows)
        p = char(java.io.File(p).getCanonicalPath()); %#ok<JAVA>
    end
end
