<?php
	
function connectDB()
{
	//Connect string information for the database.
	$host = "localhost";
	$user = "labassist";
	$password = "labassist";
	$dBase = "labassist";
	//$dBase = "techitinventory";
	
        $dbase_connection=null;
        
        try
        {
            //this is how to connect to the database.  I ran into a character set issue, so I'm specifically
            //telling PDO that I want the character set to be utf8
            
            //Mysql Dbase conn
            #$dbase_connection = new PDO("pgsql:dbname=$dBase" $user, $password);
            
            //Postgrese Dbase conn
            $dbase_connection = new PDO("pgsql:dbname=$dBase",$user,$password);
            
            
            //pdo's error mode is set to throw exceptions
            $dbase_connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            //let pdo try to use native prepared statements
            $dbase_connection->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
            
        }
        catch(PDOException $e)
        {
            echo $e->__toString();
        }
        
        return $dbase_connection;            
}

function databaseExecute($sql)
{
    $result = "";
    
    try
    {
        $dbCon = connectDB();
        
        $stmt = $dbCon->query($sql);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(PDOException $d)
    {
        $result = -1;
    }
    
    return $result;
}


function databaseQuery($sql,$array)
{
    $result = "";
    
    try
    {
        $dbCon = connectDB();
        
        $stmt= $dbCon->prepare($sql);
        
        $stmt->execute($array);

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
    catch(PDOException $d)
    {
        $result = -1;
    }
    
    return $result;
}
?>
