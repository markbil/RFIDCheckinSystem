<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Edge_user extends CI_Controller {

	function __construct()
	{
		parent::__construct();
		$this->load->model('edge_user_model');
		$this->load->library('ion_auth');
		$this->load->library('session');
		$this->load->library('form_validation');
		$this->load->helper('url');
		// Load MongoDB library instead of native db driver if required
		$this->config->item('use_mongodb', 'ion_auth') ?
			$this->load->library('mongo_db') :
			$this->load->database();
	}

	//redirect if needed, otherwise display the user list
/* 	function index()
	{

		if (!$this->ion_auth->logged_in())
		{
			//redirect them to the login page
			redirect('edge_user/login', 'refresh');
		}
		elseif (!$this->ion_auth->is_admin())
		{
			//redirect them to the home page because they must be an administrator to view this
		//	redirect($this->config->item('base_url'), 'refresh');
			redirect('edge_user/forgotten_password', 'refresh');
			//redirect('edge_user/profile', 'refresh');
			//redirect('edge_user/update', 'refresh');
			//$this->_render_page('edge_user/update', $this->data);
		}
		else
		{
			//set the flash data error message if there is one
			$this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');

			//list the users
			$this->data['users'] = $this->ion_auth->users()->result();
			foreach ($this->data['users'] as $k => $user)
			{
				$this->data['users'][$k]->groups = $this->ion_auth->get_users_groups($user->id)->result();
			}


			$this->_render_page('edge_user/profile', $this->data);
		}
	}
 */
	//log the user in
	function index()
	{
		$this->data['title'] = "Login";

		//validate form input
		$this->form_validation->set_rules('identity', 'Identity', 'required');
		$this->form_validation->set_rules('password', 'Password', 'required');

		if ($this->form_validation->run() == true)
		{ //check to see if the user is logging in
			//check for "remember me"
			$remember = (bool) $this->input->post('remember');

			if ($this->ion_auth->login($this->input->post('identity'), $this->input->post('password'), $remember))
			{ //if the login is successful
				//redirect them back to the home page
				$this->session->set_flashdata('message', $this->ion_auth->messages());
				redirect('edge_user/profile', 'refresh');
			} else	{ //if the login was un-successful
				//redirect them back to the login page
				$this->session->set_flashdata('message', $this->ion_auth->errors());
				redirect('edge_user/index', 'refresh'); //use redirects instead of loading views for compatibility with MY_Controller libraries
			}
		}
		else
		{  
			// If logged in then go to profile page
			if($this->ion_auth->logged_in()) {
				redirect('edge_user/profile', 'refresh');
			} else {
			//the user is not logging in so display the login page
			//set the flash data error message if there is one
			$this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');

			$this->data['identity'] = array('name' => 'identity',
				'id' => 'identity',
				'type' => 'text',
				'value' => $this->form_validation->set_value('identity'),
			);
			$this->data['password'] = array('name' => 'password',
				'id' => 'password',
				'type' => 'password',
			);

			$this->_render_page('edge_user/index', $this->data);
		}
		}
	}
	
	function profile() {
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

	function feedback() {
		if($this->ion_auth->logged_in()) {
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
			
				$this->_render_page('edge_user/feedback', $data);		
			}
		} else {
			$this->_render_page('edge_user/login', 'refresh');		
		}
	}
	
	//log the user out
	function logout()
	{
		$this->data['title'] = "Logout";

		//log the user out
		$logout = $this->ion_auth->logout();

		//redirect them back to the page they came from
		redirect('edge_user', 'refresh');
	}

	//change password
	function change_password()
	{
		$this->form_validation->set_rules('old', 'Old password', 'required');
		$this->form_validation->set_rules('new', 'New Password', 'required|min_length[' . $this->config->item('min_password_length', 'ion_auth') . ']|max_length[' . $this->config->item('max_password_length', 'ion_auth') . ']|matches[new_confirm]');
		$this->form_validation->set_rules('new_confirm', 'Confirm New Password', 'required');

		if (!$this->ion_auth->logged_in())
		{
			redirect('edge_user/login', 'refresh');
		}

		$user = $this->ion_auth->user()->row();

		if ($this->form_validation->run() == false)
		{ //display the form
			//set the flash data error message if there is one
			$this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');

			$this->data['min_password_length'] = $this->config->item('min_password_length', 'ion_auth');
			$this->data['old_password'] = array(
				'name' => 'old',
				'id'   => 'old',
				'type' => 'password',
			);
			$this->data['new_password'] = array(
				'name' => 'new',
				'id'   => 'new',
				'type' => 'password',
				'pattern' => '^.{'.$this->data['min_password_length'].'}.*$',
			);
			$this->data['new_password_confirm'] = array(
				'name' => 'new_confirm',
				'id'   => 'new_confirm',
				'type' => 'password',
				'pattern' => '^.{'.$this->data['min_password_length'].'}.*$',
			);
			$this->data['user_id'] = array(
				'name'  => 'user_id',
				'id'    => 'user_id',
				'type'  => 'hidden',
				'value' => $user->id,
			);

			//render
			$this->_render_page('edge_user/change_password', $this->data);
		}
		else
		{
			$identity = $this->session->userdata($this->config->item('identity', 'ion_auth'));

			$change = $this->ion_auth->change_password($identity, $this->input->post('old'), $this->input->post('new'));

			if ($change)
			{ //if the password was successfully changed
				$this->session->set_flashdata('message', $this->ion_auth->messages());
				$this->logout();
			}
			else
			{
				$this->session->set_flashdata('message', $this->ion_auth->errors());
				redirect('edge_user/change_password', 'refresh');
			}
		}
	}

	//forgot password
	function forgot_password()
	{
		$this->form_validation->set_rules('email', 'Email Address', 'required');
		if ($this->form_validation->run() == false)
		{
			//setup the input
			$this->data['email'] = array('name' => 'email',
				'id' => 'email',
			);
			//set any errors and display the form
			$this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');
			$this->_render_page('edge_user/forgot_password', $this->data);
		}
		else
		{
			//run the forgotten password method to email an activation code to the user
			$forgotten = $this->ion_auth->forgotten_password($this->input->post('email'));

			if ($forgotten)
			{ //if there were no errors
				$this->session->set_flashdata('message', $this->ion_auth->messages());
				redirect("edge_user/login", 'refresh'); //we should display a confirmation page here instead of the login page
			}
			else
			{
				$this->session->set_flashdata('message', $this->ion_auth->errors());
				redirect("edge_user/forgot_password", 'refresh');
			}
		}
	}

	//reset password - final step for forgotten password
	public function reset_password($code = NULL)
	{
		if (!$code)
		{
			show_404();
		}

		$user = $this->ion_auth->forgotten_password_check($code);

		if ($user)
		{  //if the code is valid then display the password reset form

			$this->form_validation->set_rules('new', 'New Password', 'required|min_length[' . $this->config->item('min_password_length', 'ion_auth') . ']|max_length[' . $this->config->item('max_password_length', 'ion_auth') . ']|matches[new_confirm]');
			$this->form_validation->set_rules('new_confirm', 'Confirm New Password', 'required');

			if ($this->form_validation->run() == false)
			{//display the form
				//set the flash data error message if there is one
				$this->data['message'] = (validation_errors()) ? validation_errors() : $this->session->flashdata('message');

				$this->data['min_password_length'] = $this->config->item('min_password_length', 'ion_auth');
				$this->data['new_password'] = array(
					'name' => 'new',
					'id'   => 'new',
				'type' => 'password',
					'pattern' => '^.{'.$this->data['min_password_length'].'}.*$',
				);
				$this->data['new_password_confirm'] = array(
					'name' => 'new_confirm',
					'id'   => 'new_confirm',
					'type' => 'password',
					'pattern' => '^.{'.$this->data['min_password_length'].'}.*$',
				);
				$this->data['user_id'] = array(
					'name'  => 'user_id',
					'id'    => 'user_id',
					'type'  => 'hidden',
					'value' => $user->id,
				);
				$this->data['csrf'] = $this->_get_csrf_nonce();
				$this->data['code'] = $code;

				//render
				$this->_render_page('edge_user/reset_password', $this->data);
			}
			else
			{
				// do we have a valid request?
				if ($this->_valid_csrf_nonce() === FALSE || $user->id != $this->input->post('user_id')) {

					//something fishy might be up
					$this->ion_auth->clear_forgotten_password_code($code);

					show_404();

				} else {
					// finally change the password
					$identity = $user->{$this->config->item('identity', 'ion_auth')};

					$change = $this->ion_auth->reset_password($identity, $this->input->post('new'));

					if ($change)
					{ //if the password was successfully changed
						$this->session->set_flashdata('message', $this->ion_auth->messages());
						$this->logout();
					}
					else
					{
						$this->session->set_flashdata('message', $this->ion_auth->errors());
						redirect('edge_user/reset_password/' . $code, 'refresh');
					}
				}
			}
		}
		else
		{ //if the code is invalid then send them back to the forgot password page
			$this->session->set_flashdata('message', $this->ion_auth->errors());
			redirect("edge_user/forgot_password", 'refresh');
		}
	}


	//activate the user
	function activate($id, $code=false)
	{
		if ($code !== false)
			$activation = $this->ion_auth->activate($id, $code);
		else if ($this->ion_auth->is_admin())
			$activation = $this->ion_auth->activate($id);

		if ($activation)
		{
			//redirect them to the auth page
			$this->session->set_flashdata('message', $this->ion_auth->messages());
			redirect("auth", 'refresh');
		}
		else
		{
			//redirect them to the forgot password page
			$this->session->set_flashdata('message', $this->ion_auth->errors());
			redirect("edge_user/forgot_password", 'refresh');
		}
	}

	//deactivate the user
	function deactivate($id = NULL)
	{
		$id = $this->config->item('use_mongodb', 'ion_auth') ? (string) $id : (int) $id;

		$this->load->library('form_validation');
		$this->form_validation->set_rules('confirm', 'confirmation', 'required');
		$this->form_validation->set_rules('id', 'user ID', 'required|alpha_numeric');

		if ($this->form_validation->run() == FALSE)
		{
			// insert csrf check
			$this->data['csrf'] = $this->_get_csrf_nonce();
			$this->data['user'] = $this->ion_auth->user($id)->row();

			$this->_render_page('edge_user/deactivate_user', $this->data);
		}
		else
		{
			// do we really want to deactivate?
			if ($this->input->post('confirm') == 'yes')
			{
				// do we have a valid request?
				if ($this->_valid_csrf_nonce() === FALSE || $id != $this->input->post('id'))
				{
					show_404();
				}

				// do we have the right userlevel?
				if ($this->ion_auth->logged_in() && $this->ion_auth->is_admin())
				{
					$this->ion_auth->deactivate($id);
				}
			}

			//redirect them back to the auth page
			redirect('edge_user', 'refresh');
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
		
		$this->form_validation->set_rules('username', 'User Name', 'required|min_length[5]|max_length[15]|is_unique[edge_users.username]');
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
		if (!$this->ion_auth->logged_in()) {
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
		$this->form_validation->set_rules('username', 'User Name', 'required|min_length[5]|max_length[15]');
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
	
	//create a new user
	function create_user()
	{
		$this->data['title'] = "Create User";

		if (!$this->ion_auth->logged_in() || !$this->ion_auth->is_admin())
		{
			redirect('edge_user', 'refresh');
		}

		//validate form input
		$this->form_validation->set_rules('first_name', 'First Name', 'required|xss_clean');
		$this->form_validation->set_rules('last_name', 'Last Name', 'required|xss_clean');
		$this->form_validation->set_rules('email', 'Email Address', 'required|valid_email');
		$this->form_validation->set_rules('phone1', 'First Part of Phone', 'required|xss_clean|min_length[3]|max_length[3]');
		$this->form_validation->set_rules('phone2', 'Second Part of Phone', 'required|xss_clean|min_length[3]|max_length[3]');
		$this->form_validation->set_rules('phone3', 'Third Part of Phone', 'required|xss_clean|min_length[4]|max_length[4]');
		$this->form_validation->set_rules('company', 'Company Name', 'required|xss_clean');
		$this->form_validation->set_rules('password', 'Password', 'required|min_length[' . $this->config->item('min_password_length', 'ion_auth') . ']|max_length[' . $this->config->item('max_password_length', 'ion_auth') . ']|matches[password_confirm]');
		$this->form_validation->set_rules('password_confirm', 'Password Confirmation', 'required');

		if ($this->form_validation->run() == true)
		{
			$username = strtolower($this->input->post('first_name')) . ' ' . strtolower($this->input->post('last_name'));
			$email = $this->input->post('email');
			$password = $this->input->post('password');

			$additional_data = array('first_name' => $this->input->post('first_name'),
				'last_name' => $this->input->post('last_name'),
				'company' => $this->input->post('company'),
				'phone' => $this->input->post('phone1') . '-' . $this->input->post('phone2') . '-' . $this->input->post('phone3'),
			);
		}
		if ($this->form_validation->run() == true && $this->ion_auth->register($username, $password, $email, $additional_data))
		{ //check to see if we are creating the user
			//redirect them back to the admin page
			$this->session->set_flashdata('message', "User Created");
			redirect("edge_user", 'refresh');
		}
		else
		{ //display the create user form
			//set the flash data error message if there is one
			$this->data['message'] = (validation_errors() ? validation_errors() : ($this->ion_auth->errors() ? $this->ion_auth->errors() : $this->session->flashdata('message')));

			$this->data['first_name'] = array('name' => 'first_name',
				'id' => 'first_name',
				'type' => 'text',
				'value' => $this->form_validation->set_value('first_name'),
			);
			$this->data['last_name'] = array('name' => 'last_name',
				'id' => 'last_name',
				'type' => 'text',
				'value' => $this->form_validation->set_value('last_name'),
			);
			$this->data['email'] = array('name' => 'email',
				'id' => 'email',
				'type' => 'text',
				'value' => $this->form_validation->set_value('email'),
			);
			$this->data['company'] = array('name' => 'company',
				'id' => 'company',
				'type' => 'text',
				'value' => $this->form_validation->set_value('company'),
			);
			$this->data['phone1'] = array('name' => 'phone1',
				'id' => 'phone1',
				'type' => 'text',
				'value' => $this->form_validation->set_value('phone1'),
			);
			$this->data['phone2'] = array('name' => 'phone2',
				'id' => 'phone2',
				'type' => 'text',
				'value' => $this->form_validation->set_value('phone2'),
			);
			$this->data['phone3'] = array('name' => 'phone3',
				'id' => 'phone3',
				'type' => 'text',
				'value' => $this->form_validation->set_value('phone3'),
			);
			$this->data['password'] = array('name' => 'password',
				'id' => 'password',
				'type' => 'password',
				'value' => $this->form_validation->set_value('password'),
			);
			$this->data['password_confirm'] = array('name' => 'password_confirm',
				'id' => 'password_confirm',
				'type' => 'password',
				'value' => $this->form_validation->set_value('password_confirm'),
			);
			$this->_render_page('edge_user/create_user', $this->data);
		}
	}

	function _get_csrf_nonce()
	{
		$this->load->helper('string');
		$key = random_string('alnum', 8);
		$value = random_string('alnum', 20);
		$this->session->set_flashdata('csrfkey', $key);
		$this->session->set_flashdata('csrfvalue', $value);

		return array($key => $value);
	}

	function _valid_csrf_nonce()
	{
		if ($this->input->post($this->session->flashdata('csrfkey')) !== FALSE &&
				$this->input->post($this->session->flashdata('csrfkey')) == $this->session->flashdata('csrfvalue'))
		{
			return TRUE;
		}
		else
		{
			return FALSE;
		}
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
