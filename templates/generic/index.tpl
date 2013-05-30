{extends $template}
{block "title" prepend}{$controller}{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}</h1>
</div>
<p style="text-align: right">
  <a href="/?controller={$slug}&action=add" class="btn btn-success">New</a>
</p>
{if $entries}
  <div style="overflow-x: auto">
    <table class="table table-striped table-bordered">
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
    </table>
  </div>
  <div style="text-align: center">
    <ul class="pagination">
      <li><a href="#">&laquo;</a></li>
      <li><a href="#">1</a></li>
      <li><a href="#">2</a></li>
      <li class="active"><span>3</span></li>
      <li><a href="#">4</a></li>
      <li><a href="#">5</a></li>
      <li><a href="#">&raquo;</a></li>
    </ul>
  </div>
{else}
  <p>No entries!</p>
{/if}
{/block}
