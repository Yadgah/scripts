import os
from pathlib import Path
from django.core.management.utils import get_random_secret_key

# مسیر فایل .env (در کنار manage.py)
env_path = Path(__file__).resolve().parent / ".env"

# تولید کلید امن جدید
secret_key = get_random_secret_key()

# ساخت محتوای .env
env_content = f"""# Automatically generated
SECRET_KEY='{secret_key}'
DEBUG=False
"""

# نوشتن فایل .env
with open(env_path, "w") as f:
    f.write(env_content)

print(f".env file created at: {env_path}")
print(f"SECRET_KEY set to: {secret_key[:10]}... (hidden for security)")

