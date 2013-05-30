<?php
class Controller {
	function __construct($controller, $slug, $action, $smarty, $sql) {
		$this->controller = $controller;
    $this->slug = $slug;
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
			$controller = $this->slug;
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
		$dir = $this->slug;
		$file = '/' . $name . '.tpl';
		if (!file_exists('templates/' . $dir . $file))
			$dir = 'generic';
		$this->smarty->display($dir . $file);
	}
	function db_query($query, $params = null) {
		if (($qry = sqlsrv_query($this->sql, $query, $params)) === false)
		    die("Query:\n" . $query .
				"\n---\nParameters:\n" . print_r($params) .
				"\n---\nErrors:\n" . print_r(sqlsrv_errors(), true));
		return $qry;
	}
	function db_result($query) {
		$qry = $this->db_query($query);
		$result = array();
		while ($row = sqlsrv_fetch_array($qry, SQLSRV_FETCH_ASSOC))
		      $result[] = $row;
		sqlsrv_free_stmt($qry);
		return $result;
	}
  function db_count($table = null) {
		if (empty($table))
			$table = $this->slug;
		return $this->db_result('SELECT COUNT(*) as cnt FROM ' . $table)[0]['cnt'];
  }
	function db_query_all($page = null, $table = null) {
    if (empty($page))
      $page = empty($params['page']) ? 1 : $params['page'];
		if (empty($table))
			$table = $this->slug;
		return $this->db_result('SELECT * FROM ' . $table . ' ORDER BY id OFFSET ' .
                            ($page - 1) * ENTRIES_PER_PAGE .
                            ' ROWS FETCH NEXT ' . ENTRIES_PER_PAGE .
                            ' ROWS ONLY');
	}
	function db_query_one($id = null, $table = null) {
		if (empty($id))
			$id = $this->params['id'];
		if (empty($table))
			$table = $this->slug;
		return $this->db_result('SELECT TOP(1) * FROM ' . $table .
		                        ' WHERE id = \'' . $id . '\'')[0];
	}
	function db_insert($values = null, $table = null) {
		if (empty($values))
			$values = $form;
		if (empty($table))
			$table = $this->slug;
		$columns = array_keys($values);
		$placeholders = '?' . str_repeat(', ?', count($columns) - 1);
		$fields = array_values($values);
		$qry = $this->db_query('INSERT INTO ' . $table . ' (' . $columns .
			                     ') VALUES (' . $placeholders . '); ' .
							             'SELECT SCOPE_IDENTITY()', $fields);
		sqlsrv_next_result($qry); 
		sqlsrv_fetch($qry); 
		return sqlsrv_get_field($qry, 0); 
	}
	function db_update($values = null, $id = null, $table = null) {
		if (empty($values))
			$values = $form;
		if (empty($id))
			$id = $this->params['id'];
		if (empty($table))
			$table = $this->slug;
		$set = array();
		foreach (array_keys($values) as $clause)
			$set[] = $clause . ' = ?';
		$set = implode(', ', $set);
		$placeholders = '?' . str_repeat(', ?', count($columns) - 1);
		$fields = array_values($values);
		$qry = $this->db_query('UPDATE ' . $table . ' SET ' . $set .
			                   ' WHERE id = \'' . $id . '\'', $fields);
	}
	function db_delete($id = null, $table = null) {
		if (empty($id))
			$id = $this->params['id'];
		if (empty($table))
			$table = $this->slug;
		$this->db_query('DELETE FROM ' . $table .
			            ' WHERE id = \'' . $id . '\'');
	}
	function index() {
		$this->entries = $this->db_query_all();
    $this->pages = ceil($this->db_count() / ENTRIES_PER_PAGE);
		$this->render();
	}
	function view() {
		$this->entry = $this->db_query_one();
		$this->render();
	}
	function add() {
    $this->columns = array_keys($this->db_query_all()[0]);
		$this->render('edit');
	}
	function add_action() {
		$id = $this->db_insert();
		$this->redirect(null, 'view', array('id' => $id));
	}
	function edit() {
		$this->entry = $this->db_query_one();
		$this->render();
	}
	function edit_action() {
		$this->db_update();
		$this->redirect(null, 'view', array('id' => $this->id));
	}
	function delete() {
		$this->render();
	}
	function delete_action() {
		$this->db_delete();
		$this->flash('<strong>Entry deleted!</strong>', 'success');
		$this->redirect();
	}
}
?>
