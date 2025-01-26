# Define log file
LOG_FILE="setup_log.txt"

# Function to log messages
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Start script
log "Starting repository cloning..."
git clone https://github.com/Yadgah/Yadgah.git
log "Repository cloned successfully."

# Set up the virtual environment
log "Setting up virtual environment..."
python -m venv Yadgah/.venv
source Yadgah/.venv/bin/activate
log "Virtual environment set up successfully."

# Install dependencies
log "Installing dependencies from requirements.txt..."
pip install -r Yadgah/requirements.txt
log "Dependencies installed."

# Replace media directory
log "Replacing media directory..."
rm -rf Yadgah/media
cp -r Yadgah_main/media/ Yadgah/
log "Media directory replaced."

# Migrate database and handle SQLite file
log "Removing old SQLite database..."
rm -f Yadgah/db.sqlite3
log "Copying new SQLite database..."
cp Yadgah_main/db.sqlite3 Yadgah/
log "Database copied."

# Apply migrations
log "Applying migrations..."
python Yadgah/manage.py migrate
log "Migrations applied."

# Clean up
log "Cleaning up temporary files..."
rm -rf Yadgah_main
mv Yadgah Yadgah_main
