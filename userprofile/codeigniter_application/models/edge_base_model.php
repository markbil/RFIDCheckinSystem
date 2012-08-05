<?php

class Edge_Base_model extends CI_Model {

	public function __construct()
	{
		//$this->load->library('form_validation');
		$this->load->database();
	}
	
	public function render_page($name, $data/*At least include Title*/) {
		$this->load->view('templates/header', $data);
		$this->load->view($name, $data);
		$this->load->view('templates/footer');
	}
	
}