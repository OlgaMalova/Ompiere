# Ompiere

## OMPIERE OVERVIEW

Ompiere is an enterprise resource planning (ERP) and customer relationship management (CRM) solution. The steps and procedures covered in this user guide are intended to help users learn the functionality of Ompiere. 

In order to run Ompiere, you need to have a JDK (not JRE) version of Java, and a proper database (PostgreSQL and Oracle are supported). The examples in this guide are using the following versions:

- Ubuntu 22.04 64 bits
- Oracle Linux 9
- Oracle 12C and higher, PostgreSQL 11 and higher (in certain scenarios, it is required to install PostgreSQL contrib for UUID support)
- OpenJDK 17

**Tip:** It is mandatory to use a Unicode character set.

Implementing an Enterprise Resource Planning (ERP) system in your organization can be a smooth process when you follow this Ompiere tutorial. From understanding the basics to customizing for your own needs, it’s a great intro to an excellent system.

- Successfully implement Ompiere—an open-source, company-wide ERP solution—to manage and coordinate all the resources, information, and functions of a business.
- Master data management and centralize the functions of various business departments in an advanced ERP system.
- Efficiently manage business documents such as purchase/sales orders, material receipts/shipments, and invoices.
- Extend and customize Ompiere to meet your business needs.
- Written in a clear and practical manner, this book follows a realistic case-study example enabling you to learn about Ompiere fundamentals and best practices along the way.

## In Detail

Enterprise resource planning (ERP) systems are essential in today's business market. There are many options for ERP systems; however, Ompiere offers a solid foundation for developing a powerful ERP system that helps your business manage data efficiently, streamline different processes, lower costs, and improve efficiency levels without too much complexity.

### Install Ubuntu

Please refer to [Ubuntu Download](https://www.ubuntu.com/download).

- Downloaded and installed Ubuntu Server 22.04 LTS (Oracle Linux 9).

### Install PostgreSQL 15

iDempiere can also run with Oracle 12C and later, and also with PostgreSQL 11 and later. For this How-To, we use PostgreSQL 15 - see [PostgreSQL Download](https://www.postgresql.org/download/linux/ubuntu/) for details.

#### Create the file repository configuration:

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

#### Import the repository signing key:

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

#### Update the package lists:

sudo apt-get update

#### Install version 15 of PostgreSQL:

sudo apt-get -y install postgresql-15

**IMPORTANT NOTE!**  
In other versions of Linux, you need to additionally install the package `postgresql-contrib` corresponding to the version you are installing. In Ubuntu, it is included by default, but in other cases, it is mandatory to install it; otherwise, you'll get errors about the `generate_uuid()` function. Also, instructions are different for other Linux versions; in some, you need to create and start the cluster and also configure the service for auto-start. Please refer to the specific PostgreSQL instructions for such cases.

### Assign a password to user postgres

In order to create the database, the installer needs to know the password of the user `postgres`. By default, this user doesn't have a password in Ubuntu (the Windows installer asks for a password).

Please take note of the password you assign here as it will be required in the setup process:

**Steps are (replace `your_chosen_password` by your preferred):**

echo "alter user postgres password 'your_chosen_password'" | sudo su postgres -c "psql -U postgres"

### Configure pg_hba.conf

After installing PostgreSQL, you must check the correct configuration of `/etc/postgresql/15/main/pg_hba.conf`.

The following line requires change of the authentication method:

local   all             all                                     peer

Change to:
local   all             all                                     scram-sha-256

**NOTE:** Some guides suggest configuring trust instead of md5, but that creates a security issue on your PostgreSQL server.

Then reload the configuration:
sudo service postgresql reload

### Install OpenJDK 17

sudo apt-get update
sudo apt-get install openjdk-17-jdk-headless