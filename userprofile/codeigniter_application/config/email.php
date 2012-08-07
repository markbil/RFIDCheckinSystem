<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config=array(
					'useragent' => 'CodeIgniter',
					'protocol' => 'mail',
					'mailpath' => '/usr/sbin/sendmail',
					'smtp_host' => '',
					'smtp_user' => '',
					'smtp_pass' => '',
					'smtp_port' => '25',
					'smtp_timeout' => '5',
					'wordwrap' => TRUE,
					'wrapchars' => 76,
					'mailtype' => 'text',
					'charset' => 'utf-8',
					'validate' => FALSE,
					'priority' => 3,
					'crlf' => '\r\n',
					'newline' => '\r\n',
					'bcc_batch_mode' => FALSE,
					'bcc_batch_size' => 200
		);
