<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>ShnergleAdmin</title>
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
		<!--[if lt IE 9]>
  		  <script src="js/html5shiv.js"></script>
  		  <script src="js/respond/respond.min.js"></script>
		<![endif]-->
		<link rel="shortcut icon" href="favicon.ico">
		<style type="text/css">
		body.normal {
			padding-top: 50px;
		}
	    body.signin {
	      padding-top: 40px;
	      padding-bottom: 40px;
	      background-color: #eee;
	    }

	    .form-signin {
	      max-width: 330px;
	      padding: 15px;
	      margin: 0 auto;
	    }
	    .form-signin .form-signin-heading,
	    .form-signin .checkbox {
	      margin-bottom: 10px;
	    }
	    .form-signin .checkbox {
	      font-weight: normal;
	    }
	    .form-signin input[type="text"],
	    .form-signin input[type="password"] {
	      position: relative;
	      font-size: 16px;
	      height: auto;
	      padding: 10px;
	      -webkit-box-sizing: border-box;
	         -moz-box-sizing: border-box;
	              box-sizing: border-box;
	    }
	    .form-signin input[type="text"]:focus,
	    .form-signin input[type="password"]:focus {
	      z-index: 2;
	    }
	    .form-signin input[type="text"] {
	      margin-bottom: -1px;
	      border-bottom-left-radius: 0;
	      border-bottom-right-radius: 0;
	    }
	    .form-signin input[type="password"] {
	      margin-bottom: 10px;
	      border-top-left-radius: 0;
	      border-top-right-radius: 0;
	    }
		
		</style>
	</head>
	<body class="<?php echo $type; ?>">
		<div class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse"><span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span></button> <a class="navbar-brand" href="#">ShnergleAdmin</a>
				<div class="nav-collapse collapse">
					<ul class="nav navbar-nav">
						<li class="active">
							<a href="#">Dashboard</a>
						</li>
						<li>
							<a href="#about">Users</a>
						</li>
						<li>
							<a href="#contact">Images</a>
						</li>
						<li>
							<a href="?action=out">Log Out</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="container">