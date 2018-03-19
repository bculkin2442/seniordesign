<?php

require_once "logic/common/commonFunctions.php";

function createNavigation()
{
    $sysadmin="";
    $staff="";
    $tutor="";
    $student="";
    
    $html=<<<eof
        <script src="libraries/jquery/jquery-3.2.1.min.js"></script>
        <script src="scripts/navigation.js"></script>
    
        <li class="navheader">Main </li>
            <li class="">
            <a href="portal.php" class="nav-menu-item">Home</a>
        </li>
eof;


    switch(getUserLevelAccess($_SESSION['username'])) {
        case 'sysadmin':
            $sysadmin.="";
            break;
        case 'developer':
        
        case 'staff':
            $staff=<<<eof
            <li class="navheader">
                Administration
            </li>
            <li class="">
                <a href="manageclasses.php" class="nav-menu-item">Class Management</a>
            </li>
            <li class="">
                <a href="" class="nav-menu-item">Section Management</a>
            </li>
            <li class="">
                <a href="manageusers.php" class="nav-menu-item">User Management</a>
            </li>
            <li class="">
                <a href="" class="nav-menu-item">Q/A Administration</a>
            </li>
            <li class="">
                <a href="" class="nav-menu-item">Reports</a>
            </li>
eof;

        case 'tutor': 
            $tutor.= <<<eof
                <li class="navheader">Tutor </li>
                <li class="">
                    <a href="" class="nav-menu-item">Update Tutor Schedule</a>
                </li>
                <li class="">
                    <a href="" class="nav-menu-item">Q/A Moderation</a>
                </li>
eof;

        case 'student':
            $student.= <<<eof
                <li class="">
                    <a href="" class="nav-menu-item">Tutor Schedule</a>
                </li>
                <li class="">
                    <a href="" class="nav-menu-item">Q/A Forum</a>
                </li>
                <li class="">
                    <a href="updateprofile.php" class="nav-menu-item">Account Settings</a>
                </li>
eof;
            break;
    }

    return $html.=$student.$tutor.$staff;
}

?>
