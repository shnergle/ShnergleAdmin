<?php
session_start();

$type = 'normal';

if (isset($_GET['action']) && $_GET['action'] == 'auth') {
	if ($_POST['username'] == 'shnergle' && $_POST['password'] == '$Hnergle1') {
		$_SESSION['auth'] = true;
		header('Location: /');
	} else {
		header('Location: /');
	}
} elseif (isset($_GET['action']) && $_GET['action'] == 'out') {
	session_unset();
	session_destroy();
	header('Location: /');
} elseif (!isset($_SESSION['auth'])) {
	$type = 'signin';
	require_once 'header.php';
	require_once 'signin.html';
} else {
	require_once 'header.php';
	require_once 'index.html';
}

require_once 'footer.php';
?>
