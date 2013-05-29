{extends $template}
{block "title" prepend}{$controller}{/block}
{block "content"}
<div class="page-header">
  <h1>Delete {$controller}</h1>
</div>
<p>Do you really want to delete this {$controller|lower} with id {$params['id']}?</p>
<p>
  <a href="javascript:history.go(-1)" class="btn btn-default">No</a>
  <a href="/?controller={$controller|lower}&action=delete_action&id={$params['id']}" class="btn btn-danger">Yes</a>
{/block}
