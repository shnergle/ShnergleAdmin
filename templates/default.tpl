<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>{block "title"} - ShnergleAdmin{/block}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="/favicon.ico">
    <link href="/css/application.css" rel="stylesheet" type="text/css">
  </head>
  <body class="{$controller} {$action}">
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">ShnergleAdmin</a>
        {if $auth}
          <div class="nav-collapse collapse">
            <ul class="nav navbar-nav">
              <li>
                <a href="/">Dashboard</a>
              </li>
              <li>
                <a href="/?controller=user">Users</a>
              </li>
              <li>
                <a href="/?controller=venue">Venues</a>
              </li>
              <li>
                <a href="#">Images</a>
              </li>
            </ul>
            <ul class="nav navbar-nav pull-right">
              <li>
                <a href="/?controller=main&action=logout">Log Out</a>
              </li>
            </ul>
          </div>
        {/if}
      </div>
    </div>
    <div class="container">
      {if isset($flash)}
        <div class="alert {if isset($flashtype)}alert-{$flashtype}{/if}">
          {$flash}
        </div>
      {/if}
      {block "content"}{/block}
    </div>
    <script src="/js/jquery.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
  </body>
</html>
