{extends $template}
{block "title" prepend}{$controller}: Delete{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: Authenticate</h1>
</div>
<p>Do you really want to authenticate this {$slug} with id {$params['id']}?</p>
<div class="btn-group" style="float: right">
  <a href="javascript:history.go(-1)" class="btn btn-default">No</a>
  <a href="/?controller={$slug}&action=auth_action&id={$params['id']}" class="btn btn-danger">Yes</a>
</div>
{/block}
