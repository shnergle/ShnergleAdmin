<?php
class Main extends Controller {
	function index() {
		if ($this->auth)
			$this->dashboard();
		else
			$this->smarty->display('main/index.tpl');
	}
	function noAuth() {
		$this->redirect();
	}
	function login() {
		if ($this->form['username'] == 'shnergle' &&
			$this->form['password'] == '$Hnergle1')
				$this->session['auth'] = true;
		else
			$this->flash('<strong>Wrong credentials!</strong>', 'danger');
		$this->redirect();
	}
	function logout() {
		session_unset();
		session_destroy();
		$this->redirect();
	}
	function dashboard() {
		$this->smarty->display('main/dashboard.tpl');
	}
}
?>
