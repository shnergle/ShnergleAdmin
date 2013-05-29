{extends $template}
{block "title" prepend}Users{/block}
{block "content"}
<div class="page-header">
  <h1>Users</h1>
</div>
<table class="table table-striped table-bordered">
    <tr>
      <th>ID</th>
      <th>Facebook ID</th>
    </tr>
  {foreach $entries as $entry}
    <tr>
      <td>{$entry['id']}</td>
      <td>{$entry['facebook_id']}</td>
    </tr>
  {/foreach}
</table>
{/block}
