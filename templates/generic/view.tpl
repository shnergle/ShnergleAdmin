{extends $template}
{block "title" prepend}{$controller}: View{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: View</h1>
</div>
<table class="table table-striped table-bordered">
  {block "specific"}
    {foreach $entry as $key => $value}
      <tr>
        <th>{$key}</th>
        <td>{$value}</td>
      </tr>
    {/foreach}
  {/block}
</table>
<div class="btn-group" style="float: right">
  <a href="/?controller={$slug}&action=edit&id={$params['id']}" class="btn btn-warning">Edit</a>
  <a href="/?controller={$slug}&action=delete&id={$params['id']}" class="btn btn-danger">Delete</a>
</div>
{/block}
