<?php
class Controller {
	function __construct($controller, $action, $params, $form, &$session, $smarty) {
		$this->controller = $controller;
		$this->action = $action;
		$this->params = $params;
		$this->form = $form;
		$this->session = &$session;
		$this->smarty = $smarty;
		$this->smarty->assign('controller', $this->controller);
		$this->smarty->assign('action', $this->action);
		$this->auth = empty($_SESSION['auth']) ? false : true;
		if (!empty($this->session['flash'])) {
			$this->smarty->assign('flash', $this->session['flash']);
			unset($this->session['flash']);
			if (!empty($this->session['flashtype'])) {
				$this->smarty->assign('flashtype', $this->session['flashtype']);
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
}
?>
