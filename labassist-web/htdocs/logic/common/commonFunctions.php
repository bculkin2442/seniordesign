<?php
    
    require_once "logic/database/dbCon.php";
    
    function verifyUser()
    {
        //Users not registered should be forced to register
        if(isSet($_SESSION["register"]) && !empty($_SESSION["register"]))
        {
            if(!(basename($_SERVER['PHP_SELF'])=='user_registration.php'))
            {
                header("Location: user_registration.php");
            }
        }
        //Users not registered should be forced to register
        else if(isSet($_SESSION["registerSid"]) && !empty($_SESSION["registerSid"]))
        {
            if(!(basename($_SERVER['PHP_SELF'])=='user_registration.php'))
            {
                header("Location: user_registration.php");
            }
        }
        else if(!(basename($_SERVER['PHP_SELF'])=='user_registration.php'))
        {
            //Users not logged in should not be able to connect
            if(!(isSet($_SESSION["username"]) && !empty($_SESSION["username"])))
            {
                header("Location: login.php");
                exit();
            }
        }
        else
        {
                header("Location: login.php");
                exit();
        }

    }
    
    function verifyKiosk()
    {
        // Usermode login does not grant access to this mode
        if((isSet($_SESSION["username"]) && !empty($_SESSION["username"])))
        {
            header("Location: login.php");
            exit();
        }
        
        if(isSet($_SESSION["register"]) && !empty($_SESSION["register"]))
        {
            if(!(basename($_SERVER['PHP_SELF'])=='user_registration.php'))
            {
                header("Location: user_registration.php");
            }
        }
        
                //Users not logged in should not be able to connect
        if(!(isSet($_SESSION["kiosk"]) && !empty($_SESSION["kiosk"])))
        {
            #print_r ($_SESSION);
            header("Location: login.php");
            exit();
        }
        
    }
    
    function getUserLevelAccess($user)
    {

        $result= databaseQuery("select role from users where username=?",array($user));
        
        if(!empty($result))
        {
            return $result[0]['role'];
        }
        else 
        {
            return -1;
        }
    }
    
    
    
    function verifyUserLevelAccess($username,$requestPage)
    {

        $result=databaseQuery("select count(username) from users,pageaccess where users.username=? and pageaccess.page=? and users.role>=pageaccess.role",array($username,$requestPage));
        
        if(empty($result) || $result[0]['count']==0)
        {
            header("Location: 403.php?requestedPage=$requestPage");
        }
        else if( $result[0]['count'] != 1)
        {
            echo "Whoops Contact System Admin";
            exit();
        }
    }
    
    function verifyUserIdLevelAccess($sidno,$requestPage)
    {
        $result=databaseQuery("select count(username) from users,pageaccess where users.idno=? and pageaccess.page=? and users.role>=pageaccess.role",array($sidno,$requestPage));

        
        if(empty($result) || $result[0]['count']==0)
        {
            header("Location: 403.php?requestedPage=$requestPage");
        }
        else if( $result[0]['count'] != 1)
        {
            echo "Whoops Contact System Admin";
            exit();
        }
    }
    
    function construction($username,$requestPage)
    {
        $result=databaseQuery("select count(username) from users,pageaccess where users.username=? and pageaccess.page=? and users.role>=pageaccess.role",array($username,$requestPage));
        
        if(empty($result) || $result[0]['count']==0)
        {
            header("Location: construction.php?requestedPage=$requestPage");
        }
        else if( $result[0]['count'] != 1)
        {
            echo "Whoops Contact System Admin";
            exit();
        }
    }

    function compareAccessLevelbyName($user1,$user2)
    {
        $result=databaseQuery("select count (user1.role) as result from users as user1, users as user2 where (user1.username=? and user2.username=?) and user1.role > user2.role",array($user1,$user2));
        
        if(empty($result) || !is_array($result))
        {
            return -1;
        }
        else
        {
            return $result[0]['result'];
        }
    }
    
    
    function doesUserBelongToDept($user,$dept)
    {
        $result=databaseQuery("select deptid from users where username=?",array($user));
        
        if(empty($result) || !is_array($result))
        {
            return -1;
        }
        else
        {
            if($result[0]['deptid']==$dept)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
?>
