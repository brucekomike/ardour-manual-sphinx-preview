#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e
# Treat unset variables as an error when substituting.
set -u

# --- Configuration ---
# Directory relative to script start where 'docs' lives and archives are stored
script_base_dir=$(pwd) # Or explicitly set if needed
docs_source_dir="docs"
build_output_parent="build" # Parent dir created by make (e.g., _build or build)
build_output_leaf="html"    # The actual output dir name (e.g., html)
archive_dir_rel="archives" # Relative path for archives

# --- Arguments ---
# Check if required arguments are provided
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <target-static-dir-name> [remote-host-user@server]"
  echo "Example: $0 mydocs user@example.com"
  exit 1
fi

static_dir_name="$1" # Use a more descriptive name
remote_host="${2:-}" # Assign $2 or empty string if not provided

# --- Absolute Paths ---
# Use absolute paths to avoid cd issues
docs_dir_abs="$script_base_dir/$docs_source_dir"
archive_dir_abs="$script_base_dir/$archive_dir_rel"
# Assuming make html creates $docs_dir_abs/$build_output_parent/$build_output_leaf
build_output_dir_abs="$docs_dir_abs/$build_output_parent/$build_output_leaf"
# The final location after renaming, still within the build parent
static_dir_final_abs="$docs_dir_abs/$build_output_parent/$static_dir_name"

# --- Pre-checks ---
# Check if sphinx-build is installed
if ! command -v sphinx-build &> /dev/null; then
  echo "Error: sphinx-build could not be found."
  echo "Hint: Have you activated the correct virtual environment?"
  exit 1
fi

# Check if source docs directory exists
if [[ ! -d "$docs_dir_abs" ]]; then
  echo "Error: Docs source directory not found: $docs_dir_abs"
  exit 1
fi

# Create local archive directory if it doesn't exist
mkdir -p "$archive_dir_abs"
echo "Using archive directory: $archive_dir_abs"

# --- Build ---
echo "Building documentation..."
# Run make from within the docs directory
(cd "$docs_dir_abs" && make html) # Use subshell to avoid permanent cd

# Check if build output directory exists
if [[ ! -d "$build_output_dir_abs" ]]; then
  echo "Error: Expected build output directory not found after 'make html': $build_output_dir_abs"
  exit 1
fi

# --- Rename and Archive ---
echo "Renaming build output to '$static_dir_name'..."
# Remove target dir if it exists before moving
if [[ "$static_dir_name" == "html" ]]; then
  echo "Warning: Target static dir name is 'html', which is the same as the build output leaf. This will overwrite the build output. Proceeding with caution."
else
  rm -rf "$static_dir_final_abs"
  mv "$build_output_dir_abs" "$static_dir_final_abs"
fi


timestamp=$(date +%Y%m%d)
archive_filename="html_docs_${static_dir_name}_${timestamp}.tar.gz"
archive_path_abs="$archive_dir_abs/$archive_filename"

echo "Creating archive: $archive_path_abs"
# Use -C to change directory *only* for tar, archiving the renamed static dir
tar -czf "$archive_path_abs" -C "$docs_dir_abs/$build_output_parent" "$static_dir_name"

echo "Local archive created successfully."

# --- Remote Deployment ---
# Check if remote host was provided
if [[ -z "$remote_host" ]]; then
  echo "No remote host provided (argument 2 is empty)."
  echo "Skipping remote upload and extraction."
  exit 0
fi

echo "Deploying to remote host: $remote_host"
remote_base_dir="/opt/www/docs/" # Base directory on remote server
remote_archive_path="$remote_base_dir/$archive_filename"

# Create target directory structure on the remote host
echo "Creating remote directory (if needed): $remote_base_dir"
ssh "$remote_host" -t "sudo mkdir -p '$remote_base_dir'" # Quote the path
ssh "$remote_host" -t "sudo chown -R $USER:$USER '$remote_base_dir'"

# Upload the archive to the remote host using rsync
echo "Uploading archive..."
rsync -avz --progress "$archive_path_abs" "${remote_host}:${remote_base_dir}/"

# Extract the archive on the remote host
echo "Extracting archive on remote host..."
# Use the filename on the remote side, extract into the target base dir
ssh "$remote_host" "tar -xzf '$remote_archive_path' -C '$remote_base_dir'" # Quote paths

echo "Removing remote archive file..."
ssh "$remote_host" "rm '$remote_archive_path'" # Quote path

echo "Deployment to $remote_host finished successfully."

exit 0