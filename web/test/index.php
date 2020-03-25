<?php

echo phpinfo();

if (isset($_POST['country-search'])) {
	setcookie('country-search', $_POST['country-search']);
	$_COOKIE['country-search'] = $_POST['country-search'];
}

function base64_url_encode($input) {
	return strtr(base64_encode($input), '+/=', '-_,');
}

function base64_url_decode($input) {
	return base64_decode(strtr($input, '-_,', '+/='));
}


//echo base64_url_encode('jose');
//echo base64_url_decode(base64_url_encode('jose'));

?>
 
<?php
if (isset($_COOKIE['country-search']))
	echo $_COOKIE['country-search'];
?>

 <form method="post">
  First name:<br>
  <input type="text" name="country-search" autofocus required><br>
  Last name:<br>
  <input type="text" name="lastname"><br><br>
<input type="submit" value="Submit">
</form> 