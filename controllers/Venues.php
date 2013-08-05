<?php
class Venues extends Controller {
	function index() {
    $search = array();
    if (!empty($this->params['venue-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->params['venue-search']) . '%\'';
    if (!empty($this->params['staff-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->params['staff-search']) . '%\'';
    if (!empty($this->params['type-search']))
      if ($this->params['type-search'] == 'to-auth') {
        $search[] = 'email_verified = 1';
        $search[] = 'authenticated IN (0, null)';
      } elseif ($this->params['type-search'] == 'to-veri') {
        $search[] = 'email_verified = 0';
        $search[] = 'official = 1';
      } 
    if (!empty($search)) {
    	$this->entries = $this->db_query_all(null, null, $search);
      $categories = $this->db_query_all(null, 'venue_categories');
      $this->categories = array();
      foreach ($categories as $category)
        $this->categories[$category['id']] = $category['type'];
      $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
      $this->pages = 1;
    }
    $this->search = !empty($search);
		$this->render();
	}
  function auth() {
    $this->render();
  }
  function auth_action() {
    $this->db_update(array('verified' => 1, 'authenticated' => time()));
		$this->redirect(null, 'view', array('id' => $this->params['id']));
  }
  function deauth() {
    $this->render();
  }
  function deauth_action() {
    $this->db_update(array('offical' => 0, 'verified' => 0, 'authenticated' => null));
		$this->redirect(null, 'view', array('id' => $this->params['id']));
  }
}
?>
