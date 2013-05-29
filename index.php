<?php
function __autoload($class_name) {
    require_once 'controllers/' . $class_name . '.php';
}
define('SMARTY_DIR', str_replace("\\", "/", getcwd()) . '/smarty/');
require_once SMARTY_DIR . 'Smarty.class.php';
$smarty = new Smarty();
$gcontroller = empty($_GET['controller'] ? 'main' : $_GET['controller'];
$gaction = empty($_GET['controller'] ? 'index' : $_GET['action'];
$controller = ucfirst($gcontroller);
$controller = new $controller($_GET, $smarty);
$controller->$gaction();
?>
