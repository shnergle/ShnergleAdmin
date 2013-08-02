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
{foreach $entries as $entry}
  <div class="panel">
    <div class="panel-heading">{$entry['name']}</div>
    <p>...</p>
    <div class="btn-group">
      <a href="/?controller={$slug}&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View Details</a>
      <a href="/?controller={$slug}&action=auth&id={$entry['id']}" class="btn btn-default btn-small">Authenticate</a>
      <a href="/?controller={$slug}&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
      <a href="/?controller={$slug}&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
    </div>
  </div>
    <ul class="list-group list-group-flush">
      {foreach $entry as $key => $value}
      <li class="list-group-item"><b>{$key}:</b> {$value}</li>
      {/foreach}
    </ul>
{/foreach}
{else}
  <p>No entries!</p>
{/if}
{/if}
{/block}
