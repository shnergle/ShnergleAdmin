{extends $template}
{block "title" prepend}User{/block}
{block "content"}
<div class="page-header">
  <h1>User</h1>
</div>
<table class="table table-striped table-bordered">
  {foreach $entry as $value}
    <tr>
      <td>{$value@key}</td>
      <td>{$value}</td>
    </tr>
  {/foreach}
</table>
<div class="btn-group">
  <a href="/?controller=user&action=index&id={$params->id}" class="btn btn-primary btn-small">Overview</a>
  <a href="/?controller=user&action=edit&id={$params->id}" class="btn btn-warning btn-small">Edit</a>
  <a href="/?controller=user&action=delete&id={$params->id}" class="btn btn-danger btn-small">Delete</a>
</div>
{/block}
