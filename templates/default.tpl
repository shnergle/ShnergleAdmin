<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>{block "title"} - ShnergleAdmin{/block}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css">
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond/respond.min.js"></script>
    <![endif]-->
    <link rel="shortcut icon" href="/favicon.ico">
    <link href="/css/application.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" hrf="/css/jquery.jqplot.min.css" />
    <script src="/js/jquery.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.pieRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.donutRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.barRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.dateAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.pointLabels.min.js"></script>
  </head>
  <body class="{$slug} {$action}">
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">ShnergleAdmin</a>
      </div>
      {if $auth}
      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li{if strpos($slug, 'post', 0) === 0} class="active"{/if}>
            <a href="/?controller=posts">Posts</a>
          </li>
          <li{if strpos($slug, 'promotion', 0) === 0} class="active"{/if}>
            <a href="/?controller=promotions">Promotions</a>
          </li>
          <li{if strpos($slug, 'users', 0) === 0} class="active"{/if}>
            <a href="/?controller=users">Users</a>
          </li>
          <li{if strpos($slug, 'user_searches', 0) === 0} class="active"{/if}>
            <a href="/?controller=user_searches">Searches</a>
          </li>
          <li{if strpos($slug, 'venue', 0) === 0} class="active"{/if}>
            <a href="/?controller=venues">Venues</a>
          </li>
          <li{if strpos($slug, 'image', 0) === 0} class="active"{/if}>
            <a href="/?controller=images">Images</a>
          </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <li><a href="/?controller=main&action=logout">Log Out</a></li>
        </ul>
      </div>
      {/if}
    </nav>
    <div class="container">
      {if isset($flash)}
        <div class="alert {if isset($flashtype)}alert-{$flashtype}{/if}">
          {$flash}
        </div>
      {/if}
      {if strpos($slug, 'venue', 0) === 0}
        <ul class="nav nav-tabs nav-justified">
          <li{if $slug eq 'venues'} class="active"{/if}>
            <a href="/?controller=venues">Venues</a>
          </li>
          <li{if $slug eq 'venue_managers'} class="active"{/if}>
            <a href="/?controller=venue_managers">VenueManagers</a>
          </li>
          <li{if $slug eq 'venue_staff'} class="active"{/if}>
            <a href="/?controller=venue_staff">VenueStaff</a>
          </li>
        </ul>
      {/if}
      {block "content"}{/block}
    </div>
  </body>
</html>
