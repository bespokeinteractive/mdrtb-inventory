<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Issue To Account"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
%>

<script>
	jq(function () {
		jq("#session-location ul.select").on('click', 'li', function (event) {
			setTimeout(function() {
				window.location.href = "addissues.page?refreshed=true";
			}, 700);
		});
		
		jq('#drugs').change(function(){
			jq('#quantity').val('0.00');
			var requestData = {
				item: jq(this).val()
			}
			
			jq.getJSON('${ ui.actionLink("mdrtbinventory", "Drugs", "getDrugsBatches") }', requestData)
				.success(function (data) {
					var rows = data || [];
					var count = 1;
					jq('#batchTable > tbody').empty();
					
					_.each(rows, function(data){
						jq('#batchTable > tbody').append("<tr><td>" + count + "<input type='hidden' class='id' value="+data.id+" /><input type='hidden' class='manufacture' value="+data.manufactured+" /></td><td class='batch'>"+data.batch.toUpperCase()+"</td><td class='company'>"+data.company.toUpperCase()+"</td><td class='expiry'>"+data.expiry+"</td><td class='available' style='text-align:right'>"+data.available.toString().formatToAccounting()+"</td><td class='textable'><input class='quantity' style='text-align:right;' name='qt."+data.id+"' /></td></tr>")
						count++;
					});
					
					if (count == 1){
						jq('#batchTable > tbody').append("<tr><td></td><td colspan=5>NO ITEMS FOUND</td></tr>");
					}
					
					addDialog.close();			
					addDialog.show();			
				}).error(function (xhr, status, err) {
					jq('#batchTable > tbody').append("<tr><td></td><td colspan=5>NO ITEMS FOUND</td></tr>");
					jq().toastmessage('showErrorToast', 'Error Loading Details. ' + err);
				}
			);
			
		});
		
		jq('#batchTable').on('change', '.textable input', function() {
			var val = jq(this).val().replace(',','').replace(' ','');
			var sum = 0;
			
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
			
			jq("#batchTable .textable input").each(function(){
				val = jq(this).val().replace(',','').replace(' ','');
				if (!isNaN(parseFloat(val)) && isFinite(val) && val > 0) {
					sum += +val;
				}
			});
			
			jq("#quantity").val(sum.toString().formatToAccounting());
		});
		
		jq('#addSlip').click(function(){
			jq('#drugs').val(0).change();
			addDialog.show()
		});
		
		var addDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#add-dialog',
            actions: {
                confirm: function () {					
					var val = jq('#quantity').val().replace(',','').replace(' ','');
					if (isNaN(parseFloat(val)) || !isFinite(val) || val <= 0) {
						jq().toastmessage('showErrorToast', 'Post Failed. No Batches available for Posting. ');
						return false;
					}
					
					var batchExsist = false;
					
					//Code to push Data to the table after verification here
					jq("#batchTable > tbody tr").each(function() {
						var quantity = jq(this).find('.quantity').val().replace(',','').replace(' ','');
						if (isNaN(parseFloat(quantity)) || !isFinite(quantity) || quantity <= 0) {
							return true;
						}
						
						var ignore = false;
						var name = jq('#drugs :selected').text();
						var idnt = jq(this).find('.id').val();
						var batch = jq(this).find('.batch').text();
						var company = jq(this).find('.company').text();
						var expiry = jq(this).find('.expiry').text();
						var available = jq(this).find('.available').text().replace(',','').replace(' ','');						
						var manufacture = jq(this).find('.manufacture').val();
						
						if (jq('#issuesTable > tbody').text().trim() == 'Add items to Slip'){
							jq('#issuesTable > tbody').empty();
						}
						else {
							jq('#issuesTable > tbody tr').each(function() {
								if (jq(this).data('uuid') == idnt){
									batchExsist = true;
									ignore = true;
									return false;
								}
							});
						}
						
						if (!ignore){
							jq('#issuesTable > tbody').append("<tr data-uuid="+idnt+"> <td><input type='hidden' name='quantity."+idnt+"' value='"+quantity+"' /></td><td>"+name+"</td><td>"+batch+"</td><td>"+company+"</td><td>"+quantity.toString().formatToAccounting()+"</td><td>"+manufacture+"</td><td>"+expiry+"</td><td><a><i class=' icon-remove small'></i></a></td> </tr>");
						}
						
						console.log( quantity );
					});
					
					if (batchExsist){
						jq().toastmessage('showErrorToast', 'One or More batches already exsists in the slip');
					}
					
                    addDialog.close();
                },
                cancel: function () {
                    addDialog.close();y
                }
            }
        });
		
		jq('#issuesTable').on('click', 'a', function(){
			jq( this ).closest('tr').remove();
			
			if (jq("#issuesTable > tbody tr").length == 0){
				jq('#issuesTable > tbody').append("<tr><td></td><td colspan=7>Add items to Slip</td></tr>");
			}			
		});
		
		jq('#addIssue').click(function(){
			if (jq('#account').val().trim() == ''){
				jq().toastmessage('showErrorToast', 'Kindly specify Issue Account');
				return false;
			}
		
			if (jq("#issuesTable > tbody input").length == 0){
				jq().toastmessage('showErrorToast', 'No Batches found for Issue');
				return false;
			}
			
			var dataString = jq('form').serialize();
			
			jq.ajax({
				type: "POST",
				url: '${ui.actionLink("mdrtbinventory", "Drugs", "addIssues")}',
				data: dataString,
				dataType: "json",
				success: function (data) {
					if (data.status == "success") {
						jq().toastmessage('showSuccessToast', data.message);
						window.location.href = "main.page";
					}
					else {
						jq().toastmessage('showErrorToast', 'Post failed. ' + data.message);
					}
				},
				error: function (data) {
					jq().toastmessage('showErrorToast', "Post failed. " + data.statusText);
				}
			});
		});
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
		margin: 10px 0 0 0;
		width: 60px;

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
	#batchTable {
		font-size:12px;
	}
	.textable{
		padding:0;
	}
	.textable input {
		background-color: transparent;
		margin: 0px;
		border: none;
		width: 100%;
		height: auto;
	}
	td label{
		display: none;
	
	}
	.textable.qt input{
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
			<span><i class="icon-medicine small"></i>ISSUE TO ACCOUNT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div class="show-icon">
		<i class="icon-globe small"></i>${location.name.toUpperCase()}
	</div>
	
	<span class="clear both"></span>
	
	<div class="budget-box">
		<div>
			${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'issues.date', id: 'date-created', label: 'Date:', useTime: false, defaultToday: true])}
		</div>
		
		<div style="width: 63%; float: right">
			<label style="display: inline-block">Notes</label>
			<textarea name="issues.description" style="min-width: 0;display: inline-block;margin-top: 5px;"></textarea>
		</div>
		
		<div>
			<label>Account</label>
			<input id="account" type="text" name="issues.account"/>
		</div>
		
		<span class="clear both"></span>
	</div>

	<table id="issuesTable">
		<thead>
			<th style="width:1px;">#</th>
			<th style="text-align: left">DRUG/ITEMS</th>
			<th style="width: 80px">BATCH#</th>
			<th style="width:150px">COMPANY</th>
			<th style="width:70px">QUANTITY</th>
			<th style="width:80px">MANUF.DATE</th>
			<th style="width:80px">EXPIRY</th>
			<th style="width:5px"></th>
		</thead>

		<tbody>
			<tr>
				<td></td>
				<td colspan=7>Add items to Slip</td>
			</tr>
		</tbody>
	</table>
	
	<div style="margin: 5px 0 10px;">
		<span class="button confirm right" id="addIssue">
			<i class="icon-save small"></i>
			Save
		</span>
		
		<span class="button cancel right" id="cancelButton">
			<i class="icon-remove small"></i>			
			Cancel
		</span>
		
		<span class="button task" id="addSlip">
			<i class="icon-plus small"></i>
			Add Items
		</span>
	</div>	
