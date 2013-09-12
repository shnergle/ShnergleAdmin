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
    $this->iphone_models_h = array('iPhone1,1' => 'iPhone',
                                   'iPhone1,2' => 'iPhone 3G',
                                   'iPhone2,1' => 'iPhone 3GS',
                                   'iPhone3,1' => 'iPhone 4 GSM',
                                   'iPhone3,2' => 'iPhone 4 GSM (A)',
                                   'iPhone3,3' => 'iPhone 4 CDMA',
                                   'iPhone4,1' => 'iPhone 4S',
                                   'iPhone5,1' => 'iPhone 5 GSM',
                                   'iPhone5,2' => 'iPhone 5 Global',
                                   'iPad1,1' => 'iPad',
                                   'iPad2,1' => 'iPad 2 WiFi',
                                   'iPad2,2' => 'iPad 2 GSM',
                                   'iPad2,3' => 'iPad 2 CDMA',
                                   'iPad2,4' => 'iPad 2 WiFi (A)',
                                   'iPad2,5' => 'iPad mini WiFi',
                                   'iPad2,6' => 'iPad mini GSM',
                                   'iPad2,7' => 'iPad mini CDMA',
                                   'iPad3,1' => 'iPad 3 WiFi',
                                   'iPad3,2' => 'iPad 3 CDMA',
                                   'iPad3,3' => 'iPad 3 Global',
                                   'iPad3,4' => 'iPad WiFi',
                                   'iPad3,5' => 'iPad GSM',
                                   'iPad3,6' => 'iPad Global',
                                   'iPod1,1' => 'iPod touch 1G',
                                   'iPod2,1' => 'iPod touch 2G',
                                   'iPod3,1' => 'iPod touch 3G',
                                   'iPod4,1' => 'iPod touch 4G',
                                   'iPod5,1' => 'iPod touch 5G',
                                   '' => '');
    $this->ios_versions = $this->db_result('SELECT ios_version, COUNT(id) AS no FROM users GROUP BY ios_version');
    $this->languages = $this->db_result('SELECT language, COUNT(id) AS no FROM users GROUP BY language');
    $this->countries = $this->db_result('SELECT country, COUNT(id) AS no FROM users GROUP BY country');
    $this->gender = $this->db_result('SELECT gender, COUNT(id) AS no FROM users GROUP BY gender');
    $this->gender_h = array('m' => 'Male',
                            'f' => 'Female',
                            '' => '');
    $this->waitingVenuesEmail = $this->db_query_all(null, 'venues', array('email_verified = 0', 'official = 1'));
    $this->waitingVenuesAuth = $this->db_query_all(null, 'venues', array('email_verified = 1', 'authenticated IN (0, null)'));
    $this->waitingVenues = max(count($this->waitingVenuesEmail), count($this->waitingVenuesAuth));
		$this->render('dashboard');
	}
}
?>
