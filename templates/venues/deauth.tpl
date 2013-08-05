{extends $template}
{block "title" prepend}{$controller}: Delete{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: Make Unoffical</h1>
</div>
<p>Do you really want to make this {$slug} with id {$params['id']} unofficial? All managers and staff should be deleted manually.</p>
<div class="btn-group" style="float: right">
  <a href="javascript:history.go(-1)" class="btn btn-default">No</a>
  <a href="/?controller={$slug}&action=deauth_action&id={$params['id']}" class="btn btn-danger">Yes</a>
</div>
{/block}
