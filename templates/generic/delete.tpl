{extends $template}
{block "title" prepend}{$controller}: Delete{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: Delete</h1>
</div>
<p>Do you really want to delete this {$slug} with id {$params['id']}?</p>
<div class="btn-group" style="margin-left: auto">
  <a href="javascript:history.go(-1)" class="btn btn-default">No</a>
  <a href="/?controller={$slug}&action=delete_action&id={$params['id']}" class="btn btn-danger">Yes</a>
</div>
{/block}
