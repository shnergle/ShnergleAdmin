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
  function db_count($table = null, $where = null) {
		if (empty($table))
			$table = $this->slug;
    if (!empty($where)) {
      $condition = ' WHERE ';
      if (is_string($where))
        $condition .= $where;
      else
        $condition .= implode(' AND ', $where);
    } else
      $condition = '';
		return $this->db_result('SELECT COUNT(*) as cnt FROM ' . $table . $condition)[0]['cnt'];
  }
  
  function db_columns($table = null) {
		if (empty($table))
			$table = $this->slug;
		return $this->db_result('exec sp_columns @table_name = [' . $table . ']');
  }
	function db_query_all($page = null, $table = null, $where = null, $order_by = null, $group_by = null, $fields = null) {
    if (empty($page))
      $page = empty($this->params['page']) ? 1 : $this->params['page'];
		if (empty($table))
			$table = $this->slug;
    $first_table = explode(', ', $table)[0];
    if (!empty($where)) {
      $condition = ' WHERE ';
      if (is_string($where))
        $condition .= $where;
      else
        $condition .= implode(' AND ', $where);
    } else
      $condition = '';
		if (empty($order_by))
			$order_by = $first_table . '.id';
		if (empty($group_by))
			$group_by = '';
    else
      $group_by = ' GROUP BY ' . $group_by;
		if (empty($fields))
			$fields = '*';
		return $this->db_result('SELECT ' . $fields . ' FROM ' . $table . $condition . $group_by .
                            ' ORDER BY ' . $order_by . ' OFFSET ' .
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
			$values = $this->form;
		if (empty($table))
            $table = $this->slug;
        
        
        $columns = array_keys($values);
		$placeholders = '?' . str_repeat(', ?', count($columns) - 1);
		$columns = '[' . implode('], [', $columns) . ']';
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
			$values = $this->form;
		if (empty($id))
			$id = $this->params['id'];
		if (empty($table))
			$table = $this->slug;
		$set = array();
		foreach (array_keys($values) as $clause)
			$set[] = $clause . ' = ?';
		$set = implode(', ', $set);
		$placeholders = '?' . str_repeat(', ?', count($set) - 1);
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
    $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
    $this->pages = ceil($this->db_count() / ENTRIES_PER_PAGE);
		$this->render();
	}
	function view() {
		$this->entry = $this->db_query_one();
		$this->render();
	}
	function add() {
        $this->columns = $this->db_columns();
        unset($this->columns[0]);        
		$this->render('edit');
	}
	function add_action() {
		$id = $this->db_insert();
		$this->redirect(null, 'view', array('id' => $id));
	}
	function edit() {
		$this->entry = $this->db_query_one();
        unset($this->entry['id']);
        $this->render();
	}
	function edit_action() {
		$this->db_update();
		$this->redirect(null, 'view', array('id' => $this->params['id']));
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
