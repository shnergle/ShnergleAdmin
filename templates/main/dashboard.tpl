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
<div class="row">
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">Languages</div>
      <div id="languages" style="height: 300px"></div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">Countries</div>
      <div id="countries" style="height: 300px"></div>
    </div>
  </div>
  <div class="col-lg-4">
    <div class="panel">
      <div class="panel-heading">Gender</div>
      <div id="gender" style="height: 300px"></div>
    </div>
  </div>
</div>
{literal}
<script type="text/javascript">
$(document).ready(function(){
  var version = [
    {/literal}{foreach $app_versions as $app_version}['{$app_version['app_version']}', {$app_version['no']}], {/foreach}{literal}
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
    {/literal}{foreach $iphone_models as $iphone_model}['{$iphone_model['iphone_model']}', {$iphone_model['no']}], {/foreach}{literal}
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
    {/literal}{foreach $ios_versions as $ios_version}['{$ios_version['ios_version']}', {$ios_version['no']}], {/foreach}{literal}
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
  var languages = [
    {/literal}{foreach $languages as $language}['{$language['language']}', {$language['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(languages).map(function(){total += this[1];})
  myLabels = $.makeArray($(languages).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot3 = jQuery.jqplot ('languages', [languages],
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
  var countries = [
    {/literal}{foreach $countries as $country}['{$country['country']}', {$country['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(countries).map(function(){total += this[1];})
  myLabels = $.makeArray($(countries).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot3 = jQuery.jqplot ('countries', [countries],
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
  var gender = [
    {/literal}{foreach $gender as $g}['{$g['gender']}', {$g['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(gender).map(function(){total += this[1];})
  myLabels = $.makeArray($(gender).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot3 = jQuery.jqplot ('gender', [gender],
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
