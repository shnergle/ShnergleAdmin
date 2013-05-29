<?php
class Controller {
	function __construct($controller, $action, $smarty, $mssql) {
		$this->controller = $controller;
		$this->action = $action;
		$this->smarty = $smarty;
		$this->mssql = $mssql;
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
		$this->smarty->display($this->controller . '/' . $name . '.tpl');
	}
}
?>
