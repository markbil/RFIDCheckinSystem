<?php

class Edge_Administration_model extends CI_Model {

	public function __construct()
	{
		$this->load->library('form_validation');
		$this->load->database();
	}
	
	public function get_rfid($rfid_id=null, $unallocated=false) {
/* 		SELECT identification_media.ID, ThirdPartyID, Name AS
		TYPE , edge_users_id, username, firstname, lastname
		FROM `identification_media`
		INNER JOIN identification_media_type ON
		TYPE = identification_media_type.ID
		LEFT JOIN people ON identification_media.ID = identification_id
		LEFT JOIN edge_users ON edge_users_id = edge_users.ID
		WHERE 1
		ORDER BY `people`.`edge_users_id` DESC
 */		
		
		// Try a query to see if a identification_media has been associated with edge_user
		$this->db->select('identification_media.ID AS ID, edge_users_id,username, firstname,lastname, active,ThirdPartyID, Name As Type');
		$this->db->from('identification_media');
		$this->db->join('identification_media_type', 'Type=identification_media_type.ID', 'inner');
		$this->db->join('people', 'identification_media.id=identification_id', 'left');
		$this->db->join('edge_users', 'edge_users.ID=edge_users_id','left');
		$this->db->order_by('ThirdPartyID', 'ASC');
		if ($unallocated) {
			$this->db->where('edge_users_id IS NULL');
		}
//		$this->db->order_by('username', 'DESC');
		if (!empty($rfid_id)) {
			$this->db->like('ThirdPartyID', $rfid_id, 'after'); 
		}
		$query = $this->db->get();		
					
		//$user_details['is_admin']=$this->ion_auth->in_group($this->config->item('admin_group', 'ion_auth'), $user_id);
		return $query;
		
	}
	
	public function add_rfid($rfid_unique_id) {
		if(!empty($rfid_unique_id)) {
			// check if is all ready in the system
			$query = $this->db->get_where('identification_media', array('ThirdPartyID' => $rfid_unique_id, 'Type'=>$this->get_rfid_type_id('RFID')));
			if ($query->num_rows()==1) {
				//$this->db->where('edge_users_id', $user_id);
	 			//if($this->db->update('people', array('identification_id'=>$identification_id)) === FALSE) return FALSE;
				return -1;
			}
			
			// Add new item
			return $this->db->insert('identification_media', array('ThirdPartyID'=> $rfid_unique_id, 'Type'=>$this->get_rfid_type_id('RFID')));
			
		}
		
		return FALSE;
	}
	
	private function get_rfid_type_id($name) {
		if (empty($name)) return null;
		
		$query = $this->db->get_where('identification_media_type', array('Name ' => $name));
		if ($query->num_rows()==1) {
			return $query->row()->ID;
		}
	}
			 
}