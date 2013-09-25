{extends $template}
{block "title" prepend}{$controller}{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}</h1>
</div>
<div>
  <form method="get" action="/" class="form-inline">
    <input type="hidden" name="controller" value="{$slug}">
    <input type="text" class="form-control" placeholder="Venue Name" name="venue-search" style="width: 250px;">
    <input type="text" class="form-control" placeholder="Staff Name" name="staff-search" style="width: 250px;">
    <label class="radio-inline">
      <input type="radio" name="type-search" value="all" checked> All
    </label>
    <label class="radio-inline">
      <input type="radio" name="type-search" value="to-auth"> Awaiting Authentication
    </label>
    <label class="radio-inline">
      <input type="radio" name="type-search" value="to-veri"> Outstanding Email Verification
    </label>
    <label class="radio-inline">
      <input type="radio" name="type-search" value="no-twitter"> No Twitter Handle
    </label>
    <button type="submit" class="btn btn-default">Find</button>
  </form>
</div>
<p style="text-align: right">
  <a href="/?controller={$slug}&action=add" class="btn btn-success">New</a>
</p>
{if $search}
{if $entries}
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
{foreach $entries as $entry}
  <div class="panel">
    <div class="panel-heading"><b>{$entry['name']}</b> {if $entry['official'] eq 1}<span class="label label-success"><span class="glyphicon glyphicon-ok"></span> official</span> <span class="label label-{if $entry['verified'] eq 1}success{else}danger{/if}"><span class="glyphicon glyphicon-{if $entry['verified'] eq 1}ok{else}remove{/if}"></span> verified</span>{/if}</div>
    <div style="height: 200px; width: 500px;" id="map-canvas{$entry['id']}"><p style="line-height: 200px;text-align:center;width:500px;">Click to show map</p></div>
    <form method="post" action="/?controller={$slug}&action=edit_action&id={$entry['id']}" id="mapupdate{$entry['id']}"><input type="hidden" value="{$entry['lat']}" name="lat"><input type="hidden" value="{$entry['lon']}" name="lon"><input type="submit" class="btn btn-success" value="Update coordinates"></form>
    <p>&nbsp;</p>
    {if $entry['official'] eq 1}
    <div style="width: 500px;">
      <p style="text-align: right">
        <a href="/?controller=venue_staff&action=add" class="btn btn-success btn-small">Add Staff</a>
        <a href="/?controller=venue_manager&action=add" class="btn btn-success btn-small">Add Manager</a>
      </p>
      <table class="table">
        <tr>
          <th>&nbsp;</th>
          <th>Name</th>
          <th>Status</th>
          <th>Promotion Permissions</th>
          <th>Actions</th>
        </tr>
        {foreach $entry['managers'] as $staff}
        <tr>
          <td><img class="img-thumbnail" src="http://graph.facebook.com/{$staff['facebook_id']}/picture" alt="Profile Picture" height="50"></td>
          <td>{$staff['forename']} {$staff['surname']}</td>
          <td>Manager</td>
          <td>n/a</td>
          <td>
            <div class="btn-group">
              <a href="/?controller=users&action=view&id={$staff['user_id']}" class="btn btn-primary btn-small">View</a>
              <a href="/?controller=venue_managers&action=edit&id={$staff['id']}" class="btn btn-warning btn-small">Edit</a>
              <a href="/?controller=venue_managers&action=delete&id={$staff['id']}" class="btn btn-danger btn-small">Delete</a>
            </div>
          </td>
        </tr>
        {/foreach}
        {foreach $entry['staff'] as $staff}
        <tr>
          <td><img class="img-thumbnail" src="http://graph.facebook.com/{$staff['facebook_id']}/picture" alt="Profile Picture" height="50"></td>
          <td>{$staff['forename']} {$staff['surname']}</td>
          <td>Staff</td>
          <td>{if $staff['promo_perm'] eq 0}<span class="glyphicon glyphicon-remove"></span> disabled{else}<span class="glyphicon glyphicon-ok"></span> enabled{/if}</td>
          <td>
            <div class="btn-group">
              <a href="/?controller=users&action=view&id={$staff['user_id']}" class="btn btn-primary btn-small">View</a>
              <a href="/?controller=venue_staff&action=edit&id={$staff['id']}" class="btn btn-warning btn-small">Edit</a>
              <a href="/?controller=venue_staff&action=delete&id={$staff['id']}" class="btn btn-danger btn-small">Delete</a>
            </div>
          </td>
        </tr>
        {/foreach}
      </table>
    </div>
    <p>&nbsp;</p>
    {/if}
    <div class="btn-group">
      <a href="/?controller={$slug}&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View Details</a>
      {if $entry['verified'] eq 0}
      <a href="/?controller={$slug}&action=auth&id={$entry['id']}" class="btn btn-default btn-small" {if $entry['official'] eq 0 or $entry['email_verified'] eq 0}disabled="disabled"{/if}>Authenticate</a>
      {else}
      <a href="/?controller={$slug}&action=deauth&id={$entry['id']}" class="btn btn-default btn-small">Make Unofficial</a>
      {/if}
      <a href="/?controller={$slug}&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
      <a href="/?controller={$slug}&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
    </div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item"><b>Category:</b> {$categories[$entry['category_id']]}</li>
      <li class="list-group-item"><b>Address:</b> {$entry['address']}</li>
      {if $entry['official'] eq 1}
      <li class="list-group-item"><b>Email:</b> {$entry['email']} <span class="label label-{if $entry['email_verified'] eq 1}success{else}danger{/if}"><span class="glyphicon glyphicon-{if $entry['email_verified'] eq 1}ok{else}remove{/if}"></span> verified</span></li>
      <li class="list-group-item"><b>Website:</b> {$entry['website']}</li>
      <li class="list-group-item"><b>Telephone:</b> {$entry['phone']}</li>
      {/if}
      <li class="list-group-item"><b>Loads:</b> {$entry['venue_loads']}</li>
      <li class="list-group-item"><b>Views:</b> {$entry['venue_views']}</li>
      <li class="list-group-item"><b>Posts:</b> {$entry['venue_posts']}</li>
      <li class="list-group-item"><b>Shares:</b> {$entry['venue_shares']}</li>
      <li class="list-group-item"><b>Followers:</b> {$entry['venue_followers']}</li>
      <li class="list-group-item"><b>RSVPs:</b> {$entry['venue_rsvps']}</li>
    </ul>
  </div>
    {literal}
    <script>
