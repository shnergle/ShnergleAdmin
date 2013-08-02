{extends $template}
{block "title" prepend}{$controller}{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}</h1>
</div>
<div>
  <form method="post" action="/?controller={$slug}" class="form-inline">
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
    <div class="panel-heading"><b>{$entry['name']}</b> <span class="label label-{if $entry['official'] eq 1}success{else}danger{/if}">official</span> <span class="label label-{if $entry['verified'] eq 1}success{else}danger{/if}">verified</span></div>
    {literal}
    <script>
var map;
function initialize() {
  var mapOptions = {
    zoom: 8,
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
    <div class="btn-group">
      <a href="/?controller={$slug}&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View Details</a>
      <a href="/?controller={$slug}&action=auth&id={$entry['id']}" class="btn btn-default btn-small">Authenticate</a>
      <a href="/?controller={$slug}&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
      <a href="/?controller={$slug}&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
    </div>
    <ul class="list-group list-group-flush">
      <li class="list-group-item"><b>Address:</b> {$entry['address']}</li>
      <li class="list-group-item"><b>Email:</b> {$entry['email']} <span class="label label-{if $entry['email_verified'] eq 1}success{else}danger{/if}">verified</span></li>
      <li class="list-group-item"><b>Website:</b> {$entry['website']}</li>
      <li class="list-group-item"><b>Telephone:</b> {$entry['phone']}</li>
      <li class="list-group-item"><b>Facebook:</b> {$entry['facebook']}</li>
    </ul>
  </div>
{/foreach}
{else}
  <p>No entries!</p>
{/if}
{/if}
{/block}
