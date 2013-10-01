<?php
class Users extends Controller {
  function delete_action() {
		$this->db_update(array('facebook_id' => '',
                           'facebook' => '',
                           'twitter' => '',
                           'forename' => '',
                           'surname' => '',
                           'email' => ''));
		$this->flash('<strong>Entry deleted (cleared name, email and details of facebook and twitter)!</strong>', 'success');
		$this->redirect();
	}
}
?>