var map;
var loaded{/literal}{$entry['id']}{literal} = false;
function initialize() {
  if (loaded{/literal}{$entry['id']}{literal}) return;
  loaded{/literal}{$entry['id']}{literal} = true;
  var mapOptions = {
    zoom: 13,
    {/literal}
    center: new google.maps.LatLng({$entry['lat']}, {$entry['lon']}),
    {literal}
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  {/literal}
  map = new google.maps.Map(document.getElementById('map-canvas{$entry['id']}'),
      mapOptions);
      {literal}
      new google.maps.Marker({
        {/literal}
        position: new google.maps.LatLng({$entry['lat']}, {$entry['lon']}),
        {literal}
        map: map
      });

      google.maps.event.addDomListener(document.getElementById('map-canvas{/literal}{$entry['id']}{literal}'), 'click', function(event) {
  
        var marker = new google.maps.Marker({
              position: event.latLon,
              map: {/literal}document.getElementById('map-canvas{$entry['id']}'){literal}
          });
          $({/literal}'map-canvas{$entry['id']} input[name="lat"]'{literal}).val(event.latLon.lat());
          $({/literal}'map-canvas{$entry['id']} input[name="lon"]'{literal}).val(event.latLon.lon());
      });
      
}

google.maps.event.addDomListener(document.getElementById('map-canvas{/literal}{$entry['id']}{literal}'), 'click', initialize);

    </script>
    {/literal}
{/foreach}
{else}
  <p>No entries!</p>
{/if}
{else}
  <table class="table table-striped table-bordered">
    <tr>
      <th>Most Recently Checked In</th>
      <th>Time</th>
    </tr>
    {foreach $recentVenues as $venue}
      <tr>
        <td><a href="/?controller=venues&venue-id={$venue['id']}">{$venue['name']}</a></td>
        <td>{$venue['last_activity']|date_format:"d/m/Y H:i:s"}</td>
      </tr>
    {/foreach}
  </table>
{/if}
{/block}
