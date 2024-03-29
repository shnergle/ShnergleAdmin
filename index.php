<?php
date_default_timezone_set('UTC');
spl_autoload_register(function ($class) {
	$file = 'controllers/' . $class . '.php';
	if (file_exists($file))
    	require_once $file;
});

session_start();

require_once 'configs/config.php';

$coninfo = array('Database' => DB_DB, 'UID' => DB_USER, 'PWD' => DB_PASS);
$sql = sqlsrv_connect(DB_SERVER, $coninfo);
if ($sql === false)
    die(print_r(sqlsrv_errors(), true));

define('SMARTY_DIR', str_replace("\\", "/", getcwd()) . '/smarty/');
require_once SMARTY_DIR . 'Smarty.class.php';
$smarty = new Smarty();

$gcontroller = empty($_GET['controller']) ? 'main' : $_GET['controller'];
$gaction = empty($_GET['action']) ? 'index' : $_GET['action'];

if (empty($_SESSION['auth']) && $gcontroller != 'main' &&
	($gaction != 'index' || $gaction != 'login')) {
		$gcontroller = 'main';
		$gaction = 'noAuth';
}

$controller = $realcontroller = preg_replace_callback('/_([a-z])/', function ($match) {
    return strtoupper($match[1]);
}, ucfirst($gcontroller));
if (!class_exists($controller))
	$controller = 'Controller';
$controller = new $controller($realcontroller, $gcontroller, $gaction, $smarty, $sql);
$controller->$gaction();

sqlsrv_close($sql);
?>
