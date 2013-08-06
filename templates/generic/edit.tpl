{extends $template}
{block "title" prepend}{$controller}: View{/block}
{block "content"}
<div class="page-header">
  <h1>{$controller}: {if $action eq 'edit'}Edit{else}Add{/if}</h1>
</div>
<form action="/?controller={$slug}&action={$action}_action{if !empty($params['id'])}&id={$params['id']}{/if}" method="post">
  {block "specific"}
    {if $action eq 'edit'}
      {foreach $entry as $key => $value}
        <label for="{$key}">{$key}</label>
        <input type="text" value="{$value}" id="{$key}" name="{$key}" class="form-control">
      {/foreach}
    {else}
      {foreach $columns as $column}
        <label for="{$column['COLUMN_NAME']}">{$column['COLUMN_NAME']}</label>
        <input type="text" id="{$column['COLUMN_NAME']}" name="{$column['COLUMN_NAME']}" class="form-control">
      {/foreach}
    {/if}
  {/block}
  <p>&nbsp;</p>
  <div class="btn-group" style="float: right">
    <button type="reset" class="btn btn-danger">Reset</button>
    <button type="submit" class="btn btn-success">Save</button>
  </div>
</form>
{/block}
