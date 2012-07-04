<?php
class Edge_Administration extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('edge_administration_model');
		$this->load->library('ion_auth');
		$this->load->library('session');
		$this->load->helper('url');
	}

	/*
	 * List All Administration Options
	*/
	public function index()
	{
		if($this->ion_auth->logged_in()) {
			$action=null;
			if(preg_match('/admin\/(.+)/', uri_string(),$matches)) {
				$action=$matches[1];
			}

			switch ($action) {
				case 'create_user':
					redirect('edge_user/create', 'refresh');
					return;
											
				case 'list_users':
					redirect('edge_user/list', 'refresh');
					return;
					
				case 'create_project':
					redirect('project/create', 'refresh');
					return;
					
				case 'list_projects':
					redirect('project', 'refresh');
					return;
					
				default:
					$data['title'] = "Administration";
					$this->_render_page('edge_administration/index', $data);
			}
		} else {
			redirect('edge_user', 'refresh');
		}
	}
		
	private function _render_page($name, $data/*At least include Title*/) {
		$this->load->view('templates/header', $data);
		$this->load->view($name, $data);
		$this->load->view('templates/footer');
	}

}
