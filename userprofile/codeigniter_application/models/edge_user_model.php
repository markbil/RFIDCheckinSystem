<?php
class Edge_user_model extends CI_Model {

	public function __construct()
	{
		$this->load->database();
	}
	
	/*
	 * Validate the details of username and password
	 * If none exist or if incorrect values then return FALSE 
	 * otherwise return the ID of the edge_user table
	 */
	public function validate_login()
	{	
		$data = array(
				'username' => $this->input->post('username'),
				'password' => $this->_prep_password($this->input->post('password'))
		);
		
		$this->db->select('ID');		
		$query= $this->db->get_where('edge_users', array('username'=>$data['username'],'password'=>$data['password']));
		
		if ($query->num_rows == 1) {
			$query=$query->row_array();
			return $query['ID'];
		}
	
		return FALSE;
	}
	
	public function validate_signup()
	{	
		// TODO: Remove in final production!
		// First Create an RFID ID
		// Generate a random ID number
		//$rfid=sha1(rand());
		// put this in the identification_media table
	/**********************************************/
		$this->db->insert('identification_media', array('ThirdPartyID'=>sha1(rand()), 'Type'=>1));
		// Get database ID for this new RFID entry
		$this->db->select_max('ID');
		$query= $this->db->get('identification_media')->row_array();
		$rfid_id=$query['ID'];
	/**********************************************/
		
		$data = array(
				'username' => $this->input->post('username'),
				'password' => $this->_prep_password($this->input->post('password'))
		);
		
		// Add into the database and then redirect to Profile
		$this->db->insert('edge_users', $data);
		$this->db->select('ID');		
		$query= $this->db->get_where('edge_users', array('username'=>$data['username'],'password'=>$data['password']));
		
		if ($query->num_rows == 1) {
			$query=$query->row_array();
			
			//TODO: Remove in Production!
			/******************************************************************/
			$this->db->insert('people', array('edge_users_id'=>$query['ID'],'identification_id' => $rfid_id));
			/******************************************************************/
					
			return $query['ID'];
		}
	
		return FALSE;
	}
	
	public function get_user_details($user_id)
	{	
		// Try a query to see if a identification_media has been associated with edge_user
		$this->db->select('edge_users.ID AS ID, username, firstname,lastname, email, active,dontdisturb, ThirdPartyID');
		$this->db->join('people', 'edge_users.id=edge_users_id');
		$this->db->join('identification_media', 'identification_media.id=identification_id');
		$query = $this->db->get_where('edge_users', array('edge_users.ID' => $user_id));

		 if ($query->num_rows() == 0) {
		 	// Let's try just a SELECT from edge_users
		 	$this->db->select('edge_users.ID AS ID, username, firstname,lastname, email, active,dontdisturb');
		 	$query = $this->db->get_where('edge_users', array('edge_users.ID' => $user_id));
		 }
		 
		 return $query;
	}
	
	// update edge_user details by id
	public function update($user_id, $edge_user_details){
		$this->db->where('ID', $user_id);
		if($this->db->update('edge_users', $edge_user_details) === FALSE) return FALSE;
		
		return $this->get_user_details($user_id);
	}

	/*
	 * Handle the 'interests' related items
	*/
	
	public function get_user_interests($user_id) {
		 $this->db->select('edge_users_interests.ID AS ID,interest, level')
		->from('edge_users_interests')
		->join('interest_table', 'edge_users_interests.interest_id=interest_table.ID')
		->where('edge_users_id',$user_id);
		//$query = $this->db->get_where('interest_table', array('edge_users_id' => $user_id));
		
		return $this->db->get();
	}
	
	public function add_user_interest($user_id, $new_interest,$new_level) {
		$interest_id=$this->add_interest($new_interest);
		
		// First check if this interest exists for user
		$this->db->select('ID');
		$query = $this->db->get_where('edge_users_interests', 
																array('edge_users_id'=>$user_id,'interest_id' => $interest_id));
		if ($query->num_rows() ==0) {
			//Add in new interest
			$data = array('interest'=>strtolower($new_interest),);
			
			// insert new interest item into edge_users_interests
			$data=array(
					'edge_users_id'=>$user_id,
					'interest_id'=>$interest_id,
					'level'=>$new_level			
			);
			if($this->db->insert('edge_users_interests',$data)  === FALSE) return FALSE;				
		}
		
		return $this->get_user_interests($user_id);
	}
		
