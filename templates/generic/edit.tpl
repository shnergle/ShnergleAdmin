{extends $template}
{block "title" prepend}{$controller}: View{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: View</h1>
</div>
<form action="/?controller={$slug}&action={$action}_action{if !empty($params['id'])}&id={$id}{/if}">
  {if $action eq 'edit'}
    {foreach $entry as $key => $value}
      <label for="{$key}">{$key}</label>
      <input type="text" value="{$value}" id="{$key}" name="{$key}">
    {/foreach}
  {else}
    {foreach $columns as $column}
      <label for="{$column}">{$column}</label>
      <input type="text" id="{$column}" name="{$column}">
    {/foreach}
  {/if}
  <p>&nbsp;</p>
  <div class="btn-group" style="float: right">
    <button type="reset" class="btn btn-danger">Reset</button>
    <button type="submit" class="btn btn-success">Save</button>
  </div>
</form>
{/block}
