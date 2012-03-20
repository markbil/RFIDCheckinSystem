import de.bezier.data.sql.*;

// created 2005-05-10 by fjenett
// updated fjenett 20080605


MySQL dbconnection;
MySQL dbconnection_exp;
MySQL dbconnection_int;
MySQL dbconnection_quest;

//SQL-QUERIES
//get all expertise keywords
String expertise_all = "SELECT expertise, COUNT(expertise) AS frequency FROM expertise_table GROUP BY expertise ORDER BY frequency DESC";
//get all interest keywords
String interests_all = "SELECT interest, COUNT(interest) AS frequency FROM interest_table GROUP BY interest ORDER BY frequency DESC";
//get all interest keywords
String questions_all = "SELECT question, COUNT(question) AS frequency FROM questions_table GROUP BY question ORDER BY frequency DESC";

// get all checked-in users with user_details and checkin details (user id, firstname, lastname, identification_media_type and id, timestamp, sublimation)
String users_checkedin = "SELECT eu.id AS edge_user_id, eu.firstname, eu.lastname, imt.name AS imt_name, im.ThirdPartyID AS im_id, check_in.check_in_time AS checkin_timestamp, check_in.sublocation AS checkin_sublocation FROM (((identification_media im JOIN identification_media_type imt ON im.type = imt.id) JOIN people ON people.identification_id = im.id) JOIN edge_users eu ON eu.id = people.edge_users_id) JOIN check_in ON check_in.identification_media_type_id = imt.id AND check_in.identification_media_thirdpartyid = im.thirdpartyid";

// get all expertise keywords from a particular checked_in user (im.thirdpartyid)
String expertise_user_checkedin = "SELECT et.expertise FROM (((((identification_media im JOIN identification_media_type imt ON im.type = imt.id) JOIN people ON people.identification_id = im.id) JOIN edge_users eu ON eu.id = people.edge_users_id) JOIN check_in ON (check_in.identification_media_type_id = imt.id AND check_in.identification_media_thirdpartyid = im.thirdpartyid)) JOIN expertise_table et ON et.edge_users_id = eu.id) WHERE eu.id = "; //+ 28

//...alternatively use edge_user_id to filter a particular user
//WHERE eu.id = 28 instead of
//WHERE im.thirdpartyid = 5408543
//WHERE im.thirdpartyid = 123456

// get all interest keywords from a particular checked_in user
String interests_user_checkedin = "SELECT it.interest FROM (((((identification_media im JOIN identification_media_type imt ON im.type = imt.id) JOIN people ON people.identification_id = im.id) JOIN edge_users eu ON eu.id = people.edge_users_id) JOIN check_in ON (check_in.identification_media_type_id = imt.id AND check_in.identification_media_thirdpartyid = im.thirdpartyid)) JOIN interest_table it ON it.edge_users_id = eu.id) WHERE eu.id = ";

// get all questions from a particular checked_in user
String questions_user_checkedin = "SELECT qt.question FROM (((((identification_media im JOIN identification_media_type imt ON im.type = imt.id) JOIN people ON people.identification_id = im.id) JOIN edge_users eu ON eu.id = people.edge_users_id) JOIN check_in ON (check_in.identification_media_type_id = imt.id AND check_in.identification_media_thirdpartyid = im.thirdpartyid)) JOIN questions_table qt ON qt.edge_users_id = eu.id) WHERE eu.id = ";

//mysql-account
String user     = "root";
String pass     = "";
String database = "meetmee_checkin3";
	
// name of the table that will be created
String table    = "";

void setup()
{
    size( 100, 100 );
    getUserData();
    
}

void draw()
{
    // i know this is not really a visual sketch ...
}

//gets user data from all checked-in users and stores them in local array variables
void getUserData()
{

  // connect to database of server "localhost"
    dbconnection = new MySQL( this, "localhost", database, user, pass );
    
    if ( dbconnection.connect() )
    {
      
        userCard = new UserCard[0]; 
        // now read it back out
        dbconnection.query(users_checkedin);
        while (dbconnection.next())
        {
            String edge_user_id = dbconnection.getString("edge_user_id");
            String firstname = dbconnection.getString("firstname");
            String lastname = dbconnection.getString("lastname");
            String timestamp = dbconnection.getString("checkin_timestamp");
            String sublocation = dbconnection.getString("checkin_sublocation");
            println(firstname + " \t " + lastname + " \t " + timestamp + " \t " + sublocation);
            
                dbconnection_exp = new MySQL( this, "localhost", database, user, pass ); 
                if ( dbconnection_exp.connect() ){
                    dbconnection_exp.query(expertise_user_checkedin + edge_user_id);
                    while (dbconnection_exp.next()){
                        String expertise = dbconnection_exp.getString("expertise");
                        println(expertise);
                    }
                }
                else{
                    println("mysql connection failed: expertise");
                }
                
                dbconnection_int = new MySQL( this, "localhost", database, user, pass ); 
                if ( dbconnection_int.connect() ){
                    dbconnection_int.query(interests_user_checkedin + edge_user_id);
                    while (dbconnection_int.next()){
                        String interest = dbconnection_int.getString("interest");
                        println(interest);
                    }
                }
                else{
                    println("mysql connection failed: interests");
                }
                
                dbconnection_quest = new MySQL( this, "localhost", database, user, pass ); 
                if ( dbconnection_quest.connect() ){
                    dbconnection_quest.query(questions_user_checkedin + edge_user_id);
                    while (dbconnection_quest.next()){
                        String questions = dbconnection_quest.getString("question");
                        println(questions);
                    }
                }
                else{
                    println("mysql connection failed: questions");
                }
                
                userCard.append = new UserCard(firstname, lastname, timestamp,sublocation,["expertise1","expertise1"],["interest1","interest2"],["questions1","questions2"]);
                println(userCard);
        }

    }
    else
    {
        // connection failed !
        println("mysql connection failed: users_checkedin");
    }
  
}

