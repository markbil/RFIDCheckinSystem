<?php
class Edge_user extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('edge_user_model');
		$this->load->library('session');
		$this->load->helper('url');
	}

	/*
	 * First Page that User Comes to
	* Ask For Username and Password
	*/
	public function index()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');
		$user_id=null;
		$is_logged_in = $this->_is_logged_in();

		// Check if we are logged in
		if (!$is_logged_in) {
			// We are not logged in so set up checks for username and password
			
			$data['title'] = 'Enter Your Login Details';

			$this->form_validation->set_rules('username', 'User Name', 'required|min_length[5]|max_length[12]');
			$this->form_validation->set_rules('password', 'Password', 'required|min_length[8]');
			if ($this->form_validation->run() !== FALSE)
 			{
			// Form entry is valid - now check with database for username and password
				if($user_id=$this->edge_user_model->validate_login()) {
				
				// Store session cookie
				$this->_save_session_cookie($user_id);
									
					$data['title'] = "Your Profile Details";
					$data['message']='';
					$data['form_action'] = site_url('edge_user/update');
					$data['user_id'] = $user_id;
					$data['user_details'] = $this->edge_user_model->get_user_details($user_id)->row_array();
					$data['interests'] = $this->_get_interests($user_id);
					$data['expertises'] = $this->_get_expertise($user_id);
					$data['questions'] = $this->_get_questions($user_id);
					//error_log('INDEX INTERESTS[' . var_export($data['interests'],true) . ']'.PHP_EOL,3,'/var/log/php_errors.log');
								
					if (empty($data['user_details']))
					{
						show_404();
					}

					$this->_render_page('edge_user/profile', $data);
					return;

				} else {
					$data['login_attempt'] = "Incorrect Username / Password";
				}
			}
			$this->_render_page('edge_user/index', $data);
		}
		else {
			if($user_id=$this->session->userdata('user_id')) {

				$data['title'] = "Your Profile Details";
				$data['message']='';
				$data['form_action'] = site_url('edge_user/update');
				$data['user_id'] = $user_id;
				$data['user_details'] = $this->edge_user_model->get_user_details($user_id)->row_array();
				$data['interests'] = $this->_get_interests($user_id);
				$data['expertises'] = $this->_get_expertise($user_id);
				$data['questions'] = $this->_get_questions($user_id);
				
				if (empty($data['user_details']))
				{
					show_404();
				}

				$this->_render_page('edge_user/profile', $data);
			}
		}
	}

	/*
	 * Page for user to sign up to the RFID checkin system
	*/
	public function signup()
	{
		$this->load->helper('form');
		$this->load->library('form_validation');

		$data['title'] = 'Select Your Details';
		$data['form_action'] = site_url('edge_user/update');
		
		$this->form_validation->set_rules('username', 'User Name', 'required|min_length[5]|max_length[12]|is_unique[edge_users.username]');
		$this->form_validation->set_rules('password', 'Password', 'required|matches[password_confirm]|min_length[8]');
		$this->form_validation->set_rules('password_confirm', 'Password Confirmation', 'required|min_length[8]');

		if ($this->form_validation->run() === FALSE)
		{
			$this->_render_page('edge_user/signup', $data);
		}
		else
		{
			if($user_id=$this->edge_user_model->validate_signup()) {
			//if ($user_id) {
				$this->_save_session_cookie($user_id);
				
				$data['title'] = "Your Profile Details";
				$data['message']='';
				$data['user_details'] = $this->edge_user_model->get_user_details($user_id)->row_array();
				if (empty($data['user_details']))
				{
					show_404();
				}

				$this->_render_page('edge_user/profile', $data);

				return;
			}
			$this->_render_page('edge_user/index', $data);
		}
	}

	public function update(){
		if (!$this->_is_logged_in()) {
			$this->index();
			return;
		}
		
		if (!$this->input->post()) {
			$this->index();
			return;
		}

		$this->load->helper('form');
		$this->load->library('form_validation');

		// set common properties
		$data['title'] = 'Update Profile';
		$data['form_action'] = site_url('edge_user/update');
		$data['message']='';
		//$data['link_back'] = anchor('person/index/','Back to list of persons',array('class'=>'back'));

		// set validation properties
		$this->form_validation->set_rules('username', 'User Name', 'required|min_length[5]|max_length[12]');
		$this->form_validation->set_rules('firstname', 'First Name', 'required');
		$this->form_validation->set_rules('lastname', 'Last Name', 'required');
		$this->form_validation->set_rules('email', 'Email Address', 'required|min_length[9]');
		$this->form_validation->set_rules('occupation', 'Occupation', 'required|max_length[25]');
		if ( strlen($this->input->post('new_interest'))) {
			$this->form_validation->set_rules('new_interest', 'Interest Term', 'min_length[3]');
			$this->form_validation->set_rules('new_interest_level', 'Interest Level', 'greater_than[0]|less_than[6]');
		}
			if ( strlen($this->input->post('new_expertise'))) {
			$this->form_validation->set_rules('new_expertise', 'Expertise Term', 'min_length[3]');
			$this->form_validation->set_rules('new_expertise_level', 'Expertise Level', 'greater_than[0]|less_than[6]');
		}
		$all_post = $this->input->post();
//error_log('all_post[' . var_export($all_post,true) . ']'.PHP_EOL,3,'/var/log/php_errors.log');
		
		$user_id = $this->input->post('id');
		$dontdisturb = ($this->input->post('dontdisturb')===FALSE) ? 0 : 1;
		$data['user_details'] = array(
				'ID' => $user_id,
				'username' => $this->input->post('username'),
				'firstname' => $this->input->post('firstname'),
				'lastname' => $this->input->post('lastname'),
				'email' => $this->input->post('email'),
				'occupation' => $this->input->post('occupation'),
				'dontdisturb' => $dontdisturb,
		);

		$data['new_interest']=array(
				'interest' => $this->input->post('new_interest'),
				'level' => $this->input->post('new_interest_level'),
		);
		$data['interests']=$this->edge_user_model->get_user_interests($user_id)->result_array();
			
		$data['new_expertise']=array(
				'expertise' => $this->input->post('new_expertise'),
				'level' => $this->input->post('new_expertise_level'),
		);
		$data['expertises']=$this->edge_user_model->get_user_expertises($user_id)->result_array();
		
		$data['new_question']=array(
				'question' => $this->input->post('new_question'),
		);
		$data['questions']=$this->edge_user_model->get_user_questions($user_id)->result_array();
		
		// run validation
		if ($this->form_validation->run() === FALSE){
			$data['message'] = 'Please Correct Values';
		}else{
			$all_post = $this->input->post();
			/*
			 * Handle the interests that  have been submitted
			 */
			$posted_interest_checkboxes=array();
			$posted_interest_selects=array();
			$posted_interest_levels=array();

			// Make an array of all interests from checkboxes
			foreach($all_post as $field=>$proposed_value) {
				if (preg_match('/interest_([0-9]+)/', $field, $match)) {
					$posted_interest_checkboxes[$match[1]]=$match[1];
				}
			}
			
			// Make an array of all interests from selects
			foreach($all_post as $field=>$proposed_value) {
				if (preg_match('/interest_level_([0-9]+)/', $field, $match)) {
					$posted_interest_selects[$match[1]]=$match[1];
					$posted_interest_levels[$match[1]] = $proposed_value;
				}
			}
				
			// Delete all the ids that don't match
			foreach(array_diff($posted_interest_selects,$posted_interest_checkboxes) as $key=>$user_interest_id) {
				$this->edge_user_model->delete_user_interest($user_interest_id);
			}
				
			$data['interests']=$this->edge_user_model->get_user_interests($user_id)->result_array();
			// Update any levels that may have changed
			foreach($data['interests'] as $record=>$interest_array) {
				if(array_key_exists($interest_array['ID'], $posted_interest_levels)){
					if($posted_interest_levels[$interest_array['ID']]  != $interest_array['level']) {
						if($this->edge_user_model->update_user_interest_level($interest_array['ID'],
								$posted_interest_levels[$interest_array['ID']]
						) === FALSE) return FALSE;
					}
				}
			}
			
			/*
			 * Handle the expertises that  have been submitted
			 */
			$posted_expertise_checkboxes=array();
			$posted_expertise_selects=array();
			$posted_expertise_levels=array();
			
			// Make an array of all expertises from checkboxes
			foreach($all_post as $field=>$proposed_value) {
				if (preg_match('/expertise_([0-9]+)/', $field, $match)) {
					$posted_expertise_checkboxes[$match[1]]=$match[1];
				}
			}
				
			// Make an array of all expertises from selects
			foreach($all_post as $field=>$proposed_value) {
				if (preg_match('/expertise_level_([0-9]+)/', $field, $match)) {
					$posted_expertise_selects[$match[1]]=$match[1];
					$posted_expertise_levels[$match[1]] = $proposed_value;
				}
			}
			
			// Delete all the ids that don't match
			foreach(array_diff($posted_expertise_selects,$posted_expertise_checkboxes) as $key=>$user_expertise_id) {
				$this->edge_user_model->delete_user_expertise($user_expertise_id);
			}
			
			$data['expertises']=$this->edge_user_model->get_user_expertises($user_id)->result_array();
			// Update any levels that may have changed
			foreach($data['expertises'] as $record=>$expertise_array) {
				if(array_key_exists($expertise_array['ID'], $posted_expertise_levels)){
					if($posted_expertise_levels[$expertise_array['ID']]  != $expertise_array['level']) {			
						if($this->edge_user_model->update_user_expertise_level($expertise_array['ID'],
								$posted_expertise_levels[$expertise_array['ID']]
						) === FALSE) return FALSE;
					}
				}
			}
				
			/*
			 * Handle the questions that  have been submitted
			*/
			$posted_question_checkboxes=array();
				
			// Make an array of all questions from checkboxes
			foreach($all_post as $field=>$proposed_value) {
				if (preg_match('/question_([0-9]+)/', $field, $match)) {
					$posted_question_checkboxes[$match[1]]=$match[1];
				}
			}
							
			$data['questions']=$this->edge_user_model->get_user_questions($user_id)->result_array();
			// Update any levels that may have changed
			foreach($data['questions'] as $record=>$question_array) {
				if(!array_key_exists($question_array['ID'], $posted_question_checkboxes)){
					// Deletethe question if it is not there
					$this->edge_user_model->delete_user_question($question_array['ID']);
				}
			}
				
			// save data
			$data['user_details']=$this->edge_user_model->update($user_id,$data['user_details'])->row_array();

			// Set interest data
			if (strlen($this->input->post('new_interest'))) {
				$data['interests']=$this->edge_user_model->add_user_interest($user_id,$data['new_interest']['interest'],$data['new_interest']['level'])->result_array();
				$data['interests']=$this->_sort_interests($data['interests']);
			} else {
				$data['interests']=$this->_get_interests($user_id);
			}
			
			// Set expertise data
			if (strlen($this->input->post('new_expertise'))) {
				$data['expertises']=$this->edge_user_model->add_user_expertise($user_id,$data['new_expertise']['expertise'],$data['new_expertise']['level'])->result_array();
				$data['expertises']=$this->_sort_expertise($data['expertises']);
			} else {
				$data['expertises']=$this->_get_expertise($user_id);
			}
			
			// Set question data
			if (strlen($this->input->post('new_question'))) {
				$data['questions']=$this->edge_user_model->add_user_question($user_id,$data['new_question']['question'])->result_array();
				$data['questions']=$this->_sort_questions($data['questions']);
			} else {
				$data['questions']=$this->_get_questions($user_id);
			}
			if ($data['user_details'] === FALSE || $data['interests'] === FALSE) {
				// set user message
				$data['message'] = '<div class="fail">Profile Update FAILED!</div>';
			} else {
				$data['message'] = '<div class="success">Profile Update succeeded! </div>';
			}
		}
		// load view
		$this->_render_page('edge_user/profile', $data);
	}

	public function logout() {
		$this->session->sess_destroy();
		
		redirect('edge_user');
	}
	
	private function _is_logged_in() {
		
		return $this->session->userdata('logged_in');
	}

	private function  _save_session_cookie($user_id) {
		$sessiondata = array(
				'user_id'  => $user_id,
				'logged_in' => TRUE
		);
				
		$this->session->set_userdata($sessiondata);
		
	}
	
	private function _render_page($name, $data/*At least include Title*/) {
		$this->load->view('templates/header', $data);
		$this->load->view($name, $data);
		$this->load->view('templates/footer');
	}
	
	private function _sort_interests($interests_array) {	
		if ($interests_array) {
			foreach($interests_array as $key=>$row) {
				$interest[$key]=$row['interest'];
			}
			array_multisort($interest, SORT_STRING, $interests_array);
		}
		return $interests_array;
	}
	
	private function _get_interests($user_id) {
		$interests_array = $this->edge_user_model->get_user_interests($user_id)->result_array();
		if ($interests_array) {
			foreach($interests_array as $key=>$row) {
				$interest[$key]=$row['interest'];
			}
			array_multisort($interest, SORT_STRING, $interests_array);
		}
		return $interests_array;
	}
	
	private function _sort_expertise($expertises_array) {	
		if ($expertises_array) {
			foreach($expertises_array as $key=>$row) {
				$expertise[$key]=$row['expertise'];
			}
			array_multisort($expertise, SORT_STRING, $expertises_array);
		}
		return $expertises_array;
	}
	
	private function _get_expertise($user_id) {
		$expertises_array = $this->edge_user_model->get_user_expertises($user_id)->result_array();
		if ($expertises_array) {
			foreach($expertises_array as $key=>$row) {
				$expertise[$key]=$row['expertise'];
			}
			array_multisort($expertise, SORT_STRING, $expertises_array);
		}
		return $expertises_array;
	}
	
	private function _sort_questions($question_array) {
		if ($question_array) {	
			foreach($question_array as $key=>$row) {
				$question[$key]=$row['question'];
			}
			array_multisort($question, SORT_STRING, $question_array);
		}
		
		return $question_array;
	}
	
	private function _get_questions($user_id) {
		$question_array = $this->edge_user_model->get_user_questions($user_id)->result_array();
		if (!empty($question)) {
			foreach($question_array as $key=>$row) {
				$question[$key]=$row['question'];
			}
			array_multisort($question, SORT_STRING, $question_array);
		}
		return $question_array;
	}

}
