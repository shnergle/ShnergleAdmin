<?php
class Promotions extends Controller {
	function index() {
		$this->entries = $this->db_query_all();
    foreach ($this->entries as &$entry) {
      $entry['promotion_redemptions'] =  $this->db_count('promotion_redemptions', array('promotion_id = ' . $entry['id']));
    }
    $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
    $this->pages = ceil($this->db_count() / ENTRIES_PER_PAGE);
		$this->render();
	}
}
?>