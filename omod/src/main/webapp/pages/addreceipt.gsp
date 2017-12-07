<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Add Receipts"])
	ui.includeJavascript("mdrtbdashboard", "moment.js")
	ui.includeJavascript("mdrtbdashboard", "jq.browser.select.js")
%>

<script>
	var line = 0;
	var output = "";


	function verify(line, value){
		if (isNaN(parseFloat(value)) || !isFinite(value) || value <= 0) {
			return false;
		}
		
		if (jq('#batch'+line).val().trim() == ''){
			jq('#batch'+line).addClass('red');
		}
		
		if (jq('#company'+line).val().trim() == ''){
			jq('#company'+line).addClass('red');
		}
		
		if (jq('#manf'+line+'-display').val().trim() == ''){
			jq('#manf'+line+'-display').addClass('red');
		}
		
		if (jq('#expr'+line+'-display').val().trim() == ''){
			jq('#expr'+line+'-display').addClass('red');
		}
	}
	
	jq(function () {
		var confirmDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#confirm-dialog',
            actions: {
                confirm: function () {
                    var dataString = jq('form').serialize();

                    jq.ajax({
                        type: "POST",
                        url: '${ui.actionLink("mdrtbinventory", "Drugs", "addReceipt")}',
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

                    confirmDialog.close();
                },
                cancel: function () {
                    confirmDialog.close();
                }
            }
        });
		
		jq('#receiptTable').on('change', '.qt input', function() {
			var val = jq(this).val().replace(',','').replace(' ','');
			jq(this).val(val.toString().formatToAccounting()!='NaN'?val.toString().formatToAccounting():'');
		});
		
		jq('#receiptTable').on('focus', 'input', function() {
			var curr = 0;
			
			if (jq(this).hasClass('date')){
				var str = jq(this).attr('id');
				var res = str.split('-');
				
				curr = res[0].substring(4);
			}
			else {
				curr = jq(this).data('uuid');
			}
			
			if (curr != line){
				output = (jq("#quantity"+line).val() + "").toString().replace(',','').replace(' ','');

				verify(line, output);
				line = curr;
				
				jq('#batch'+line).removeClass('red');
				jq('#company'+line).removeClass('red');
				jq('#manf'+line+'-display').removeClass('red');
				jq('#expr'+line+'-display').removeClass('red');
			}
		});
		
		jq('#receiptTable').on('focus', '.qt input', function() {
			var val = jq(this).val().replace(',','').replace(' ','');
			if (isNaN(parseFloat(val)) || isFinite(val) && val == 0) {
				jq(this).val('');
			}
		});
		
		jq('#cancelButton').click(function(){
			window.location.href = "budgetadd.page?reset=true";
		});
		
		jq('#addReceipt').click(function(){
			var verified = true;

			if (jq('#supplier').val().trim() == ''){
				jq().toastmessage('showErrorToast', 'Post failed. Ensure that the supplier has been specified correctly');
				return false;
			}

			jq("#receiptTable input").each(function(){
				if (jq(this).hasClass('red')){
					verified = false;
					return false;
				}
			});

			if (!verified){
				jq().toastmessage('showErrorToast', 'Post failed. Ensure that all fields have been captured correctly');
				return false;
			}

			jq("#receiptTable .qt input").each(function(){
				var val = jq(this).val().replace(',','').replace(' ','');
				if (!isNaN(parseFloat(val)) && isFinite(val) && val > 0) {
					verified = false;
					return false;
				}
			});

			if (verified){
				jq().toastmessage('showErrorToast', 'Post failed. Ensure that atleast one item has been filled');
				return false;
			}
			
			jq('.dialog-content .confirmation').html("Confirm posting new Receipt for <b>" + jq('#facility option:selected').text() + " Facility</b>?");
			
			confirmDialog.show();
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
		margin: 15px 0 0 0;
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
		height: 120px;
		margin-top: 2px;
		width: 400px;
	}
	#receiptTable {
		border-top: 2px solid #363463;
		margin-top: 2px;
		font-size: 12px;
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
	td .add-on {
        color: #f26522;
		float: right;
		font-size: 8px !important;
		left: auto;
		margin-left: -29px;
		margin-top: 8px !important;
		position: absolute;
    }
	td .add-on i {
        color: #f26522!important;
		font-size: 2.5em!important;
	}

    .chrome td .add-on {
        margin-left: -31px;
        margin-top: -19px !important;
        position: relative !important;
    }
	
	td .icon-calendar.small{
		font-size: 1.5em!important;
	}
	.textable.qt input{
		text-align: right;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.3 !important;
	}
	.red {
		border: 1px solid #f00!important;
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
            Add Rececipt
        </li>
    </ul>
</div>

 <form class="patient-header new-patient-header">
	<div class="demographics">
		<h1 class="name" style="border-bottom: 1px solid #ddd;">
			<span><i class="icon-medicine small"></i>ADD RECEIPTS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
		</h1>
	</div>

	<div id="show-icon">
		&nbsp;
	</div>
	
	<div class="budget-box">
		<div>
			${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'receipt.date', id: 'date-created', label: 'Date:', useTime: false, defaultToday: true])}
		</div>
		
		<div style="width: 63%; float: right">
			<label style="display: inline-block">Notes</label>
			<textarea name="receipt.description" style="min-width: 0;display: inline-block;margin-top: 5px;"></textarea>
		</div>
		
		<div>
			<label>Facility</label>
			<select id="facility" name="receipt.facility">
				<% locations.eachWithIndex { loc, index -> %>
					<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
				<% } %>
			</select>
		</div>
		
		<div>
			<label>Supplier</label>
			<input id="supplier" type="text" name="receipt.supplier"/>
		</div>
		
		<span class="clear both"></span>
	</div>

	<table id="receiptTable">
		<thead>
			<th style="width:1px;">#</th>
			<th style="text-align: left">DRUG/ITEMS</th>
			<th style="width: 80px">BATCH#</th>
			<th style="width:120px">COMPANY</th>
			<th style="width:70px">QUANTITY</th>
			<th style="width:100px">MANUF.DATE</th>
			<th style="width:100px">EXPIRY</th>
			<th style="width:150px">NOTES</th>
		</thead>

		<tbody>
			<% drugs.eachWithIndex { item, index -> %>
				<tr>
					<td>${index+1}</td>
					<td>${item.drug.name.toUpperCase()} (${item.formulation.name.toUpperCase()} ${item.formulation.dosage.toUpperCase()})</td>
					<td class="textable" style="width:80px"><input type="text" class="child" data-uuid="${item.id}" name="batch.${item.id}" id="batch${item.id}" /></td>
					<td class="textable" style="width:120px"><input type="text" class="child" data-uuid="${item.id}" name="company.${item.id}" id="company${item.id}" /></td>
					<td class="textable qt" style="width:70px"><input type="text" class="child" data-uuid="${item.id}" name="quantity.${item.id}" id="quantity${item.id}" /></td>
					<td class="textable" style="width:100px">
						${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'manufacture.'+item.id, id: 'manf'+item.id, label: '', useTime: false, defaultToday: false, classes:['mandatory']])}
					</td>
					<td class="textable" style="width:100px">
						${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'expiry.'+item.id, id: 'expr'+item.id, label: '', useTime: false, defaultToday: false, classes:['mandatory']])}
					</td>
					<td class="textable" style="width:150px"><input type="text" class="child" data-uuid="${item.id}" name="comment.${item.id}"/></td>
				</tr>
			<% } %>
		</tbody>
	</table>
	
	<div style="margin: 5px 0 10px;">
		<span class="button confirm right" id="addReceipt">
			<i class="icon-save small"></i>
			Save
		</span>
		
		<span class="button cancel" id="cancelButton">
			<i class="icon-remove small"></i>			
			Cancel
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