<?php
class Main extends Controller {
	function index() {
		$this->smarty->display('main/index.tpl');
	}
}
?>
