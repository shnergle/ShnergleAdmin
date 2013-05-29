<?php
class Controller {
	function __construct($controller, $action, $smarty, $sql) {
		$this->controller = $controller;
		$this->action = $action;
		$this->smarty = $smarty;
		$this->sql = $sql;
		$this->params = $_GET;
		$this->form = $_POST;
		$this->session = &$_SESSION;
		$this->template = '../default.tpl';
		$this->auth = empty($_SESSION['auth']) ? false : true;
		if (!empty($this->session['flash'])) {
			$this->flash = $this->session['flash'];
			unset($this->session['flash']);
			if (!empty($this->session['flashtype'])) {
				$this->flashtype = $this->session['flashtype'];
				$this->session['flashtype'];
			}
		}
	}
	function redirect($controller = '', $action = '') {
		if (empty($controller))
			$controller = $this->controller;
		header('Location: /?controller=' . $controller . '&action=' . $action);
	}
	function flash($message, $type = null) {
		$this->session['flash'] = $message;
		$this->session['flashtype'] = $type;
	}
	function render($name = null) {
		$this->smarty->assign(get_object_vars($this));
		if (empty($name))
			$name = $this->action;
		$this->smarty->display(strtolower($this->controller) . '/' . $name .
		                       '.tpl');
	}
	function query($query) {
		if (($qry = sqlsrv_query($this->sql, $query)) === false)
		    die(print_r(sqlsrv_errors(), true));
		$result = array();
		while ($row = sqlsrv_fetch_array($qry, SQLSRV_FETCH_ASSOC))
		      $result[] = $row;
		sqlsrv_free_stmt($qry);
		return $result;
	}
}
?>
