<?php
class Venues extends Controller {
	function index() {
    $search = array();
    if (!empty($this->form['venue-search']))
      $search[] = 'name LIKE %' . str_replace(' ', '\"%', $this->form['venue-search']) . '%\"';
		$this->entries = $this->db_query_all(null, null, $search);
    $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
    $this->pages = ceil($this->db_count() / ENTRIES_PER_PAGE);
		$this->render();
	}
}
?>
