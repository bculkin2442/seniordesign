.Section "Installation"
.Subhead "Introduction"
.Para
OS independent instructions are provided. Please refer to your OS or
distributions documentation for detailed information on how to perform certain
tasks.
.Superhead "Document Assumptions"
.Bullet
Operating System of Choice is Linux
.Bullet
Apache is installed and functioning properly
.Bullet
postgreSQL v. 9.6+ is installed and functioning properly
.Bullet
PHP v7.0 is installed and functioning properly
.Para
Respectable tutorials for setting up the aforementioned items can be found in
the documentation for your distribution. If these do not suit your purposes,
DigitalOcean provides guides that are simple and easy to follow.
.Endsup
.Superhead "PHP Extensions/packages"
.Para
For PHP, the following extensions are required (The names in parentheses are the
OpenSUSE package names for those extensions. Refer to your package manager or
distribution documentation if you use a different one)
.Bullet
LDAP (php7-ldap)
.Bullet
pgSQL (php7-pgsql)
.Bullet
MBString (php7-mbstring)
.Bullet
PDO (php7-pdo)
.Bullet
OpenSSL (php7-openssl)
.Endsup
.Endsub
.Subhead "Configuration"
.Superhead "Important settings"
.nr setlist 1 1
.IP \n[setlist]
Change postgreSQL authentication to ``trust'' authentication for the localhost
.IP \n+[setlist]
If your system uses SELinux, you must enable ``httpd_can_network_connect'' to
allow PHP to communicate with the LDAP/Active Directory server.
.Endsup
.Superhead "Downloading"
.Numlist
.Numitem
Create a directory in your home folder and change directory to it
.B1
.CL "bash"
.CL "mkdir ~/dir"
.CL "cd ~/dir"
.B2
.Numitem
Clone the repository into your directory
.B1
.CL "git clone https://github.com/AdamC1228/LabAssist.git"
.B2
.Numitem
Change to the repository directory
.B1
.CL "cd LabAssist"
.B2
.Endsup
.Endsub
.Subhead "Database Setup"
.Superhead "User Creation"
.Numlist
.Numitem
Run the following commands to create the user and database
.B1
.CL "sudo -u postgres createuser labassist"
.CL "sudo -u postgres createdb labassist"
.B2
.Numitem
Start the postgreSQL console with the following command
.B1
.CL "sudo -u postgres psql"
.B2
.Numitem
Run the following commands in the postgreSQL console to give the user a password
and permission to use the database.
.B1
.CL "alter user labassist with encrypted password 'labassist';"
.CL "grant all privileges on labassist to labassist;"
.B2
.Numitem
Finally, run the following command to load the schema into the database
.B1
.CL "sudo -u postgres psql labassist labassist -f dbschema.sql"
.B2
.Endsup
.Endsub
.Subhead "Site Installation"
.Numlist
.Numitem
Change directory into the document root for your webserver. Traditionally, this
is at /var/www/html or /var/www/htdocs. If you have changed this, use the
document root you created.
.Numitem
Copy the repository folder you cloned earlier to the document root.
.Numitem
Update the permissions on the document root. The following command will do this,
assuming that the name of the user who is installing the application is 'usr'
and that 'apache' is the group of the webserver (This is typically apache, httpd
or www-data) and that your document root is at /var/www/html
.B1
.CL "chown -R user:apache /var/www/html"
.B2
.Numitem
On SELinux systems, the appropriate security contexts must be set. You will
likely need to refer to your distribution for the correct set of contexts to
use.
.Numitem
Apply the appropriate context across all of the files in the document root
(Assuming that your document root is at /var/www/html, and that the appropriate
context is system_u:object_r:httpd_sys_content_t:s0)
.B1
.CL "chcon -R system_u:object_r:httpd_sys_content_t:s0 /var/www/html"
.B2
.Numitem
Set the proper permissions on all files in the document root with the following
commands, assuming your document root is /var/www.
.B1
.CL "find /var/www/ -type f -exec chmod 640 {} \;".
.CL "find /var/www/ -type d -exec chmod 751 {} \;".
.B2
.Endsub
.Subhead "Site Configuration"
.Para
There are two files that need configuration for the website to function
properly. These are dbCon.php and ldap.php.
.Superhead "Database (dbCon.php)"
.Numlist
.Numitem
Open the dbCon.php file located in <documentRoot>/logic/database in an editor.
.Numitem
Change the username, password and database variables to be 'labassist'. These can be
something different if you set a different username, password or database earlier, in which
case it should be the things you specified.
.Numitem
Save and close the file.
.Endsup
.Superhead "LDAP (ldap.php)"
.Numlist
.Numitem
Open the ldap php file located in <documentRoot>/logic/common in an editor.
.Numitem
Change the server URL on lines 16 and 40 to reflect your LDAP servers URL and
port.
.Numitem
On lines 4, 5 and 6; update the LDAP parameters to match your active directory
structure. (Specifying the OU here is not necessary, but it speeds up the
application substantially to do so.)
.Numitem
If you are  not setting this system up within a WVU network, the attribute names
in the getUserAttr and getSidnoAttr functions must be update. Not doing this
will cause the system to fail to get required information from the directory.
.Endsup
.Endsub
.Endsec