</form>

<div id="confirm-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>CONFIRM POSTING</h3>
    </div>

    <div class="dialog-content">
        <div class="confirmation" style="margin-bottom:20px">
			Confirm
		</div>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>

<div id="add-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-arrow-down"></i>
        <h3>ADD TO SLIP</h3>
    </div>

    <div class="dialog-content">
		<ul>
			<li>
				<label for="addNames">DRUG:</label>
				<select id="drugs">
					<option value=0></option>
					<% items.eachWithIndex { item, index -> %>
						<% if (item.hasBatches) { %>
							<option value="${item.id}">${item.drug.drug.name.toUpperCase()} (${item.drug.formulation.name.toUpperCase()} ${item.drug.formulation.dosage.toUpperCase()})</option>
						<% } %>
					<% } %>
				</select>
			</li>

			<li>
				<label for="editNames">TOTAL QNTY:</label>
				<input type="text" id="quantity" readonly=""/>
			</li>

			<li>
				<table id="batchTable">
					<thead>
						<th style="width:1px;">#</th>
						<th>BATCH#</th>
						<th style="width:120px">COMPANY</th>
						<th style="width: 70px">EXPIRY</th>
						<th style="width: 70px">AVAILABLE</th>
						<th style="width:100px">QUANTITY</th>
					</thead>
					
					<tbody>
						<tr>
							<td></td>
							<td colspan=5>NO ITEMS FOUND</td>
						</tr>
					</tbody>
				
				</table>
			</li>
		</ul>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>