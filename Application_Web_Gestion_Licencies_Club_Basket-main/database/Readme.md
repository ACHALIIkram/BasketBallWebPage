# Techballer database

This README will guide you through the steps to install MySQL Server, create and use our local database.

## Install MySQL Server

You can download MySQL Server from the official website: https://dev.mysql.com/downloads/

### Windows OS 

1. Download and run the MySQL Installer from the official MySQL website.
2. Follow the installation steps, and during setup, define a root password for the MySQL server.

### Linux OS

1. Update your package list:

sudo apt-get update

2. Install MySQL Server:

sudo apt-get install mysql-server

3. After installation, start the MySQL service:

sudo service mysql start

### Mac OS 

1. Use Homebrew to install MySQL:

brew install mysql

2. Start the MySQL service:

brew services start mysql

## Access MySQL Server

Once MySQL Server is installed, you can access it via the MySQL shell.

### For Windows

1. Open Command Prompt (cmd) or PowerShell.

2. Navigate to the directory where MySQL is installed. For example:

cd C:\Program Files\MySQL\MySQL Server 8.0\bin

3. Launch MySQL with the following command:

mysql -u root -p

4. Enter the root password that you defined during the installation.

### For Linux and Mac OS

1. Open your terminal.

2. Access MySQL with the following command:

mysql -u root -p

3. Enter the root password when prompted.

## Create and Use the Techballer Database

Once you're logged into the MySQL shell, you can use the following steps to create the Techballer database and initialize the tables.

1. Import the Schema and Data

To create the Techballer database and populate it with tables and sample data, simply import the SQL script files into MySQL.

In MySQL, use the following command to import the techballerdb.sql file (which contains the database creation and table definitions):

source /path/to/techballerdb.sql;

Then, use the following command to import the data file techballerdata.sql (which contains the sample data for the tables):

source /path/to/techballerdata.sql;

Replace /path/to/ with the actual path to your techballerdb.sql and techballerdata.sql files.

2. Verify the Data

After running the imports, you can verify the data by running the following command to check the tables in the database:

SHOW TABLES;

You can also inspect the data in specific tables. For example, to check the User table:

SELECT * FROM User;