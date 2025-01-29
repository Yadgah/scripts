#!/bin/bash

# Step 1: Create virtual environment if it doesn't exist
if [ ! -d ".env" ]; then
    python -m venv .env
fi

# Step 2: Activate virtual environment
source .env/bin/activate

# Step 3: Read required packages from requirements.txt
if [ -f "requirements.txt" ]; then
    while IFS= read -r package; do
        if [[ ! -z "$package" && "$package" != \#* ]]; then
            REQUIRED_PACKAGES+=("$package")
        fi
    done < requirements.txt
fi

# Step 4: Check for missing packages
INSTALLED_PACKAGES=$(pip freeze | cut -d= -f1)
MISSING_PACKAGES=()
for pkg in "${REQUIRED_PACKAGES[@]}"; do
    pkg_name=$(echo "$pkg" | cut -d= -f1)
    if ! echo "$INSTALLED_PACKAGES" | grep -q "^$pkg_name$"; then
        MISSING_PACKAGES+=("$pkg")
    fi
done

# Step 5: Install missing packages
if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
    pip install "${MISSING_PACKAGES[@]}"
else
    echo "All required packages are already installed."
fi

# Step 6: Run migrations and create superuser
python manage.py migrate
python manage.py createsuperuser

