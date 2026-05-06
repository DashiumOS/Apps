#!/bin/bash

# Script to generate apps.json from all app directories
# Usage: ./generate-apps.sh

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Generating apps.json from app directories...${NC}"

# Get script directory - handle when called from anywhere
if [[ -n "${BASH_SOURCE[0]}" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    SCRIPT_DIR="$(pwd)"
fi
REPO_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"
APPS_DIR="$REPO_ROOT/apps"
APPS_FILE="$REPO_ROOT/apps.json"

# Start JSON array
echo "[" > "$APPS_FILE"

# Find all app directories
find "$APPS_DIR" -maxdepth 1 -type d | while read -r app_dir; do
    app_name=$(basename "$app_dir")
    
    # Skip if no config.yml exists
    if [[ ! -f "$app_dir/config.yml" ]]; then
        echo -e "${YELLOW}Warning: No config.yml found in $app_name, skipping...${NC}"
        continue
    fi
    
    echo -e "${GREEN}Processing $app_name...${NC}"
    
    # Parse config.yml
    if command -v yq >/dev/null 2>&1; then
        # Use yq if available
        name=$(yq eval '.name' "$app_dir/config.yml" 2>/dev/null || echo "null")
        description=$(yq eval '.description' "$app_dir/config.yml" 2>/dev/null || echo "null")
        version=$(yq eval '.version' "$app_dir/config.yml" 2>/dev/null || echo "null")
        image=$(yq eval '.image' "$app_dir/config.yml" 2>/dev/null || echo "null")
    else
        # Fallback to basic grep/sed
        name=$(grep "^name:" "$app_dir/config.yml" | sed 's/name: //' | sed 's/^ *//' | sed 's/ *$//')
        description=$(grep "^description:" "$app_dir/config.yml" | sed 's/description: //' | sed 's/^ *//' | sed 's/ *$//')
        version=$(grep "^version:" "$app_dir/config.yml" | sed 's/version: //' | sed 's/^ *//' | sed 's/ *$//')
        image=$(grep "^image:" "$app_dir/config.yml" | sed 's/image: //' | sed 's/^ *//' | sed 's/ *$//')
    fi
    
    # Parse metadata.yml if exists
    category=""
    tags=""
    author=""
    homepage=""
    license=""
    icon=""
    featured=false
    
    if [[ -f "$app_dir/metadata.yml" ]]; then
        if command -v yq >/dev/null 2>&1; then
            category=$(yq eval '.category' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            tags=$(yq eval '.tags' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            author=$(yq eval '.author' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            homepage=$(yq eval '.homepage' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            license=$(yq eval '.license' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            icon=$(yq eval '.icon' "$app_dir/metadata.yml" 2>/dev/null || echo "null")
            featured=$(yq eval '.featured' "$app_dir/metadata.yml" 2>/dev/null || echo "false")
        else
            category=$(grep "^category:" "$app_dir/metadata.yml" | sed 's/category: //' | sed 's/^ *//' | sed 's/ *$//')
            tags=$(grep "^tags:" "$app_dir/metadata.yml" | sed 's/tags: //' | sed 's/^ *//' | sed 's/ *$//')
            author=$(grep "^author:" "$app_dir/metadata.yml" | sed 's/author: //' | sed 's/^ *//' | sed 's/ *$//')
            homepage=$(grep "^homepage:" "$app_dir/metadata.yml" | sed 's/homepage: //' | sed 's/^ *//' | sed 's/ *$//')
            license=$(grep "^license:" "$app_dir/metadata.yml" | sed 's/license: //' | sed 's/^ *//' | sed 's/ *$//')
            icon=$(grep "^icon:" "$app_dir/metadata.yml" | sed 's/icon: //' | sed 's/^ *//' | sed 's/ *$//')
            featured=$(grep "^featured:" "$app_dir/metadata.yml" | sed 's/featured: //' | sed 's/^ *//' | sed 's/ *$//')
            # Convert string "true"/"false" to boolean
            [[ "$featured" == "true" ]] && featured=true || featured=false
        fi
    fi
    
    # Check for icon files
    icon_file=""
    if [[ -f "$app_dir/icon.png" ]]; then
        icon_file="icon.png"
    elif [[ -f "$app_dir/logo.png" ]]; then
        icon_file="logo.png"
    elif [[ -f "$app_dir/app.png" ]]; then
        icon_file="app.png"
    fi
    
    # Skip if name is null or empty
    if [[ "$name" == "null" || -z "$name" ]]; then
        echo -e "${RED}Error: Could not parse name from $app_name/config.yml${NC}"
        continue
    fi
    
    # Build JSON object
    cat >> "$APPS_FILE" << EOF
  {
    "name": "$name",
    "description": "$description",
    "version": "$version",
    "image": "$image",
EOF

    # Add optional fields
    [[ "$category" != "null" && -n "$category" ]] && echo "    \"category\": \"$category\"," >> "$APPS_FILE"
    [[ "$tags" != "null" && -n "$tags" ]] && echo "    \"tags\": \"$tags\"," >> "$APPS_FILE"
    [[ "$author" != "null" && -n "$author" ]] && echo "    \"author\": \"$author\"," >> "$APPS_FILE"
    [[ "$homepage" != "null" && -n "$homepage" ]] && echo "    \"homepage\": \"$homepage\"," >> "$APPS_FILE"
    [[ "$license" != "null" && -n "$license" ]] && echo "    \"license\": \"$license\"," >> "$APPS_FILE"
    
    # Add icon (FontAwesome class or file)
    if [[ "$icon" != "null" && -n "$icon" ]]; then
        echo "    \"icon\": \"$icon\"," >> "$APPS_FILE"
    elif [[ -n "$icon_file" ]]; then
        echo "    \"icon\": \"$icon_file\"," >> "$APPS_FILE"
    fi
    
    echo "    \"featured\": $featured" >> "$APPS_FILE"
    
    # Remove trailing comma if this is not the last app
    # We'll handle this in the final step
    
    # Close the object
    echo "  }," >> "$APPS_FILE"
    
    echo -e "${GREEN}✓ Added $app_name${NC}"
done

# Remove trailing comma and close array
sed -i '$ s/,$//' "$APPS_FILE"
echo "]" >> "$APPS_FILE"

echo -e "${GREEN}✓ apps.json generated successfully!${NC}"
echo -e "${YELLOW}Location: $APPS_FILE${NC}"

# Show summary
app_count=$(find "$APPS_DIR" -maxdepth 1 -type d | wc -l)
echo -e "${GREEN}Total apps processed: $app_count${NC}"
