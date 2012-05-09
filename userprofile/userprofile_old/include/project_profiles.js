/* Javascript Functions used to create and modify Projects
 * and add and remove associated Users
 * 
 * */
function getUsers(projectID) {
			$.post("include/common.php", {queryString: "list_project_users" + '=' + projectID }, 
					function(data){
						if(data.length >0) {
							$('#user_listing').html(data);
						}
							
					}
				);
	}
	
	function selectUsers(projectID) {
		//var projectID=document.getElementById("project_id").value;
		$.post("include/common.php", {queryString: "select_project_users" + '=' + projectID }, 
				function(data){
					if(data.length >0) {
						$('#user_listing').html(data);
					}
				}
			);
	}
	
	function saveUsers(projectID) {
		//var projectID=document.getElementById("project_id").value;
		var user_tags=document.getElementById("user_listing").getElementsByTagName('input');
		
		var user_list=null;
		for(var i=0;i<user_tags.length;i++) {
			if (user_tags[i].checked  && user_tags[i].type=='checkbox') {
				if (user_list == null)
					user_list=user_tags[i].value + ',';
				else
					user_list = user_list + user_tags[i].value + ',';
			}
		}

		$.post("include/common.php", {queryString: "add_project_users" + '=' + projectID + '=' + user_list}, 
				function(data){
					if(data.length >0) {
						$('#user_listing').html(data);
					}
				}
			);
	}
	
	function removeUsers(projectID) {
		var user_tags=document.getElementById("user_listing").getElementsByTagName('input');
		
		var user_list=null;
		for(var i=0;i<user_tags.length;i++) {
			if (!user_tags[i].checked && user_tags[i].type=='checkbox') {
				if (user_list == null)
					user_list=user_tags[i].value + ',';
				else
					user_list = user_list + user_tags[i].value + ',';
			}
		}

		$.post("include/common.php", {queryString: "remove_project_users" + '=' + projectID + '=' + user_list}, 
				function(data){
					if(data.length >0) {
						$('#user_listing').html(data);
					}
				}
			);
	}