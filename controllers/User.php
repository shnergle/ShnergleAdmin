<?php
class User extends Controller {
	function index() {
		$this->entries = $this->query('SELECT * FROM users');
		$this->render();
	}
	function view() {
		$this->entry = $this->query('SELECT * FROM users WHERE id = \'' .
		                            $this->params['id'] . '\'');
		$this->render();
	}
	function add() {
		$this->render();
	}
	function edit() {
		$this->render();
	}
	function delete() {
		$this->render();
	}
}
?>
