<?php
class User extends Controller {
	function index() {
		$this->entries = $this->query('SELECT * FROM users');
		$this->render();
	}
	function view() {
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
