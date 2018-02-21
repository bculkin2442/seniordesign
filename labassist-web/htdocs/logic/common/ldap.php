 <?php

//Primary login handler
function login($usr,$pass)
{
        //Establish ldap connection object
        $ldap=ldapCon();
        
        //Determine if login server is up/down
        $status = chkServer("idmprodldap.wvu.edu",389);
        
        //If server is up, lets check the credentials
        if($status == 200)
        {
            $status = checkUser($ldap,$usr,$pass);
        }
        
        //Return the status.
        return $status;
}

//Create ldap connection object
function ldapCon()
{
         //this is the name of the domain controller
        $server = "ldap://idmprodldap.wvu.edu"; 
        
        //the port to query the global catalog for active directory is 3268
        $ldap_connection = ldap_connect($server,389) or die("Could not connect to $ldaphost");
        
        var_dump($ldap_connection);
        
        //If ldap connection was not null set some parameters. 
        if($ldap_connection)
        {
                ldap_set_option($ldap_connection, LDAP_OPT_PROTOCOL_VERSION,3);
                ldap_set_option($ldap_connection, LDAP_OPT_REFERRALS, 0);
        }
        
        return $ldap_connection;
}

//Bind the user to determine if the credentials are indeed valid.
function checkUser($ldap,$user,$pass)
{
        $login_ok = false;
        
        $ldapParams="uid=$user,ou=people,dc=wvu,dc=edu";
        
        //Check credentials
        $bind = ldap_bind($ldap,$ldapParams,$pass);
        
        //if not null then credentials were valid
        if($bind)
        {
                $login_ok=true;
        }
        
        return $login_ok;
}


//Function to determine if login server is up.
function chkServer($host, $port)
{  
    $hostip = @gethostbyname($host); // resloves IP from Hostname returns hostname on failure
   
    //Check to see if host exists
    if ($hostip == $host) // if the IP is not resloved
    {
        return 503;
    }
    else
    {
        //Host exists, now check to see if host wants to talk on the port.
        if (!$x = @fsockopen($hostip, $port, $errno, $errstr, 5)) // attempt to connect
        {
            //Host didn't want to talk
            return 504;
        }
        else
        {
            //Host talked, now delete the connection object and return
            if ($x)
            {
                @fclose($x); //close connection
            }
            return 200;
        } 
    }
}



function getUserAttr($query_user,$password) {
	// Active Directory server
    $ldap=ldapCon();

    $ldap_dn="ou=people,DC=wvu,DC=edu";
    $ldapParams="uid=$query_user,ou=people,dc=wvu,dc=edu";
    
	ldap_bind($ldap,$ldapParams,$password) or die("Could not bind to LDAP");

	// Search AD
	$results = ldap_search($ldap,$ldap_dn,"(uid=$query_user)",array("gecos","value","mail","value","wvuid","value"));
	$entries = ldap_get_entries($ldap, $results);
	
	// No information found, bad user
	if($entries['count'] == 0) return false;
	
    // Clean up data by dumping needed items into fresh array.
	$data = array("fullName" => $entries[0]['gecos'][0],"mail" => $entries[0]['mail'][0],"sidno" => $entries[0]['wvuid'][0]);

	return $data;
}

function getSidnoAttr($sidno) {
	// Active Directory server
    $ldap=ldapCon();

    $ldap_dn="ou=people,DC=wvu,DC=edu";
    $ldapParams="ou=people,dc=wvu,dc=edu";
    
	ldap_bind($ldap) or die("Could not bind to LDAP");

	// Search AD
	$results = ldap_search($ldap,$ldap_dn,"(wvuid=$sidno)",array("uid","value","gecos","value","mail","value","wvuid","value"));
	$entries = ldap_get_entries($ldap, $results);
	
	// No information found, bad user
	if($entries['count'] == 0) return false;
	
    // Clean up data by dumping needed items into fresh array.
	$data = array("fullName" => $entries[0]['gecos'][0],"mail" => $entries[0]['mail'][0],"sidno" => $entries[0]['wvuid'][0],"uid" => $entries[0]['uid'][0]);

	return $data;
}
?>
