# Automatic Setup Scripts

This repository contains scripts designed to automate the setup and deployment of the Yadgah project. These scripts streamline the process of cloning the repository, setting up the virtual environment, installing dependencies, migrating databases, and more.

## Features

- Clone the Yadgah repository from GitHub.
- Set up a Python virtual environment.
- Install project dependencies.
- Replace media files and database with the latest versions.
- Apply database migrations.
- Clean up temporary files after the setup.


## Usage

The `main.sh` script will perform the following tasks:

1. Clone the Yadgah repository from GitHub.
2. Set up a Python virtual environment.
3. Install all required dependencies.
4. Replace media files and SQLite database from the main project folder.
5. Run database migrations to ensure your database is up-to-date.
6. Clean up temporary files and prepare the project for use.
