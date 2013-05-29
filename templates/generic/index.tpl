{extends $template}
{block "title" prepend}{$controller}s{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}s</h1>
</div>
<p style="text-align: right">
  <a href="/?controller=user&action=add" class="btn btn-success">New</a>
</p>
{if $entries}
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
            <a href="/?controller={lower($controller)}&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View</a>
            <a href="/?controller={lower($controller)}&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
            <a href="/?controller={lower($controller)}&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
          </div>
        </td>
      </tr>
    {/foreach}
  </table>
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
