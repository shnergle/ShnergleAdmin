{extends $template}
{block "title" prepend}Dashboard{/block}
{block "content"}
<div class="page-header">
  <h1>Dashboard</h1>
</div>
<table class="table table-striped table-bordered">
  <tr>
    <th style="width: 50%">Awaiting Email Verification</th>
    <th style="width: 50%">Awaiting Authentication</th>
  </tr>
  {for $i=0 to $waitingVenues - 1}
    <tr>
      <td>{if isset($waitingVenuesEmail[$i])}<a href="/?controller=venues&venue-id={$waitingVenuesEmail[$i]['id']}">{$waitingVenuesEmail[$i]['name']}</a>{/if}</td>
      <td>{if isset($waitingVenuesAuth[$i])}<a href="/?controller=venues&venue-id={$waitingVenuesAuth[$i]['id']}">{$waitingVenuesAuth[$i]['name']}</a>{/if}</td>
    </tr>
  {/for}
</table>
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
<div class="row">
  <div class="col-lg-12">
    <div class="panel">
      <div class="panel-heading">Categories</div>
      <div id="categories" style="height: 300px"></div>
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
    {/literal}{foreach $iphone_models as $iphone_model => $no}['{$iphone_models}', {$no}], {/foreach}{literal}
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
    {/literal}{foreach $ios_versions as $ios_version => $no}['{$ios_version}', {$no}], {/foreach}{literal}
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
  var languages = [
    {/literal}{foreach $languages as $language}['{$languages_h[$language['language']]}', {$language['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(languages).map(function(){total += this[1];})
  myLabels = $.makeArray($(languages).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot4 = jQuery.jqplot ('languages', [languages],
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
  var countries = [
    {/literal}{foreach $countries as $country}['{$country['country']|upper}', {$country['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(countries).map(function(){total += this[1];})
  myLabels = $.makeArray($(countries).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot5 = jQuery.jqplot ('countries', [countries],
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
  var gender = [
    {/literal}{foreach $gender as $g}['{$gender_h[$g['gender']]}', {$g['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(gender).map(function(){total += this[1];})
  myLabels = $.makeArray($(gender).map(function(){return "<b>" + this[0] + "</b> " + Math.round(this[1]/total * 100) + "%";}));
  var plot6 = jQuery.jqplot ('gender', [gender],
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
  var categories = [
    {/literal}{foreach $categories as $c}['{$categories_h[$c['category_id']]}', {$c['no']}], {/foreach}{literal}
  ];
  var total = 0;
  $(categories).map(function(){total += this[1];})
  catdata = $.makeArray($(categories).map(function(){return Math.round(this[1]/total * 100);}));
  myLabels = $.makeArray($(categories).map(function(){return this[0];}));
  var plot7 = jQuery.jqplot ('categories', [catdata],
    {
      seriesDefaults: {
        renderer: jQuery.jqplot.BarRenderer,
        pointLabels: {show: true, formatString: '%d%%'}
      },
      axes: {
        xaxis: { 
          renderer: $.jqplot.CategoryAxisRenderer,
          tickRenderer: $.jqplot.CanvasAxisTickRenderer,
          ticks: myLabels,
          tickOptions: {
            angle: -45
          }
        }
      }
    }
  );
  $(window).resize(function() {
        plot1.replot( { resetAxes: true } );
        plot2.replot( { resetAxes: true } );
        plot3.replot( { resetAxes: true } );
        plot4.replot( { resetAxes: true } );
        plot5.replot( { resetAxes: true } );
        plot6.replot( { resetAxes: true } );
        plot7.replot( { resetAxes: true } );
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
