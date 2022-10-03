<?php
include "dbcon.php";
if (!$Db_con) {
    die("DataBaseecho");
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/error.css">
    <link rel="icon" href="Image/Henil.ico">
</head>

<?php
$Band = false;
$Pending = false;
$User_Name_Used = false;
$User_Email_Used = false;
$User_Not_Found = false;
?>

<!-- Sign up start-->
<?php
if (isset($_POST['U_Signup'])) {
    $select_User_Q = "SELECT * FROM user_table WHERE UNAME = '$_POST[U_name]'";
    $select_user_Result = mysqli_query($Db_con, $select_User_Q);

    $select_Email_Q = "SELECT * FROM user_table WHERE UEMAIL = '$_POST[U_email]'";
    $select_email_Result = mysqli_query($Db_con, $select_Email_Q);

    if (mysqli_num_rows($select_user_Result) > 0) {
        $User_Name_Used = true;
    } elseif (mysqli_num_rows($select_email_Result) > 0) {
        $User_Email_Used = true;
    } else {
        $inser_pending_Q = "INSERT INTO user_table (UNAME, UPASSWORD, UEMAIL) VALUES ('$_POST[U_name]','$_POST[U_password]','$_POST[U_email]')";
        $result_inser = mysqli_query($Db_con, $inser_pending_Q);
        if ($result_inser) {
            header("location: Form_login.php");
        }
    }
}


?>
<!-- end sign up -->
<!-- login start -->
<?php
if (isset($_POST['U_Login'])) {

    $log_select_Q =  "SELECT * FROM user_table WHERE UNAME = '$_POST[U_name]' AND UPASSWORD = '$_POST[U_password]'";
    $log_select_Result = mysqli_query($Db_con, $log_select_Q);
    $log_stutas_res = mysqli_fetch_assoc($log_select_Result);

    if ($log_stutas_res == 0) {
        $User_Not_Found = true;
    } else {
        if ($log_stutas_res['STATUS'] == "PENDING") {
            $Pending = true;
        } else if ($log_stutas_res['STATUS'] == "VERIFIED") {
            session_start();
            $_SESSION['User_N'] = $_POST['U_name'];
            header("location:Live_Chat.php");
        } else if ($log_stutas_res['STATUS'] == "BAND") {
            $Band = true;
        } else {
            echo "bad Request";
        }
    }
}
?>

<!-- login end -->


<body>
    <div class="container">
        <div class="main">
            <!-- Erorr list -->
            <?php
            if ($Pending) {
                echo '
            <div class="top">
                <h1>Request Pending <i class="bi bi-hourglass-split"></i></h1>
            </div>
            <div class="box detail">
                <h2><span>' . $_POST['U_name'] . '</span> Your Request is verify With in <span>24 hours</span> after you can access account, Please Wait.</h2>
            </div>
            
                <a href="index.php" class="Button"> Go to site<i class="bi bi-arrow-right"></i></a>
            ';
            } elseif ($User_Name_Used) {
                echo '
            <div class="top">
                <h1>Sign Up Faild <i class="bi bi-person-x-fill"></i></h1>
            </div>
            <div class="box detail">
                <h2> <span> ' . $_POST['U_name'] . '</span> User Name is Alredy Use. Please Enter different <span> User Name</span>.</h2>
            </div>
            
                <a href="Form_sigup.php" class="Button"> Re Sign Up <i class="bi bi-arrow-right-short"></i></a>
                ';
            } elseif ($User_Email_Used) {
                echo '
   
            <div class="top">
                <h1>Sign Up Faild <i class="bi bi-envelope-exclamation"></i></h1>
            </div>
            <div class="box detail">
                <h2> Enter <i class="bi bi-envelope"></i> <span> ' . $_POST['U_email'] . ' </span> Email Address is Alredy Use. Please Enter different <span> Email Address</span>.</h2>
            </div>        
                <a href="Form_sigup.php" class="Button"> Re Sign Up <i class="bi bi-arrow-right-short"></i></a>
            ';
            } elseif ($User_Not_Found) {
                echo '
                <div class="top">
                <h1>User Not Found </h1>
                <img src="Image/no-results.png">
            </div>
            <div class="box detail">
                <h2> Your User Name or Password <span>Not Match</span> Please Check.</h2>
                </div>
                
                <a href="Form_login.php" class="Button red"> Re Log in</a>
                ';
            } elseif ($Band) {
                echo '
                <div class="top">
                    <h1>User Banned </h1>
                    <img src="Image/banned.jpg" class="img1">
                </div>
                <div class="box detail">
                    <h2>  <span>' . $_POST['U_name'] . '</span>  Your are Banned.</h2>
                </div>
                <a href="index.php" class="Button red"> Go Web-site</a>
            ';
            } else {
                echo "<h1> Bad Request </h1>";
            }
            ?>
        </div>
    </div>
</body>