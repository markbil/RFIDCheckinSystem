<?php
class Project extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('project_model');
		$this->load->helper('url');
	}

	/*
	 * List All Projects
	*/
	public function index()
	{
		//$this->load->helper('form');
		//$this->load->library('form_validation');

		$data['title'] = "Project Listings";
		$data['message']='';
		$data['project_list'] = $this->project_model->get_project_listings();
		$data['user_id'] = $this->input->post('user_id');
		$data['link_back'] = anchor('edge_user/profile','Return to User Profile', array('style'=>'float:right'));

		$this->_render_page('project/index', $data);
	}

	/*
	 * View & Update Details for a Project
	*/
	function profile($id){
		$this->load->helper('form');
		$this->load->library('form_validation');
		$data['title'] = 'Project Details';
		// set validation properties
		//$this->_set_fields();
		$this->form_validation->set_rules('name', 'Project Name', 'required|min_length[5]|max_length[30]');
		$this->form_validation->set_rules('description', 'Description', 'required|min_length[8]');

		$data['form_mode'] = 'update';
		if ($this->input->post('is_update')===FALSE) {
			// prefill form values
			$data['project_details'] = $this->project_model->get_project_details($id)->row_array();
		} else {
			$data['project_details']['ID'] = $id;
			$data['project_details']['Name'] = $this->input->post('name');
			$data['project_details']['Description'] = $this->input->post('description');
		}

		// set common properties
		$data['message'] = '';
		$data['form_action'] = site_url('project/profile/'. $id);
		$data['link_back'] = anchor('project','Return to Project List',array('class'=>'back'));

		if ($this->form_validation->run() === FALSE)
		{
			$this->_render_page('project/profile', $data);
		}
		else
		{
			// load view
			$data['project_details']=$this->project_model->update($id,$data['project_details'])->row_array();
			if (!empty($data['project_details'])) {
				// set user message
				$data['message'] = '<div class="success">Project Updated! </div>';
			} else {
				$data['message'] = '<div class="fail">Project Update FAILED!</div>';
			}
			$this->_render_page('project/profile', $data);
		}
	}

	function create(){
		$this->load->helper('form');
		$this->load->library('form_validation');
		$data['title'] = 'Project Details';
		// set validation properties
		//$this->_set_fields();
		$this->form_validation->set_rules('name', 'Project Name', 'required|min_length[5]|max_length[30]');
		$this->form_validation->set_rules('description', 'Description', 'required|min_length[8]');

		$data['form_mode'] = 'create';

		// set common properties
		$data['message'] = '';
		$data['form_action'] = site_url('project/create');
		$data['link_back'] = anchor('project','Return to Project List',array('class'=>'back'));

		$data['project_details']['ID'] = null;
		$data['project_details']['Name'] = $this->input->post('name');
		$data['project_details']['Description'] = $this->input->post('description');
		
		if ($this->form_validation->run() === FALSE)
		{
			$this->_render_page('project/profile', $data);
		}
		else
		{
			$data['project_details']['ID']=$this->project_model->create($data['project_details']);
			if (!empty($data['project_details'])) {
				// set user message
				$data['message'] = '<div class="success">Project Created! </div>';
			} else {
				$data['message'] = '<div class="fail">Project Creation FAILED!</div>';
			}
			$this->_render_page('project/profile', $data);
		}
	}
	
	private function _sort_collaborators($collaborators_array) {
		if ($collaborators_array) {
			foreach($collaborators_array as $key=>$row) {
				$collaborator[$key]=$row['collaborator'];
			}
			array_multisort($collaborator, SORT_STRING, $collaborators_array);
		}
		return $collaborators_array;
	}
	
	private function _get_collaborators($project_id) {
		$collaborators_array = $this->project_model->get_collaborators($project_id)->result_array();
		if ($collaborators_array) {
			foreach($collaborators_array as $key=>$row) {
				$collaborator[$key]=$row['collaborator'];
			}
			array_multisort($collaborator, SORT_STRING, $collaborators_array);
		}
		return $collaborators_array;
	}
	
	
	private function _render_page($name, $data/*At least include Title*/) {
		$this->load->view('templates/header', $data);
		$this->load->view($name, $data);
		$this->load->view('templates/footer');
	}

}
