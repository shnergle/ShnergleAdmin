<?php
require_once 'Mail.php';

class VenueManagers extends Controller {
	function edit() {
		$this->entry = $this->db_query_one(null, null, array('user_id = ' . $this->params['user_id'], 'venue_id = ' . $this->params['venue_id']));
    $this->render();
	}
}
?>
