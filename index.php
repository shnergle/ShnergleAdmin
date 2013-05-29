<?php
date_default_timezone_set('UTC');
spl_autoload_register(function ($class) {
	$file = 'controllers/' . $class . '.php';
	if (file_exists($file))
    	require_once $file;
});

session_start();

define('SMARTY_DIR', str_replace("\\", "/", getcwd()) . '/smarty/');
require_once SMARTY_DIR . 'Smarty.class.php';
$smarty = new Smarty();

$gcontroller = empty($_GET['controller']) ? 'main' : $_GET['controller'];
$gaction = empty($_GET['action']) ? 'index' : $_GET['action'];
if (empty($_SESSION['auth']) && ($gcontroller != 'main' && ($gaction != 'index' || $gaction != 'login'))) {
	$gcontroller = 'main';
	$gaction = 'noAuth';
}
$controller = ucfirst($gcontroller);
$controller = new $controller($gcontroller, $gaction, $_GET, $_POST, $_SESSION, $smarty);
$controller->$gaction();
?>
