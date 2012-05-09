$(document).ready(function(){
    $("#test").hide('blind');
    $('#interestsTbl').hide('blind');
    $('#expertiseTbl').hide('blind');
    $('#questionsTbl').hide('blind');
    
   });


$(function() {
    $("#Heading").click(function() {
        $('#test').toggle('blind');
    });
    $("#interests").click(function() {
        $('#interestsTbl').toggle('blind');
    });
    $("#expertise").click(function() {
        $('#expertiseTbl').toggle('blind');
    });
    $("#questions").click(function() {
        $('#questionsTbl').toggle('blind');
    });
    
});

/*
 
 var interests = new Array();
var interestRows = new Array();
var profileInfo = new Object();

profileInfo.swipeID = "Mark";
profileInfo.username = "Mark";
profileInfo.interests = interests;

function addRow(tableName,sender,idType) {
	var table = document.getElementById(tableName);
	
 	//if this is the last option add a new one
	var last = document.getElementById(idType+(table.rows.length - 1));
	
	//if this is empty delete it
	if (sender.value == "" && sender.id != last.id) {
		
		var thisID = parseInt(sender.id.slice(1,sender.id.length),10);					
		var i = thisID + 1;
		table.deleteRow(thisID);
		
		while(document.getElementById(idType + i) != null) {
			var interestBox = document.getElementById(idType + i);
			interestBox.id = idType + (i - 1);
			interestBox.name = idType + (i - 1);
			i = i + 1;
		}
				
		return;
	}
	
	if(sender.id != last.id)		
		return;
	
	var rowCount = table.rows.length;
    var row = table.insertRow(rowCount);
	row.id = "row" + idType + thisID;
	row.align = "center";
 			
			
    var cell1 = row.insertCell(0);
    var element1 = document.createElement("input");
    element1.type = "text";			
	element1.name = idType+(table.rows.length - 1);	
	element1.id = idType+(table.rows.length - 1);
	
	element1.onkeyup = function() { addRow(tableName,element1,idType); };
		
    cell1.appendChild(element1);	
	setupAutoComplete(element1.id);
	
}

	
function setupAutoComplete(name) {	
	var URL = "";
	if(name.slice(0,3) == "int")
		URL = "autoInterests.php";
	if(name.slice(0,3) == "exp")
		URL = "autoExpertise.php";
	

	var options, a;
	
	jQuery(function(){	
	
		var onAutocompleteSelect = function(value, data) {
            $('#selection').html('<img src="\/global\/flags\/small\/' + data + '.png" alt="" \/> ' + value);            
        };
		
  		var options = {
            serviceUrl: URL,
            width: 200,
            delimiter: /(,|;)\s/,
            onSelect: onAutocompleteSelect,
            deferRequestBy: 0, //miliseconds            
            noCache: false //set to true, to disable caching
        };

  		a = $('#'+name).autocomplete(options);
	});
}
*/

function startup() {
	/*<?php
	for($i = 0; $i <= sizeof($interests); $i++)
		echo "setupAutoComplete('int".($i + 1)."'); ";
		
	for($i = 0; $i <= sizeof($expertise); $i++)
		echo "setupAutoComplete('exp".($i + 1)."'); ";
		
	?>*/
	//alert("Howdy Dere!");
}

