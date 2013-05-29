<?php
date_default_timezone_set('UTC');
spl_autoload_register(function ($class) {
	$file = 'controllers/' . $class . '.php';
	if (file_exists($file))
    	require_once $file;
});

session_start();

$sql = sqlsrv_connect('r7g4obkx8p.database.windows.net:1433', 'shnergle',
                      '$Hnergle1');
if (!$mssql)
	die('Database Connection Error!');
sqlsrv_select_db('shnergle-db', $sql);

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

$controller = ucfirst($gcontroller);
$controller = new $controller($gcontroller, $gaction, $smarty, $sql);
$controller->$gaction();

sqlsrv_close($sql);
?>
