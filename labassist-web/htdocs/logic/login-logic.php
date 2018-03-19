<?php
    require_once "logic/common/ldap.php";
    require_once "logic/database/dbCon.php";
    
function attemptPassLogin()
{
    $error = "";
    
    if (empty($_POST['username']) || empty($_POST['password']))
    {
        $error = "Both username and password are required.";
    }
    else
    {
        // Define $username and $password
        $username   = $_POST['username'];
        $password   = $_POST['password'];

        //Processs login
        $isSuccess = login($username,$password);


        //Error Handling
        if( $isSuccess == 1)
        {

            //Login was successfull now we need to determine if user is a new user. 
            $registered = isRegistered($username);
            //$registered = true;
            
            
            if($registered == false)
            {
                $_SESSION['userAttr']=getUserAttr($username,$password);
                $_SESSION["username"]=$username;
                $_SESSION["register"]=true;
                header("location: user_registration.php");
                exit();
            }
            else
            {
                $_SESSION["username"]=$username;
                header("location: portal.php"); // Redirecting To Other Page
                exit();
            }
        }
        elseif($isSuccess == 503)
        {
            $error = "Error 503: Logon server appears to be down.";
        }
        elseif($isSuccess == 504)
        {
            $error = "Error 504: Logon server refused to answer request.";
        }
        else
        {
            $error = "Login Failed. <br> Please Check Username and Password.";
        }
    }
    
    return $error;
}

function attemptKioskLogin()
{
    if(empty($_POST['sidno']))
    {
        $error = "Error: ID Number Required";
        return $error;
    }
    else if (!preg_match("/^\d{9}$/",$_POST['sidno']))
    {
        $error = "Error: Invalid ID Number";
        return $error;
    }
    
    $status = kioskLoginCheck();
    
    if (!($status==-1))
    {
        if($status == 1)
        {
            $_SESSION['kiosk']= true;
            $_SESSION['sidno']= $_POST['sidno'];
            header("location: tutor_session.php");
            exit();
        }
        else
        {
            $_SESSION["registerSid"]=true;
            $_SESSION['sidno']= $_POST['sidno'];
            $_SESSION['userAttr']=getSidnoAttr($_POST['sidno']);
            header("location: user_registration.php");
            exit();
        }
    }
    
    return $error;
}

function isRegistered($userName)
{
    $status = false;
    
    $dbCon = connectDB();
    
    $sql="select idno from users where username=?";
    
    $stmt= $dbCon->prepare($sql);
    
    $stmt->execute(array($userName));

    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if(!empty($result))
    {
        $status = true;
    }

    return $status;
}

function kioskLoginCheck()
{
    $status = 0;
    
    try
    {
        $dbCon = connectDB();
        
        $sql="select idno from users where idno=?";
        
        $stmt= $dbCon->prepare($sql);
        
        $stmt->execute(array($_POST['sidno']));

        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if(!empty($result))
        {
            $status = 1;
        }
    }
    catch(PDOException $d)
    {
        $status = -1;
    }

    return $status;
}

?>