	public function add_interest($new_interest) {
		// First check if this interest exists all ready
		$this->db->select('ID');
		$query = $this->db->get_where('interest_table', array('interest' => strtolower($new_interest)));
		if ($query->num_rows() ==0) {
			//Add in new interest
			$data = array('interest'=>strtolower($new_interest),);
			// insert new interest into table
			if($this->db->insert('interest_table',$data)  === FALSE) return FALSE;
			$this->db->select_max('ID');
			return $this->db->get('interest_table')->row()->ID;
		}
		
		return $query->row()->ID;
	}
	
	public function update_user_interest_level($user_interest_id, $new_level) {
		$interest_details=array(
				'level'=>$new_level
				);			
	
		$this->db->where('ID', $user_interest_id);
		return $this->db->update('edge_users_interests', $interest_details);		
	}
	
	public function delete_user_interest($user_interest_id) {
		return $this->db->delete('edge_users_interests', 
														array('ID'=>$user_interest_id));		
	}
	
	public function delete_interest($interest_id) {
		return $this->db->delete('interest_table', array('ID' => $interest_id));		
	}
	
	/*
	 * Handle the 'expertise' related items
	*/
	
	public function get_user_expertises($user_id) {
		 $this->db->select('edge_users_expertises.ID AS ID,expertise, level')
		->from('edge_users_expertises')
		->join('expertise_table', 'edge_users_expertises.expertise_id=expertise_table.ID')
		->where('edge_users_id',$user_id);
		//$query = $this->db->get_where('expertise_table', array('edge_users_id' => $user_id));
		
		return $this->db->get();
	}
	
	public function add_user_expertise($user_id, $new_expertise,$new_level) {
		$expertise_id=$this->add_expertise($new_expertise);
		
		// First check if this expertise exists for user
		$this->db->select('ID');
		$query = $this->db->get_where('edge_users_expertises', 
																array('edge_users_id'=>$user_id,'expertise_id' => $expertise_id));
		if ($query->num_rows() ==0) {
			//Add in new expertise
			$data = array('expertise'=>strtolower($new_expertise),);
			
			// insert new expertise item into edge_users_expertises
			$data=array(
					'edge_users_id'=>$user_id,
					'expertise_id'=>$expertise_id,
					'level'=>$new_level			
			);
			if($this->db->insert('edge_users_expertises',$data)  === FALSE) return FALSE;				
		}
		
		return $this->get_user_expertises($user_id);
	}
		
	public function add_expertise($new_expertise) {
		// First check if this expertise exists all ready
		$this->db->select('ID');
		$query = $this->db->get_where('expertise_table', array('expertise' => strtolower($new_expertise)));
		if ($query->num_rows() ==0) {
			//Add in new expertise
			$data = array('expertise'=>strtolower($new_expertise),);
			// insert new expertise into table
			if($this->db->insert('expertise_table',$data)  === FALSE) return FALSE;
			$this->db->select_max('ID');
			return $this->db->get('expertise_table')->row()->ID;
		}
		
		return $query->row()->ID;
	}
	
	public function update_user_expertise_level($user_expertise_id, $new_level) {
		$expertise_details=array(
				'level'=>$new_level
				);			
	
		$this->db->where('ID', $user_expertise_id);
		return $this->db->update('edge_users_expertises', $expertise_details);		
	}
	
	public function delete_user_expertise($user_expertise_id) {
		return $this->db->delete('edge_users_expertises', 
														array('ID'=>$user_expertise_id));		
	}
	
	public function delete_expertise($expertise_id) {
		return $this->db->delete('expertise_table', array('ID' => $expertise_id));		
	}
	
	/*
	 * Handle the 'question' related items
	*/
	
	public function get_user_questions($user_id) {
		 $this->db->select('edge_users_questions.ID AS ID,question')
		->from('edge_users_questions')
		->where('edge_users_id',$user_id);
		
		return $this->db->get();
	}
	
	public function add_user_question($user_id, $new_question) {
		//$question_id=$this->add_question($new_question);
		
		// First check if this question exists for user
		$this->db->select('ID');
		$query = $this->db->get_where('edge_users_questions', 
																array('edge_users_id'=>$user_id,'question' => $new_question));
		if ($query->num_rows() ==0) {
			//Add in new question
			// insert new question item into edge_users_questions
			$data=array(
					'edge_users_id'=>$user_id,
					'question'=>strtolower($new_question),
			);
			if($this->db->insert('edge_users_questions',$data)  === FALSE) return FALSE;				
		}
		
		return $this->get_user_questions($user_id);
	}
		
	public function delete_user_question($user_question_id) {
		return $this->db->delete('edge_users_questions', 
														array('ID'=>$user_question_id));		
	}
	
	/*
	 * This handles the encryption of the password
	 * to be inserted into the database
	 */
	private function _prep_password($password)
	{
		return sha1($password.$this->config->item('encryption_key'));
	}
	
}