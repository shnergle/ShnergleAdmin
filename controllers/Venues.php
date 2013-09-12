<?php
require_once 'Mail.php';

class Venues extends Controller {
	function index() {
    $search = array();
    if (!empty($this->params['venue-id']))
      $search[] = 'id = ' . $this->params['venue-id'];
    if (!empty($this->params['venue-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->params['venue-search']) . '%\'';
    if (!empty($this->params['staff-search']))
      $search[] = 'name LIKE \'%' . str_replace(' ', '%', $this->params['staff-search']) . '%\'';
    if (!empty($this->params['type-search']))
      if ($this->params['type-search'] == 'to-auth') {
        $search[] = 'email_verified = 1';
        $search[] = 'verified = 0';
      } elseif ($this->params['type-search'] == 'to-veri') {
        $search[] = 'email_verified = 0';
        $search[] = 'official = 1';
      } 
    if (!empty($search)) {
    	$this->entries = $this->db_query_all(null, null, $search);
      foreach ($this->entries as &$entry) {
        $entry['managers'] = $this->db_query_all(null, 'venue_managers, users', array('venue_id = ' . $entry['id'], 'venue_managers.user_id = users.id'));
        $entry['staff'] = $this->db_query_all(null, 'venue_staff, users', array('venue_id = ' . $entry['id'], 'venue_staff.user_id = users.id'));
      }
      $categories = $this->db_query_all(null, 'venue_categories');
      $this->categories = array();
      foreach ($categories as $category)
        $this->categories[$category['id']] = $category['type'];
      $this->page = empty($this->params['page']) ? 1 : $this->params['page'];
      $this->pages = 1;
    } else {
      $this->recentVenues = $this->db_query_all(null, 'venues, posts', array('posts.venue_id = venues.id'), 'last_activity DESC', 'venues.id, name', 'venues.id, name, MAX(time) as last_activity');
    }
    echo smarty_modifier_date_format($this->recentVenues[0]['last_activity'],"%d/%m/%Y %H:%i:%s");
    $this->search = !empty($search);
		$this->render();
	}
  function auth() {
    $this->render();
  }
  function auth_action() {
    $this->db_update(array('verified' => 1, 'authenticated' => time()));
    $venue = $this->db_query_one();
    $creator = $this->db_query_one($venue['creator'], 'users');
    $subject = 'Congratulations! [VenueName] is now officially on Shnergle!';
    $message = <<<'END'
Hi [Name],

Thanks very much for verifying your ownership of [VenueName]; we have now made [VenueName] official on Shnergle.

You can now:
- Promote [VenueName] by taking regular photos to help the public see what is going on right now
- Create standing promotions to motivate your customers to promote [VenueName] for you with photo check-ins
- Create special time sensitive/limited redemption promotions to manage stock or attract business
- Manage staff permissions through the staff button (all staff members need to be on Shnergle)
- See how many of the public have RSVP'd to come to [VenueName]
- Write a descriptive section to give the public more information about [VenueName]
- Manage your brand with the power to hide inappropriate content yourself

If you are wondering how to do anything, check out our YouTube channel (http://www.youtube.com/user/ShnergleVids) for short video tutorials.

If you notice anything incorrect about [VenueName], please tweet us @ShnergleHelp or drop us a line at contact@shnergle.com and we'll get it fixed.

We hope you enjoy Shnergle and it helps your business; we are always looking for ways to improve the app so please feel free to drop us a line at contact@shnergle.com.

Cheers!

Team Shnergle
END;
    $subject = str_replace('[VenueName]', $venue['name'], $subject);
    $message = str_replace('[Name]', $creator['forename'] . ' ' . $creator['surname'], $message);
    $message = str_replace('[VenueName]', $venue['name'], $message);
    $mail = Mail::factory('smtp', array('host' => SMTP_HOST, 'port' => SMTP_PORT, 'auth' => true, 'username' => SMTP_USER, 'password' => SMTP_PASS));
    $mail = $mail->send($venue['email'], array('From' => SMTP_MAIL, 'To' => $venue['email'], 'Subject' => $subject), $message);
    if (PEAR::isError($mail))
      die($mail->getMessage());
		$this->redirect(null, 'view', array('id' => $this->params['id']));
  }
  function deauth() {
    $this->render();
  }
  function deauth_action() {
    $this->db_update(array('official' => 0, 'verified' => 0, 'authenticated' => null));
		$this->redirect(null, 'view', array('id' => $this->params['id']));
  }
}
?>
