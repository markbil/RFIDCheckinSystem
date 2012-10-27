<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Edge_Common extends CI_Controller {
	
	public function __construct()
	{
 		parent::__construct();
   		$this->load->library('form_validation');
 		$this->load->library('session');
  		$this->load->library('ion_auth');
  		$this->load->database();
	}
	
	public function render_page($name, $data/*At least include Title*/) {
		$this->load->view('templates/header', $data);
		$this->load->view($name, $data);
		$this->load->view('templates/footer');
	}
	
}