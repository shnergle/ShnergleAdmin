{extends $template}
{block "title" prepend}Dashboard{/block}
{block "content"}
<div class="page-header">
  <h1>Dashboard</h1>
</div>
<div class="row">
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">App Versions</div>
      <div id="share-version" style="height: 300px"></div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">iPhone Models</div>
      <div id="share-model" style="height: 300px"></div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">iOS Versions</div>
      <div id="share-ios" style="height: 300px"></div>
    </div>
  </div>
</div>
<script type="text/javascript">
$(document).ready(function(){
  var version = [
    ['1.0', 100]
  ];
  jQuery.jqplot ('share-version', [version],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          sliceMargin: 4
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
  var model = [
    ['4', 1], ['4s', 3], ['5', 1]
  ];
  jQuery.jqplot ('share-model', [model],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          sliceMargin: 4
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
  var ios = [
    ['6.1.3', 2], ['6.1.4', 1], ['7.0', 2]
  ];
  jQuery.jqplot ('share-ios', [ios],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          sliceMargin: 4
        }
      },
      legend: { show:true, location: 'e' }
    }
  );
});
</script>
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
