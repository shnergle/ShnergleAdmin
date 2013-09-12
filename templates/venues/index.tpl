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
    {literal}
    <script>
var map;
function initialize() {
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
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
    {/literal}
    <div style="height: 200px; width: 500px;" id="map-canvas{$entry['id']}"></div>
    <p>&nbsp;</p>
    {if $entry['official'] eq 1}
    <div style="width: 500px;">
      <p style="text-align: right">
        <a href="/?controller=venue_staff&action=add" class="btn btn-success btn-small">Add</a>
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
              <a href="/?controller=venue_managers&action=edit&user_id={$staff['user_id']}&venue_id={$staff['venue_id']}" class="btn btn-warning btn-small">Edit</a>
              <a href="/?controller=venue_managers&action=delete&user_id={$staff['user_id']}&venue_id={$staff['venue_id']}" class="btn btn-danger btn-small">Delete</a>
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
              <a href="/?controller=venue_staff&action=edit&user_id={$staff['user_id']}&venue_id={$staff['venue_id']}" class="btn btn-warning btn-small">Edit</a>
              <a href="/?controller=venue_staff&action=delete&user_id={$staff['user_id']}&venue_id={$staff['venue_id']}" class="btn btn-danger btn-small">Delete</a>
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
    </ul>
  </div>
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
        <td><?php echo date("%d/%m/%Y %H:%i:%s", $venue['last_activity']); ?></td>
      </tr>
    {/foreach}
  </table>
{/if}
{/block}
