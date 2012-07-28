<?php
class Json_Access extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('edge_administration_model');
		$this->load->helper('url');		
		$this->load->library('ion_auth');
		$this->load->library('session');
	}

	/*
	 * Default is to redirect to edge_user
	*/
	public function index()
	{
		if($this->ion_auth->logged_in()) {
			$action=null;
			if(preg_match('/json_access\/(.+)/', uri_string(),$matches)) {
				$action=$matches[1];
			}

			switch ($action) {
/* 				case 'create_user':
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
 */					
				/* case 'rfid_list':
					$rfid_tag_search=null;
					if(preg_match('/rfid_list\?term=(.+)/', uri_string(),$matches)) {
						$rfid_tag_search=$matches[1];
					}
					$this->rfid_list($rfid_tag_search);
					return; */
					
				default:
					redirect('edge_user', 'refresh');
			}
		} else {
			redirect('edge_user', 'refresh');
		}
	}
	
	/*
	 * List All Available RFIDs
	*/
	public function rfid_list()
	{
		$rfid_list=array();
		if($this->ion_auth->logged_in()) {
			$rfid_search = $this->input->get('term');
			$query = $this->edge_administration_model->get_rfid($rfid_search, true);
			$result = $query->result_array();
			foreach($result as $row) {
				$rfid_list[] = array(
					'id' => $row['ID'],
					'label' => $row['ThirdPartyID'],
				);
			}
		}
	
		echo json_encode($rfid_list);
	}
	

}
