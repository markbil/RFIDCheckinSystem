<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/

/* $route['news/create'] = 'news/create';
$route['news/(:any)'] = 'news/view/$1';
$route['news'] = 'news';
 */

//$route['edge_user/login'] = 'edge_user/login';
$route['edge_user/feedback'] = 'edge_user/feedback';
$route['edge_user/deactivate_user'] = 'edge_user/deactivate_user';
$route['edge_user/change_password'] = 'edge_user/change_password';
$route['edge_user/forgot_password'] = 'edge_user/forgot_password';
$route['edge_user/reset_password'] = 'edge_user/reset_password';
$route['edge_user/signup'] = 'edge_user/signup';
$route['edge_user/update'] = 'edge_user/update';
$route['edge_user/profile'] = 'edge_user/profile';
$route['edge_user/logout'] = 'edge_user/logout';
$route['edge_user/create_user'] = 'edge_user/create_user';
$route['edge_user'] = 'edge_user';
$route['project/create'] = 'project/create';
$route['project/profile/(:any)'] = 'project/profile/$1';
$route['project/profile'] = 'project';
$route['project'] = 'project';
$route['(:any)'] = 'edge_user';
$route['default_controller'] = 'edge_user';

/* End of file routes.php */
/* Location: ./application/config/routes.php */