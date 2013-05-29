{extends '../default.tpl'}
{block "title" append}Dashboard{/block}
{block "content"}
<div class="alert alert-danger">...</div>
<div class="alert alert-success">...</div>
<div class="alert alert-info">...</div>
		<div class="page-header">
		  <h1>Dashboard</h1>
		</div>
		<table class="table table-striped table-bordered">
		<tr>
			<th>ID</th>
			<th>Name</th>
		</tr>
		<tr>
			<td>1</td>
			<td>Max</td>
		</tr>
	</table>
	<form>
		<div class="page-header">
		  <h1>Form</h1>
		</div>
	  <fieldset>
	    <legend>Basic</legend>
	    <label>ID</label>
	    <input type="text" placeholder="1">
	    <p class="help-block">No need to change</p>
	    <label>Name</label>
	    <input type="text" placeholder="Max">
	    <p class="help-block">Full Name</p>
	    <button type="submit" class="btn btn-default">Submit</button>
	  </fieldset>
	</form>
{/block}
