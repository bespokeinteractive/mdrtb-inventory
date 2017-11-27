<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Issue To Account"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	jq(function () {
		
	});
</script>

<style>
	#breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
		text-decoration: none;
	}
	.name {
		color: #f26522;
	}
	.button.confirm{
		margin-right:0px;
	}
	.budget-box{
		border: 1px solid #d3d3d3;
		border-top: 2px solid #363463;
		height: auto;
		margin: 5px 0 0 0;
		padding-bottom: 5px;
	}
	.budget-box div{
		width: 36%;
		display: inline-block;
	}
	.budget-box label{
		display: inherit;
		padding: 2px 10px;
		margin: 2px 0 0 0;
		width: 70px;
		font-size: 0.9em;

	}
	input, form input, select, form select, ul.select, form ul.select, textarea {
		min-width: 0;
		display: inline-block;
		width: 230px;
		height: 38px;
	}
	input, select, textarea, form ul.select, .form input, .form select, .form textarea, .form ul.select {
		color: #363463;
		padding: 5px 10px;
		background-color: #FFF;
		border: 1px solid #DDD;
	}
	#date-created label {
		display: inline-block;
	}
	textarea {
		resize: none;
		height: 80px;
		margin-top: 2px;
		width: 400px;
	}
	#issuesTable {
		border-top: 2px solid #363463;
		margin-top: 2px;
		font-size: 12px;
	}
	#issuesTable td:nth-child(5){
		text-align: right;
	}
	.dialog {
        width: 650px;
    }
    .dialog .dialog-content li {
        margin-bottom: 0;
    }
    .dialog-content ul li label {
        display: inline-block;
        width: 150px;
    }
    .dialog-content ul li input[type="text"], .dialog-content ul li select, .dialog-content ul li textarea {
        border: 1px solid #ddd;
        display: inline-block;
        height: 40px;
        margin: 1px 0;
        min-width: 20%;
        padding: 5px 0 5px 10px;
        width: 64%;
    }
    .dialog select option {
        font-size: 1em;
    }
    .dialog ul {
        margin-bottom: 20px;
    }
	.dialog .dialog-content li {
		margin-bottom: 0;
	}
	.dialog-content ul li label{
		display: inline-block;
		width: 120px;
	}
	.dialog-content ul li input[type=text],
	.dialog-content ul li select,
	.dialog-content ul li textarea {
		border: 1px solid #ddd;
		display: inline-block;
		height: 40px;
		margin: 1px 0;
		min-width: 20%;
		padding: 5px 0 5px 10px;
		width: 70%;
	}
	.dialog-content ul li textarea{
		height: 100px;
		resize: none;
	}
	.dialog select option {
		font-size: 1em;
	}
	.dialog ul {
		margin-bottom: 20px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
	.show-icon {
		float: right;
		font-family: "OpenSansBold";
		font-size: 1.5em;
		margin: 5px 5px -5px 0;
	}
	td .icon-remove{
		color: #f00;
	}
	td a{
		cursor: pointer;
	}
</style>

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
            Issue To Account
        </li>
    </ul>
</div>

 <form class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-medicine small"></i>ISSUE TRANSACTION &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div class="show-icon">
		<i class="icon-globe small"></i>${issue.location.name.toUpperCase()}
	</div>
	
	<span class="clear both"></span>
	
	<div class="budget-box">
		<div>
			<label style="display: inline-block">DATE:</label>${ui.formatDatePretty(issue.date)}
		</div>
		
		<div style="width: 63%; float: right">
			<label style="display: inline-block">NOTES</label>${issue.description!=''?issue.description:'N/A'}
		</div>
		
		<div>
			<label>ACCOUNT:</label>${issue.account}
		</div>
		
		<span class="clear both"></span>
	</div>

	<table id="issuesTable">
		<thead>
			<th style="width:1px;">#</th>
			<th style="text-align: left">DRUG/ITEMS</th>
			<th style="width: 80px">BATCH#</th>
			<th style="width:180px">COMPANY</th>
			<th style="width:100px">QUANTITY</th>
			<th style="width:100px">MANUF.DATE</th>
			<th style="width:100px">EXPIRY</th>
		</thead>

		<tbody>
			<tr>
				<% details.eachWithIndex { dtl, index -> %>
					<td>${index+1}</td>
					<td>${dtl.batch.item.drug.drug.name.toUpperCase()} (${dtl.batch.item.drug.formulation.name} ${dtl.batch.item.drug.formulation.dosage})</td>
					<td>${dtl.batch.batch}</td>
					<td>${dtl.batch.company}</td>
					<td>${String.format("%1\$,.2f", (Double)dtl.quantity)}</td>
					<td>${ui.formatDatePretty(dtl.batch.manufactured)}</td>
					<td>${ui.formatDatePretty(dtl.batch.expiry)}</td>
				<% } %>
			</tr>
		</tbody>
	</table>
	
	<div style="margin: 5px 0 10px;">
		<span class="button task right" id="addIssue">
			<i class="icon-print small"></i>
			PRINT
		</span>
		
		<a href="main.page" class="button cancel" id="cancelButton">
			<i class="icon-chevron-left small"></i>			
			BACK
		</a>
	</div>	
</form>