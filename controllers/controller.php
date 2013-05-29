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
	function redirect($controller = '', $action = '', $args) {
		if (empty($controller))
			$controller = $this->controller;
		$location = 'Location: /?controller=' . $controller .
		            '&action=' . $action;
		foreach ($args as $key => $value)
			$location .= '&' . $key . '=' . $value;
		header($location);
	}
	function flash($message, $type = null) {
		$this->session['flash'] = $message;
		$this->session['flashtype'] = $type;
	}
	function render($name = null) {
		$this->smarty->assign(get_object_vars($this));
		if (empty($name))
			$name = $this->action;
		$dir = strtolower($this->controller);
		$file = '/' . $name . '.tpl';
		if (!file_exists($dir . $file))
			$dir = 'generic';
		$this->smarty->display($dir . $file);
	}
	function query($query, $params = null) {
		if (($qry = sqlsrv_query($this->sql, $query, $params)) === false)
		    die(print_r(sqlsrv_errors(), true));
		return $qry;
	}
	function result($query) {
		$qry = $this->query($query);
		$result = array();
		while ($row = sqlsrv_fetch_array($qry, SQLSRV_FETCH_ASSOC))
		      $result[] = $row;
		sqlsrv_free_stmt($qry);
		return $result;
	}
	function query_all($table = null) {
		if (empty($table))
			$table = strtolower($this->controller);
		return $this->result('SELECT * FROM ' . $table);
	}
	function query_one($id = null, $table = null) {
		if (empty($id))
			$table = strtolower($this->id);
		if (empty($table))
			$table = strtolower($this->controller);
		return $this->result('SELECT TOP(1) * FROM ' . $table .
		                     ' WHERE id = \'' . $id . '\'')[0];
	}
	function insert($values = null, $table = null) {
		if (empty($values))
			$values = $form;
		if (empty($table))
			$table = strtolower($this->controller);
		$columns = array_keys($values);
		$placeholders = '?' . str_repeat(', ?', count($columns) - 1);
		$fields = array_values($values);
		$qry = $this->query('INSERT INTO ' . $table . ' (' . $columns .
			                ') VALUES (' . $placeholders . '); ' .
							'SELECT SCOPE_IDENTITY()', $fields);
		sqlsrv_next_result($qry); 
		sqlsrv_fetch($qry); 
		return sqlsrv_get_field($qry, 0); 
	}
	function update($values = null, $id = null, $table = null) {
		if (empty($values))
			$values = $form;
		if (empty($id))
			$table = strtolower($this->id);
		if (empty($table))
			$table = strtolower($this->controller);
		$set = array();
		foreach (array_keys($values) as $clause)
			$set[] = $clause . ' = ?';
		$set = implode(', ', $set);
		$placeholders = '?' . str_repeat(', ?', count($columns) - 1);
		$fields = array_values($values);
		$qry = $this->query('UPDATE ' . $table . ' SET ' . $set .
			                ' WHERE id = \'' . $id . '\'', $fields);
	}
	function delete($id = null, $table = null) {
		if (empty($id))
			$table = strtolower($this->id);
		if (empty($table))
			$table = strtolower($this->controller);
		$this->query('DELETE FROM ' . $table . ' WHERE id = \'' . $id . '\'');
	}
	function index() {
		$this->entries = $this->query_all();
		$this->render();
	}
	function view() {
		$this->entry = $this->query_one();
		$this->render();
	}
	function add() {
		$this->render('edit');
	}
	function add_action() {
		$id = $this->insert();
		$this->redirect(null, 'view', array('id' => $id));
	}
	function edit() {
		$this->entry = $this->query_one();
		$this->render();
	}
	function edit_action() {
		$this->update();
		$this->redirect(null, 'view', array('id' => $this->id));
	}
	function delete() {
		$this->render();
	}
	function delete_action() {
		$this->delete();
		$this->redirect();
	}
}
?>
