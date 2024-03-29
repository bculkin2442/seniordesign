# ReadMe

OS independent instructions are provided. Please refer to your OS/distribution's documentation for detailed information regaurding the specific details.

#### This document assumes the following:
- Operating system of choice is linux
- Apache is installed and functioning
- postgreSQL v 9.6+ is installed and functioning
- PHP v7.0 is installed and properly funcitoning

Respectable tutorials for setting up the aforementioned items can be found in your distrobutions documentation. Additionally digitalocean guides are typically simple and easy to follow.

#### The following packages are required.
- php7-ldap
- php7-pgsql
- php7-mbstring
- php7-pdo
- php7-openssl

------------


## Configuration
#### Important Settings
1. Change postgreSQL authentication to trust authentication for the localhost
2. If the system uses Selinux you must enable httpd_can_network_connect to allow php to communicate with the LDAP/Active Directory server.

#### Downloading
1. Create a directory in your home folder and change directory into it.
```bash
mkdir ~/githubClones
cd ~/githubClones
```
2. Clone the repository to your new folder
```bash
git clone https://github.com/AdamC1228/LabAssist.git
```
3. Change directory into LabAssist
```bash
cd  ~/LabAssist
```

#### Database Setup
##### BEN's guide goes here

####Site Installation
1. Change directory into your websites document root (usually /var/www/html or /var/www/htdocs). If you changed the document root, please use the document root that you created.
```bash
cd /var/www/html
```

2. Copy the repository folder into the destination document root.
```bash
cp -R ~/githubClones/LabAssist/* ./
```

3. Update the permissions on the document root. Please refer to distrobution specific instructions here. An example is provided for convienience. user is the username of the user who is installing the application. Apache is the group of the webserver (typically apache or httpd or www-data).
```bash
chown -R user:apache /var/www/html
```

4. On Selinux systems we must set the appropriate SeLinux security contexts. (Refer to distrobution for specific contexts or use the contexts of the exisiting documents in the document root.
  1. Show the context of existing files
```bash
ls -z
```

  2. Apply the context across all files in the document root. (NOTE: The given context is an example and is not nessesarily the correct on for your distrobution).
 ```bash
chcon -R system_u:object_r:httpd_sys_content_t:s0 /var/www/html
```

5. Set the proper permissions on all files in the document root with the following commands:
  1. Set the file permissions:
```bash
find /var/www/ -type f -exec chmod 640 {} \;
```

  2. Set the folder permissions:
```bash
find /var/www/ -type d -exec chmod 751 {} \;
```

###Site Configuration
There are two files that need configuration for the website to function properly. The first is the dbCon.php for the database and the ldap.php for active directory authentication.

#### Database
1. Open the dbCon.php file located in /pathToDocumentRoot/logic/database/ in your favorite editor
```bash
vi /pathToDocumentRoot/logic/database/dbCon.php
```

2. Alter the username variable to be the username of the database user that you created when setting up the database.
```php
$user = "????";
```

3. Alter the password variable to be the password that you set for the user you created when setting up the database.
```php
$password= "?????";
```

4. Alter the dBase variable to be the name of the database you created when setting up the database.
```php
$dBase = "labassist";
```

5. Save and close the file.

### LDAP
1. Open the ldap.php file located in /pathToDocumentRoot/logic/common/ in your favorite editor
```bash
vi /pathToDocumentRoot/logic/common/ldap.php
```

2. Change the server url on lines 16 and 40 to reflect your ldap server's url and port.

3. Lines 4,5,6 update the ldap paramters to match your active directory structure. Specifying the OU in the serverDN variable is optional, however it speeds up the system significantly to specify it here.

4. For users not setting this system up within a WVU system, you must update the names of the acitve directory attributes to reflect those of your organization in the getUserAttr and getSidnoAttr functions. Failure to do so will result in the inability to pull required information from the active directory accrount services.
