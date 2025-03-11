#!/bin/bash

# تعریف متغیرها
REPO_DIR="Yadgah"
BACKUP_DIR="bk"
REPO_URL="https://github.com/Yadgah/Yadgah"
VENV_DIR="$REPO_DIR/.venv"

# لاگ‌گیری
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# بررسی خطا
check_error() {
    if [ $? -ne 0 ]; then
        log "Error: $1"
        exit 1
    fi
}

# پاکسازی و ایجاد پشتیبان
log "Cleaning up and creating backup..."
rm -rf $BACKUP_DIR
check_error "Failed to remove backup directory"
mv $REPO_DIR $BACKUP_DIR
check_error "Failed to move repository to backup directory"

# کلون کردن ریپوی جدید
log "Cloning new repository..."
git clone $REPO_URL $REPO_DIR
check_error "Failed to clone repository"

# ایجاد محیط مجازی
log "Creating virtual environment..."
python -m venv $VENV_DIR
check_error "Failed to create virtual environment"

# کپی فایل‌های رسانه و دیتابیس
log "Copying media files and database..."
cp -r $BACKUP_DIR/media/ $REPO_DIR/
check_error "Failed to copy media files"
cp $BACKUP_DIR/db.sqlite3 $REPO_DIR
check_error "Failed to copy database"

# فعال کردن محیط مجازی و نصب نیازمندی‌ها
log "Activating virtual environment and installing requirements..."
source $VENV_DIR/bin/activate
check_error "Failed to activate virtual environment"
pip install -r $REPO_DIR/requirements.txt
check_error "Failed to install requirements"

# اجرای دستورات مدیریتی
log "Running management commands..."
python $REPO_DIR/manage.py collectstatic --noinput
check_error "Failed to collect static files"
python $REPO_DIR/manage.py makemigrations blog home
check_error "Failed to make migrations"
python $REPO_DIR/manage.py migrate
check_error "Failed to migrate"

log "Update completed successfully!"
