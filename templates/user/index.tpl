{extends $template}
{block "title" prepend}Users{/block}
{block "content"}
<div class="page-header">
  <h1>Users</h1>
</div>
<button type="button" class="btn btn-success">Success</button>
<table class="table table-striped table-bordered">
  <tr>
    <th>ID</th>
    <th>Facebook ID</th>
  </tr>
  {foreach $entries as $entry}
    <tr>
      <td>{$entry['id']}</td>
      <td>{$entry['facebook_id']}</td>
      <td>
        <div class="btn-group">
          <a href="/?controller=user&action=view&id={$entry['id']}" class="btn btn-primary btn-small">View</button>
          <a href="/?controller=user&action=edit&id={$entry['id']}" class="btn btn-warning btn-small">Edit</button>
          <a href="/?controller=user&action=delete&id={$entry['id']}" class="btn btn-danger btn-small">Delete</button>
        </div>
      </td>
    </tr>
  {/foreach}
</table>
{/block}
