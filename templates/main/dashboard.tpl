{extends $template}
{block "title" prepend}Dashboard{/block}
{block "content"}
<div class="page-header">
  <h1>Dashboard</h1>
</div>
<table class="table table-striped table-bordered">
  <tr>
    <th>Table</th>
    <th>Entries</th>
  </tr>
  {foreach $counts as $key => $value}
    <tr>
      <td>{$key}</td>
      <td>{$value}</td>
    </tr>
  {/foreach}
</table>
{/block}
