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
    <link rel="stylesheet" type="text/css" hrf="/css/jquery.jqplot.min.css" />
  </head>
  <body class="{$slug} {$action}">
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">ShnergleAdmin</a>
        {if $auth}
          <div class="nav-collapse collapse">
            <ul class="nav navbar-nav">
              <li{if strpos($slug, 'media', 0) === 0} class="active"{/if}>
                <a href="/?controller=media">Media</a>
              </li>
              <li{if strpos($slug, 'post', 0) === 0} class="active"{/if}>
                <a href="/?controller=posts">Posts</a>
              </li>
              <li{if strpos($slug, 'promotion', 0) === 0} class="active"{/if}>
                <a href="/?controller=promotions">Promotions</a>
              </li>
              <li{if strpos($slug, 'user', 0) === 0} class="active"{/if}>
                <a href="/?controller=users">Users</a>
              </li>
              <li{if strpos($slug, 'venue', 0) === 0} class="active"{/if}>
                <a href="/?controller=venues">Venues</a>
              </li>
              <li{if strpos($slug, 'image', 0) === 0} class="active"{/if}>
                <a href="/?controller=images">Images</a>
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
      {if strpos($slug, 'post', 0) === 0}
        <ul class="nav nav-tabs nav-justified">
          <li{if $slug eq 'posts'} class="active"{/if}>
            <a href="/?controller=posts">Posts</a>
          </li>
          <li{if $slug eq 'post_likes'} class="active"{/if}>
            <a href="/?controller=post_likes">PostLikes</a>
          </li>
          <li{if $slug eq 'post_reports'} class="active"{/if}>
            <a href="/?controller=post_reports">PostReports</a>
          </li>
          <li{if $slug eq 'post_shares'} class="active"{/if}>
            <a href="/?controller=post_shares">PostShares</a>
          </li>
          <li{if $slug eq 'post_views'} class="active"{/if}>
            <a href="/?controller=post_views">PostViews</a>
          </li>
        </ul>
      {elseif strpos($slug, 'promotion', 0) === 0}
        <ul class="nav nav-tabs nav-justified">
          <li{if $slug eq 'promotions'} class="active"{/if}>
            <a href="/?controller=promotions">Promotions</a>
          </li>
          <li{if $slug eq 'promotion_redemptions'} class="active"{/if}>
            <a href="/?controller=promotion_redemptions">PromotionRedemptions</a>
          </li>
        </ul>
      {elseif strpos($slug, 'user', 0) === 0}
        <ul class="nav nav-tabs nav-justified">
          <li{if $slug eq 'users'} class="active"{/if}>
            <a href="/?controller=users">Users</a>
          </li>
          <li{if $slug eq 'user_searches'} class="active"{/if}>
            <a href="/?controller=user_searches">UserSearches</a>
          </li>
        </ul>
      {elseif strpos($slug, 'venue', 0) === 0}
        <ul class="nav nav-tabs nav-justified">
          <li{if $slug eq 'venues'} class="active"{/if}>
            <a href="/?controller=venues">Venues</a>
          </li>
          <li{if $slug eq 'venue_categories'} class="active"{/if}>
            <a href="/?controller=venue_categories">VenueCategories</a>
          </li>
          <li{if $slug eq 'venue_comments'} class="active"{/if}>
            <a href="/?controller=venue_comments">VenueComments</a>
          </li>
          <li{if $slug eq 'venue_followers'} class="active"{/if}>
            <a href="/?controller=venue_followers">VenueFollowers</a>
          </li>
          <li{if $slug eq 'venue_loads'} class="active"{/if}>
            <a href="/?controller=venue_loads">VenueLoads</a>
          </li>
          <li{if $slug eq 'venue_managers'} class="active"{/if}>
            <a href="/?controller=venue_managers">VenueManagers</a>
          </li>
          <li{if $slug eq 'venue_rsvps'} class="active"{/if}>
            <a href="/?controller=venue_rsvps">VenueRsvps</a>
          </li>
          <li{if $slug eq 'venue_shares'} class="active"{/if}>
            <a href="/?controller=venue_shares">VenueShares</a>
          </li>
          <li{if $slug eq 'venue_staff'} class="active"{/if}>
            <a href="/?controller=venue_staff">VenueStaff</a>
          </li>
          <li{if $slug eq 'venue_views'} class="active"{/if}>
            <a href="/?controller=venue_views">VenueViews</a>
          </li>
        </ul>
      {/if}
      {block "content"}{/block}
    </div>
    <script src="/js/jquery.js" type="text/javascript"></script>
    <script src="/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="/js/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.pieRenderer.min.js"></script>
    <script type="text/javascript" src="/js/plugins/jqplot.donutRenderer.min.js"></script>
  </body>
</html>
