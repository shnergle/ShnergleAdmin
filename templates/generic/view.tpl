{extends $template}
{block "title" prepend}{$controller}: View{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: View</h1>
</div>
<table class="table table-striped table-bordered">
  {foreach $entry as $key => $value}
    <tr>
      <th>{$key}</th>
      <td>{$value}</td>
    </tr>
  {/foreach}
</table>
<div class="btn-group" style="margin-left: auto">
  <a href="/?controller={$slug}&action=edit&id={$params['id']}" class="btn btn-warning btn-small">Edit</a>
  <a href="/?controller={$slug}&action=delete&id={$params['id']}" class="btn btn-danger btn-small">Delete</a>
</div>
{/block}
