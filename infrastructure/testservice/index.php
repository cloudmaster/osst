<html>
<head>
<title>Test Service Signup Page</title>
</head>
<body>

<?php

if (!$_GET["signup"]) :
	include("view_form.php");
else :
	include("view_thanks.php");
endif;

?>

</body>
</html>
