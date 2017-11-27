<%
    ui.decorateWith("appui", "standardEmrPage", [title: "View Drug Stock"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
	ui.includeJavascript("mdrtbdashboard", "jq.print.js")
%>

<script>
    jq(function (){
		jq('.cancel').click(function(){
			window.location = "main.page";
		});
		
		jq('.task').click(function(){
			jq("#print-section").print({
				globalStyles: 	false,
				mediaPrint: 	false,
				stylesheet: 	'${ui.resourceLink("inventoryapp", "styles/print-out.css")}',
				iframe: 		false,
				width: 			980,
				height:			700
			});
		});
    });
</script>

<style>
	.new-patient-header .identifiers {
		margin-top: 5px;
	}
	.name {
		color: #f26522;
	}
	#inline-tabs{
		background: #f9f9f9 none repeat scroll 0 0;
	}
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	#show-icon{
		background: rgba(0, 0, 0, 0) url("${ui.resourceLink('mdrtbinventory', 'images/inventory-icon.png')}") no-repeat scroll 0 0 / 100% auto;
		display: inline-block;
		float: right;
		height: 50px;
		margin-bottom: -40px;
		margin-top: 0px;
		width: 60px;
	}
	.exampler {
		background-color: #fff;
		border: 1px solid #ddd;
		border-radius: 2px;
		display: block;
		margin: 40px 0 3px;
		padding: 10px;
		position: relative;
	}
	.exampler::after {
		background: #f9f9f9 none repeat scroll 0 0;
		border: 1px solid #ddd;
		color: #969696;
		content: "Drug Summary";
		font-size: 12px;
		font-weight: bold;
		left: -1px;
		padding: 5px 10px;
		position: absolute;
		top: -29px;
	}
	.exampler div {
		background: rgba(0, 0, 0, 0) url("${ui.resourceLink('mdrtbinventory', 'images/drugs-icon.jpg')}") no-repeat scroll 10px 0 / auto 100%;
		padding-left: 90px;
		color: #363463;
	}
	.exampler div span{
		color: #555;
		float: left;
		font-size: 0.9em;
		text-transform: uppercase;
		width: 120px;
	}
	.button{
		margin-top: 10px;
	}
	.print-only{
		display: none;
	}
	table {
		font-size: 12px;
	}
</style>

<div class="clear"></div>

<div class="container">
	<div class="example">
		<ul id="breadcrumbs">
			<li>
				<a href="${ui.pageLink('referenceapplication', 'home')}">
					<i class="icon-home small"></i></a>
			</li>

			<li>
				<i class="icon-chevron-right link"></i>
				<a href="main.page">Inventory</a>
			</li>
			<li>
				<i class="icon-chevron-right link"></i>
				Item Details
			</li>
		</ul>
	</div>
	
	<div class="patient-header new-patient-header">		
		<div id="show-icon">
			&nbsp;
		</div>
		
		<div class="exampler">			
			<div>
				<span>Drug Name:</span><b>${item.drug.drug.name.toUpperCase()}</b><br/>
				<span>Category:</span>${item.drug.category.name.toUpperCase()}<br/>
				<span>Formulation:</span>${item.drug.formulation.name} ${item.drug.formulation.dosage}<br/>
			</div>
		</div>
	</div>

	
</div>

<div id="expiry-detail-results" style="display: block; margin-top:3px;">
    <div role="grid" class="dataTables_wrapper" id="expiry-detail-results-table_wrapper">
		<div id="print-section">
			<div class="print-only">				
				<div>
					<label>
						Drug Name:
					</label>
					<span>${item.drug.drug.name.toUpperCase()}</span>
					<br/>
					
					<label>
						Category:
					</label>
					<span>${item.drug.category.name.toUpperCase()}</span>
					<br/>
					
					<label>
						Formulation:
					</label>
					<span>${item.drug.formulation.name.toUpperCase()} ${item.drug.formulation.dosage}</span>
					<br/>				
				</div>
			</div>
		
			<table id="expiry-detail-results-table" class="dataTable" aria-describedby="expiry-detail-results-table_info">
				<thead>
					<th style="width:1px">#</th>
					<th style="width:80px">DATE</th>
					<th>TRANSACTION</th>
					<th style="width:80px">OPENING</th>
					<th style="width:80px">RECEIVED</th>
					<th style="width:80px">ISSUES</th>
					<th style="width:80px">CLOSING</th>
					<th>DESCRIPTION</th>
				</thead>

				<tbody>
					<% if (transactions.size() > 0) { %>
						<% transactions.eachWithIndex { transc, index -> %>
							<tr>
								<td>${index+1}</td>
								<td>${ui.formatDatePretty(transc.date)}</td>
								<td>${transc.type.name.toUpperCase()}</td>
								<td>${String.format("%1\$,.2f", (Double)transc.opening)}</td>
								<td>${String.format("%1\$,.2f", (Double)transc.receipt)}</td>
								<td>${String.format("%1\$,.2f", (Double)transc.issue)}</td>
								<td>${String.format("%1\$,.2f", (Double)transc.closing)}</td>
								<td>${transc.description.toUpperCase()}</td>							
							</tr>						
						<% } %>
					<% } else { %>
						<tr>
							<td></td>
							<td colspan=7>NO TRANSACTIONS FOUND</td>
						</tr>
					<% } %>
				</tbody>
			</table>
			
			<div class='print-only' style="padding-top: 30px">
				<span>Signature of sub-store/ Stamp</span>
				<span style="float:right;">Signature of inventory clerk/ Stamp</span>
			</div>		
		</div>
		
		<div>
			<span class="button cancel">Cancel</span>
			<span class="button task right">
				<i class="icon-print small"></i>
				Print
			</span>		
		</div>

    </div>
</div>