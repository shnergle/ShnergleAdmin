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
  <div style="overflow-x: auto">
    <table class="table table-striped table-bordered">
      {block "specific"}
        <tr>
          {foreach $entries[0] as $key => $value}
            <th>{$key}</th>
          {/foreach}
          <th>Actions</th>
        </tr>
        {foreach $entries as $entry}
          <tr>
            {foreach $entry as $value}
              <td>{$value}</td>
            {/foreach}
            <td>
              <div class="btn-group">
                <a href="/?controller={$slug}&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View</a>
                <a href="/?controller={$slug}&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
                <a href="/?controller={$slug}&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
              </div>
            </td>
          </tr>
        {/foreach}
      {/block}
    </table>
  </div>
  <div style="text-align: center">
    <ul class="pagination">
      {if $page lt 2}
        <li class="disabled"><span>&laquo;</span></li>
      {else}
        <li><a href="/?controller={$slug}&page={$page - 1}">&laquo;</a></li>
      {/if}
      {for $i=1 to $pages}
        <li{if $i eq $page} class="active"{/if}>
          <a href="/?controller={$slug}&page={$i}">{$i}</a>
        </li>
      {/for}
      {if $page gte $pages}
        <li class="disabled"><span>&raquo;</span></li>
      {else}
        <li><a href="/?controller={$slug}&page={$page + 1}">&raquo;</a></li>
      {/if}
    </ul>
  </div>
{else}
  <p>No entries!</p>
{/if}
{/if}
{/block}
