{extends $template}
{block "title" prepend}{$controller}: View{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: View</h1>
</div>
<form action="/?controller={$slug}&action={$action}_action{if !empty($params['id'])}&id={$id}{/if}">
  {foreach $entry as $key => $value}
    <label for="{$key}">{$key}</label>
    <input type="text" value="{$value}" id="{$key}" name="{$key}">
  {/foreach}
  <div class="btn-group" style="text-align: right">
    <button type="reset" class="btn btn-danger btn-small">Reset</button>
    <button type="submit" class="btn btn-success btn-small">Save</button>
  </div>
</form>
{/block}
