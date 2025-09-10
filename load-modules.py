#!/usr/bin/env python3

import yaml
import os
import sys
from pathlib import Path

def find_file_with_extension(dir_path, basename):
    """Find a file with smart extension handling."""
    # If basename already has an extension, use it directly
    if '.' in basename:
        file_path = dir_path / basename
        return file_path if file_path.is_file() else None
    
    # Find all files that match the basename (without extension)
    matching_files = list(dir_path.glob(f"{basename}.*"))
    
    if len(matching_files) == 0:
        return None
    elif len(matching_files) == 1:
        return matching_files[0]
    else:
        # Multiple files with same basename but different extensions
        print(f"Error: Multiple files found for '{basename}' in {dir_path}:", file=sys.stderr)
        for f in matching_files:
            print(f"  {f.name}", file=sys.stderr)
        print("Please specify the full filename with extension.", file=sys.stderr)
        sys.exit(1)

def load_modules():
    zdotdir = Path(os.environ.get("ZDOTDIR", Path.home() / ".config" / "zsh"))
    config_file = zdotdir / "modules.yaml"
    zsh_dir = zdotdir
    
    if not config_file.exists():
        return
    
    try:
        with open(config_file, "r") as f:
            config = yaml.safe_load(f)
    except Exception as e:
        print(f"Error reading YAML: {e}", file=sys.stderr)
        return
    
    sourced_files = []
    
    for section_key, files in config.items():
        # Convert dot notation to directory path
        dir_path = zsh_dir / section_key.replace(".", "/")
        
        if not dir_path.exists():
            continue
            
        # Handle list of files
        if isinstance(files, list):
            file_list = files
        else:
            file_list = [files]
            
        for filename in file_list:
            if filename == "*":
                # Source all .zsh files in directory and subdirectories recursively
                for zsh_file in dir_path.rglob("*.zsh"):
                    if zsh_file.is_file():
                        sourced_files.append(str(zsh_file))
            else:
                # Find file with smart extension handling
                file_path = find_file_with_extension(dir_path, filename)
                if file_path:
                    sourced_files.append(str(file_path))
    
    # Output the files to source (zsh will read this)
    for file_path in sourced_files:
        print(f"source '{file_path}'")

if __name__ == "__main__":
    load_modules()
