<?php
class Main extends Controller {
	function index() {
		if ($this->auth)
			$this->dashboard();
		else
			$this->render();
	}
	function noAuth() {
		$this->redirect();
	}
	function login() {
		if ($this->form['username'] == 'shnergle' &&
			$this->form['password'] == '$Hnergle1')
				$this->session['auth'] = true;
		else
			$this->flash('<strong>Wrong credentials!</strong>', 'danger');
		$this->redirect();
	}
	function logout() {
		session_unset();
		session_destroy();
		$this->redirect();
	}
	function dashboard() {
    $this->counts = array('Media' => $this->db_count('media'),
                          'Posts' => $this->db_count('posts'),
                          'PostLikes' => $this->db_count('post_likes'),
                          'PostReports' => $this->db_count('post_reports'),
                          'PostShares' => $this->db_count('post_shares'),
                          'PostViews' => $this->db_count('post_views'),
                          'Promotions' => $this->db_count('promotions'),
                          'PromotionRedemptions' => $this->db_count('promotion_redemptions'),
                          'Users' => $this->db_count('users'),
                          'UserSearches' => $this->db_count('user_searches'),
                          'Venues' => $this->db_count('venues'),
                          'VenueCategories' => $this->db_count('venue_categories'),
                          'VenueFollowers' => $this->db_count('venue_followers'),
                          'VenueLoads' => $this->db_count('venue_loads'),
                          'VenueRsvps' => $this->db_count('venue_rsvps'),
                          'VenueShares' => $this->db_count('venue_shares'),
                          'VenueViews' => $this->db_count('venue_views'));
    $this->app_versions = $this->db_result('SELECT app_version, COUNT(id) AS no FROM users GROUP BY app_version');
    $this->iphone_models = $this->db_result('SELECT iphone_model, COUNT(id) AS no FROM users GROUP BY iphone_model');
    $this->ios_versions = $this->db_result('SELECT ios_version, COUNT(id) AS no FROM users GROUP BY ios_version');
		$this->render('dashboard');
	}
}
?>
