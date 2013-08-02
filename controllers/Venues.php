<?php
class Venues extends Controller {
	function index() {
    $search = array();
    if (!empty($this->form['venue-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->form['venue-search']) . '%\'';
    if (!empty($this->form['type-search']))
      if ($this->form['type-search'] == 'to-auth') {
        $search[] = 'email_verified = 1';
        $search[] = 'authenticated IN (0, null)';
      } elseif ($this->form['type-search'] == 'to-veri') {
        $search[] = 'email_verified = 0';
        $search[] = 'official = 1';
      } 
		$this->entries = $this->db_query_all(null, null, $search);
    $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
    $this->pages = ceil(count($this->entries) / ENTRIES_PER_PAGE);
		$this->render();
	}
}
?>
