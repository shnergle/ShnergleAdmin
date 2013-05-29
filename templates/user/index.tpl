{extends $template}
{block "title" prepend}Users{/block}
{block "content"}
<div class="page-header">
  <h1>Users</h1>
</div>
<p style="text-align: right">
  <a href="/?controller=user&action=add" class="btn btn-success">New</a>
</p>
<table class="table table-striped table-bordered">
  <tr>
    <th>ID</th>
    <th>Facebook ID</th>
    <th>Actions</th>
  </tr>
  {foreach $entries as $entry}
    <tr>
      <td>{$entry['id']}</td>
      <td>{$entry['facebook_id']}</td>
      <td>
        <div class="btn-group">
          <a href="/?controller=user&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View</a>
          <a href="/?controller=user&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</a>
          <a href="/?controller=user&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</a>
        </div>
      </td>
    </tr>
  {/foreach}
</table>
<ul class="pagination" style="margin-left: auto; margin-right: auto">
  <li><a href="#">&laquo;</a></li>
  <li><a href="#">1</a></li>
  <li><a href="#">2</a></li>
  <li><a href="#" class="active">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#">&raquo;</a></li>
</ul>
{/block}
