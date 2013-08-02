<?php
class Venues extends Controller {
	function index() {
    $search = array();
    if (!empty($this->form['venue-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->form['venue-search']) . '%\'';
    if (!empty($this->form['staff-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->form['staff-search']) . '%\'';
    if (!empty($this->form['type-search']))
      if ($this->form['type-search'] == 'to-auth') {
        $search[] = 'email_verified = 1';
        $search[] = 'authenticated IN (0, null)';
      } elseif ($this->form['type-search'] == 'to-veri') {
        $search[] = 'email_verified = 0';
        $search[] = 'official = 1';
      } 
    if (!empty($search)) {
    	$this->entries = $this->db_query_all(null, null, $search);
      $categories = $this->db_query_all(null, 'venue_categories');
      $this->categories = array();
      foreach ($categories as $category)
        $this->categories[$category['id']] = $category['name'];
      $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
      $this->pages = 1;
    }
    $this->search = !empty($search);
		$this->render();
	}
}
?>
