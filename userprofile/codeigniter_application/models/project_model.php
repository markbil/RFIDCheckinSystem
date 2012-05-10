<?php

class Project_model extends CI_Model {

	public function __construct()
	{
		$this->load->database();
	}
	
	public function get_project_listings() {
		$this->db->select('ID, Name, Description')
		->order_by('Name','ASC');
		$query = $this->db->get('projects');
		return $query->result_array();
	}
	
	public function get_project_details($id)
	{	
		$this->db->select('ID, Name, Description');
		return $this->db->get_where('projects', array('ID' => $id));
	}
	
	// get number of Projects in database
	public function count_all(){
		return $this->db->count_all('projects');
	}
	// get Projects with paging
	public function get_paged_list($limit = 10, $offset = 0){
		$this->db->order_by('id','asc');
		return $this->db->get('projects', $limit, $offset);
	}
		
	// add new Project
	public function create($project_details){
		$this->db->insert('projects', $project_details);
		return $this->db->insert_id();
	}
	// update Project by id
	public function update($id, $project_details){
		$this->db->where('id', $id);
		$this->db->update('projects', $project_details);
		return $this->get_project_details($id);
	}
	// delete Project by id
	public function delete($id){
		$this->db->where('id', $id);
		return $this->db->delete('projects');
	}
	
	public function get_user_list($project_id) {
		// get matching edge_users
		$this->db->select('ID, edge_users_id');
		$user_ids= $this->db->get_where('projects_edge_users', array('project_id' => $project_id))->result_array();
		$collaborators = array();
		foreach ($user_ids as $row) {
			// Get user user_names
			$this->db->select('ID, username');
			$user_detail = $this->db->get_where('edge_users', array('ID' => $row['edge_users_id']))->row_array();
			$collaborators[$row['ID']] = $user_detail['username'];
		}
		
		return $collaborators;
	}
	
	public function get_collaborators($project_id) {
		// get matching edge_users
		$this->db->select('ID, edge_users_id');
		$user_ids= $this->db->get_where('projects_edge_users', array('project_id' => $project_id))->result_array();
		$collaborators = array();
		foreach ($user_ids as $row) {
			// Get user user_names
			$this->db->select('ID, username');
			$user_detail = $this->db->get_where('edge_users', array('ID' => $row['edge_users_id']))->row_array();
			$collaborators[$row['ID']] = $user_detail['username'];
		}
		
		return $collaborators;
	}
		
}