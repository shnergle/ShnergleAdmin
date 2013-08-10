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
{literal}
<script type="text/javascript">
$(document).ready(function(){
  var version = [
    ['1.0', 100]
  ];
  var total = 0;
  $(version).map(function(){total += this[1];})
  myLabels = $.makeArray($(version).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot1 = jQuery.jqplot ('share-version', [version],
    {
      grid: {
                  drawBorder: false,
                  drawGridlines: false,
                  background: '#ffffff',
                  shadow:false
              },
        seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          dataLabels: myLabels
        }
      }
    }
  );
  var model = [
    ['4', 1], ['4S', 3], ['5', 1]
  ];
  var total = 0;
  $(model).map(function(){total += this[1];})
  myLabels = $.makeArray($(model).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot2 = jQuery.jqplot ('share-model', [model],
    {
      grid: {
                  drawBorder: false,
                  drawGridlines: false,
                  background: '#ffffff',
                  shadow:false
              },
        seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          dataLabels: myLabels
        }
      }
    }
  );
  var ios = [
    ['6.1.3', 2], ['6.1.4', 1], ['7.0', 2]
  ];
  var total = 0;
  $(ios).map(function(){total += this[1];})
  myLabels = $.makeArray($(ios).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot3 = jQuery.jqplot ('share-ios', [ios],
    {
      grid: {
                  drawBorder: false,
                  drawGridlines: false,
                  background: '#ffffff',
                  shadow:false
              },
        seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true,
          dataLabels: myLabels
        }
      }
    }
  );
  $(window).resize(function() {
        plot1.replot( { resetAxes: true } );
        plot2.replot( { resetAxes: true } );
        plot3.replot( { resetAxes: true } );
  });
});
</script>
{/literal}
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
