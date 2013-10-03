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
    $this->counts = array('Posts' => $this->db_count('posts'),
                          'PostLikes' => $this->db_count('post_likes'),
                          'PostReports' => $this->db_count('post_reports'),
                          'PostShares' => $this->db_count('post_shares'),
                          'PostViews' => $this->db_count('post_views'),
                          'Promotions' => $this->db_count('promotions'),
                          'PromotionRedemptions' => $this->db_count('promotion_redemptions'),
                          'Users' => $this->db_count('users'),
                          'UserSearches' => $this->db_count('user_searches'),
                          'Venues' => $this->db_count('venues'),
                          'Venues (Official)' => $this->db_count('venues', array('official = 1')),
                          'Venues (Authenticated)' => $this->db_count('venues', array('verified = 1')),
                          'VenueFollowers' => $this->db_count('venue_followers'),
                          'VenueLoads' => $this->db_count('venue_loads'),
                          'VenueShares' => $this->db_count('venue_shares'),
                          'VenueViews' => $this->db_count('venue_views'));
    $this->app_versions = $this->db_result('SELECT app_version, COUNT(id) AS no FROM users GROUP BY app_version');
    $iphone_models = $this->db_result('SELECT iphone_model, COUNT(id) AS no FROM users GROUP BY iphone_model');
    $this->iphone_models = array();
    $this->iphone_models_h = array('iPhone1,1' => 'iPhone',
                                   'iPhone1,2' => 'iPhone 3G',
                                   'iPhone2,1' => 'iPhone 3GS',
                                   'iPhone3,1' => 'iPhone 4',
                                   'iPhone3,2' => 'iPhone 4',
                                   'iPhone3,3' => 'iPhone 4',
                                   'iPhone4,1' => 'iPhone 4S',
                                   'iPhone5,1' => 'iPhone 5',
                                   'iPhone5,2' => 'iPhone 5',
                                   'iPhone5,3' => 'iPhone 5c',
                                   'iPhone5,4' => 'iPhone 5c',
                                   'iPhone6,1' => 'iPhone 5s',
                                   'iPhone6,2' => 'iPhone 5s',
                                   'iPad1,1' => 'iPad',
                                   'iPad2,1' => 'iPad 2',
                                   'iPad2,2' => 'iPad 2',
                                   'iPad2,3' => 'iPad 2',
                                   'iPad2,4' => 'iPad 2',
                                   'iPad2,5' => 'iPad mini',
                                   'iPad2,6' => 'iPad mini',
                                   'iPad2,7' => 'iPad mini',
                                   'iPad3,1' => 'iPad 3',
                                   'iPad3,2' => 'iPad 3',
                                   'iPad3,3' => 'iPad 3',
                                   'iPad3,4' => 'iPad 4',
                                   'iPad3,5' => 'iPad 4',
                                   'iPad3,6' => 'iPad 4',
                                   'iPod1,1' => 'iPod touch 1G',
                                   'iPod2,1' => 'iPod touch 2G',
                                   'iPod3,1' => 'iPod touch 3G',
                                   'iPod4,1' => 'iPod touch 4G',
                                   'iPod5,1' => 'iPod touch 5G',
                                   'i386' => 'Simulator',
                                   'x86_64' => 'Simulator',
                                   '' => '');
    foreach ($iphone_models as $iphone_model) {
      if (isset($this->iphone_models[$this->iphone_models_h[$iphone_model['iphone_model']]])) {
        $this->iphone_models[$this->iphone_models_h[$iphone_model['iphone_model']]] += $iphone_model['no'];
      } else {
        $this->iphone_models[$this->iphone_models_h[$iphone_model['iphone_model']]] = $iphone_model['no'];
      }
    }
    $ios_versions = $this->db_result('SELECT ios_version, COUNT(id) AS no FROM users GROUP BY ios_version');
    $this->ios_versions = array();
    foreach ($ios_versions as $version) {
      if ($version['ios_version']) {
        $short_version = explode('.', $version['ios_version']);
        $short_version = $short_version[0].'.'.$short_version[1];
      } else {
        $short_version = '';
      }
      if (isset($this->ios_versions[$short_version])) {
        $this->ios_versions[$short_version] += $version['no'];
      } else {
        $this->ios_versions[$short_version] = $version['no'];
      }
    }
    $this->languages = $this->db_result('SELECT language, COUNT(id) AS no FROM users GROUP BY language');
    $this->languages_h = array('af_ZA' => 'Afrikaans',
                               'az_AZ' => 'Azərbaycan dili',
                               'id_ID' => 'Bahasa Indonesia',
                               'ms_MY' => 'Bahasa Melayu',
                               'bs_BA' => 'Bosanski',
                               'ca_ES' => 'Català',
                               'cs_CZ' => 'Čeština',
                               'cy_GB' => 'Cymraeg',
                               'da_DK' => 'Dansk',
                               'de_DE' => 'Deutsch',
                               'et_EE' => 'Eesti',
                               'en_PI' => 'English (Pirate)',
                               'en_GB' => 'English (UK)',
                               'en_UD' => 'English (Upside Down)',
                               'en_US' => 'English (US)',
                               'es_LA' => 'Español',
                               'es_ES' => 'Español (España)',
                               'eo_EO' => 'Esperanto',
                               'eu_ES' => 'Euskara',
                               'tl_PH' => 'Filipino',
                               'fo_FO' => 'Føroyskt',
                               'fr_CA' => 'Français (Canada)',
                               'fr_FR' => 'Français (France)',
                               'fy_NL' => 'Frysk',
                               'ga_IE' => 'Gaeilge',
                               'gl_ES' => 'Galego',
                               'hr_HR' => 'Hrvatski',
                               'is_IS' => 'Íslenska',
                               'it_IT' => 'Italiano',
                               'sw_KE' => 'Kiswahili',
                               'ku_TR' => 'Kurdî',
                               'lv_LV' => 'Latviešu',
                               'fb_LT' => 'Leet Speak',
                               'lt_LT' => 'Lietuvių',
                               'la_VA' => 'lingua latina',
                               'hu_HU' => 'Magyar',
                               'nl_NL' => 'Nederlands',
                               'nb_NO' => 'Norsk (bokmål)',
                               'nn_NO' => 'Norsk (nynorsk)',
                               'pl_PL' => 'Polski',
                               'pt_BR' => 'Português (Brasil)',
                               'pt_PT' => 'Português (Portugal)',
                               'ro_RO' => 'Română',
                               'sq_AL' => 'Shqip',
                               'sk_SK' => 'Slovenčina',
                               'sl_SI' => 'Slovenščina',
                               'fi_FI' => 'Suomi',
                               'sv_SE' => 'Svenska',
                               'vi_VN' => 'Tiếng Việt',
                               'tr_TR' => 'Türkçe',
                               'el_GR' => 'Ελληνικά',
                               'be_BY' => 'Беларуская',
                               'bg_BG' => 'Български',
                               'mk_MK' => 'Македонски',
                               'ru_RU' => 'Русский',
                               'sr_RS' => 'Српски',
                               'uk_UA' => 'Українська',
                               'ka_GE' => 'ქართული',
                               'hy_AM' => 'Հայերեն',
                               'he_IL' => 'עברית',
                               'ar_AR' => 'العربية',
                               'ps_AF' => 'پښتو',
                               'fa_IR' => 'فارسی',
                               'ne_NP' => 'नेपाली',
                               'hi_IN' => 'हिन्दी',
                               'bn_IN' => 'বাংলা',
                               'pa_IN' => 'ਪੰਜਾਬੀ',
                               'ta_IN' => 'தமிழ்',
                               'te_IN' => 'తెలుగు',
                               'ml_IN' => 'മലയാളം',
                               'th_TH' => 'ภาษาไทย',
                               'km_KH' => 'ភាសាខ្មែរ',
                               'ko_KR' => '한국어',
                               'zh_TW' => '中文(台灣)',
                               'zh_CN' => '中文(简体)',
                               'zh_HK' => '中文(香港)',
                               'ja_JP' => '日本語');
    $this->countries = $this->db_result('SELECT country, COUNT(id) AS no FROM users GROUP BY country');
    $this->gender = $this->db_result('SELECT gender, COUNT(id) AS no FROM users GROUP BY gender');
    $this->gender_h = array('m' => 'Male',
                            'f' => 'Female',
                            '' => '');
    $this->categories = $this->db_result('SELECT COUNT(id) AS no, category_id FROM venues GROUP BY category_id');
    $this->categories_h = array(18 => 'Airport',
                                6 => 'Arts & Entertainment',
                                1 => 'Bar',
                                19 => 'Bus',
                                4 => 'Café',
                                8 => 'Club / Society',
                                7 => 'College & University',
                                23 => 'Cultural / Landmark',
                                9 => 'Food',
                                10 => 'Great Outdoors',
                                5 => 'Gym',
                                12 => 'Night Club',
                                11 => 'Nightlife',
                                17 => 'Professional & Other',
                                13 => 'Pub',
                                21 => 'Rail',
                                14 => 'Residence',
                                20 => 'Road',
                                15 => 'Shop & Service',
                                16 => 'Sports',
                                24 => 'Tourist Attraction',
                                3 => 'Travel & Transport',
                                22 => 'Underground');
    $this->waitingVenuesEmail = $this->db_query_all(null, 'venues', array('email_verified = 0', 'official = 1'));
    $this->waitingVenuesAuth = $this->db_query_all(null, 'venues', array('email_verified = 1', 'verified = 0'));
    $this->waitingVenues = max(count($this->waitingVenuesEmail), count($this->waitingVenuesAuth));
		$this->render('dashboard');
	}
}
?>
