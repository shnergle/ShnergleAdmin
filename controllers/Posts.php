<?php
class Posts extends Controller {
	function index() {
		$this->entries = $this->db_query_all();
    foreach ($this->entries as &$entry) {
      $entry['post_shares'] =  $this->db_count('post_shares', array('post_id = ' . $entry['id']));
      $entry['post_views'] =  $this->db_count('post_views', array('post_id = ' . $entry['id']));
      $entry['post_likes'] =  $this->db_count('post_likes', array('post_id = ' . $entry['id']));
      $entry['post_reports'] =  $this->db_count('post_reports', array('post_id = ' . $entry['id']));
    }
    $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
    $this->pages = ceil($this->db_count() / ENTRIES_PER_PAGE);
		$this->render();
	}
}
?>