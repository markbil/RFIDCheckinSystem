<?php
class Edge_Administration extends CI_Controller {

	protected $title='RFID Listings';
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('edge_administration_model');
		$this->load->driver('edge_common');
	}

	/*
	 * List All Administration Options
	*/
	public function index()
	{
		if($this->edge_common->ion_auth->logged_in()) {
			$action=null;
			if(preg_match('/admin\/(.+)/', uri_string(),$matches)) {
				$action=$matches[1];
			}

			switch ($action) {
				/*case 'create_user':
					$this->edge_common->render_page('edge_administration/index', $data);
					//redirect('edge_user/create', 'refresh');
					return;
											
				case 'list_users':
					redirect('edge_user/list', 'refresh');
					return;
					*/
				
				case 'create_project':
					redirect('project/create', 'refresh');
					return;
					
				case 'list_projects':
					redirect('project', 'refresh');
					return;
					
				case 'list_rfids':
						$this->list_rfids();
						return;
					
				default:
					$data['title'] = "Administration";
					$this->edge_common->render_page('edge_administration/index', $data);
			}
		} else {
			redirect('edge_user', 'refresh');
		}
	}
	
	function list_rfids() {	
		$data['title'] = $this->title;	
		$data['message']=null;
		$data['form_action'] = site_url('admin/list_rfids');
		
		//validate form input
		$this->form_validation->set_rules('new_rfid', 'RFID Card Unique ID', 'required');
		if ($this->form_validation->run() == true) {
			$new_rfid = $this->input->post('new_rfid');
			
			$result=$this->edge_administration_model->add_rfid($new_rfid);
			if ($result === -1) {
				$data['message']="RFID Card Unique ID All Ready Exists!<br>[$new_rfid]";
			} else if($result === FALSE) {
				$data['message']="Error Updating Database!";
			} else {
				$data['message']="New RFID [$new_rfid] Added!";
			}
				
		}
		
		//list the users
		$data['rfids'] = $this->edge_administration_model->get_rfid()->result();
/* 		foreach ($this->data['rfids'] as $k => $user)
		{
			$this->data['rfids'][$k]->groups = $this->ion_auth->get_users_groups($user->id)->result();
		}
 */
		$this->edge_common->render_page('edge_administration/rfid', $data);
	}
	
}
