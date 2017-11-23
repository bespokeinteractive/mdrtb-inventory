<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Inventory Dashboard"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
%>
<script>
	jq(function () {
		jq("#tabs").tabs();
		
		
		jq('#inline-tabs li').click(function(){			
			if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'receipts'){
				jq('.add-receipts').show(100);
			}
			else{
				jq('.add-receipts').hide(100);
			}
		}).click();
		
		jq('.add-receipts').click(function(){
			window.location.href = (emr.pageLink('inventoryapp','addReceiptsToGeneralStore'));
		});
	});
</script>

<style>
    body {
        margin-top: 20px;
    }

    .col1, .col2, .col3, .col4, .col5, .col6, .col7, .col8, .col9, .col10, .col11, .col12 {
        color: #555;
        text-align: left;
    }

    form input,
    form select {
        margin: 0px;
        display: inline-block;
        min-width: 50px;
        padding: 2px 10px;
        height: 32px !important;
    }

    .info-header span {
        cursor: pointer;
        display: inline-block;
        float: right;
        margin-top: -2px;
        padding-right: 5px;
    }

    .dashboard .info-section {
        margin: 2px 5px 5px;
    }

    .toast-item {
        background-color: #222;
    }

    @media all and (max-width: 768px) {
        .onerow {
            margin: 0 0 100px;
        }
    }

    form .advanced {
        background: #363463 none repeat scroll 0 0;
        border-color: #dddddd;
        border-style: solid;
        border-width: 1px;
        color: #fff;
        cursor: pointer;
        float: right;
        padding: 6px 0;
        text-align: center;
        width: 27%;
    }

    form .advanced i {
        font-size: 22px;
    }

    .col4 label {
        width: 110px;
        display: inline-block;
    }

    .col4 input[type=text] {
        display: inline-block;
        padding: 4px 10px;
    }

    .col4 select {
        padding: 4px 10px;
    }

    form select {
        min-width: 50px;
        display: inline-block;
    }

    .identifiers span {
        border-radius: 50px;
        color: white;
        display: inline;
        font-size: 0.8em;
        letter-spacing: 1px;
        margin: 5px;
    }

    table.dataTable thead th, table.dataTable thead td {
        padding: 5px 10px;
    }

    form input:focus {
        border: 1px solid #00f !important;
    }

    input[type="text"], select {
        border: 1px solid #aaa;
        border-radius: 2px !important;
        box-shadow: none !important;
        box-sizing: border-box !important;
        height: 30px;
		padding-left: 5px;
    }

    .newdtp {
        width: 166px;
    }

    #lastDayOfVisit label,
    #referred-date label {
        display: none;
    }

    #lastDayOfVisit input {
        width: 160px;
    }

    .add-on {
        color: #f26522;
		float: right;
		font-size: 8px !important;
		left: auto;
		margin-left: -29px;
		margin-top: 4px !important;
		position: absolute;
    }
	.add-on i {
        color: #009384!important;
	}

    .chrome .add-on {
        margin-left: -31px;
        margin-top: -27px !important;
        position: relative !important;
    }

    #lastDayOfVisit-wrapper .add-on {
        margin-top: 5px;
    }

    .ui-widget-content a {
        color: #007fff;
    }

    #breadcrumbs a, #breadcrumbs a:link, #breadcrumbs a:visited {
        text-decoration: none;
    }

    .new-patient-header .identifiers {
        margin-top: 5px;
    }

    .name {
        color: #f26522;
		display: block !important;
		width: 100%;
    }

    #inline-tabs {
        background: #f9f9f9 none repeat scroll 0 0;
    }

    .formfactor {
        background: #f3f3f3 none repeat scroll 0 0;
        border: 1px solid #ddd;
        margin-bottom: 5px;
        padding: 5px 10px;
        text-align: left;
        width: auto;
    }

    .formfactor .lone-col {
        display: inline-block;
        margin-top: 5px;
        overflow: hidden;
        width: 100%;
    }

    .formfactor .first-col {
        display: inline-block;
        margin-top: 5px;
        overflow: hidden;
        width: 300px;
    }

    .formfactor .second-col {
        display: inline-block;
        float: right;
        margin-top: 5px;
        overflow: hidden;
        width: 600px;
    }

    .formfactor .lone-col input,
    .formfactor .first-col input,
    .formfactor .second-col input {
        margin-top: 5px;
        padding: 5px 15px;
        width: 100%;
    }

    .formfactor .lone-col label,
    .formfactor .first-col label,
    .formfactor .second-col label {
        padding-left: 5px;
        color: #363463;
        cursor: pointer;
    }

    .ui-tabs-panel h2 {
        display: inline-block;
    }
	
	#acctDate,
	#acctFrom,
	#rcptDate,
	#rcptFrom{
		float: 			none;
		margin-bottom:	-9px;
		margin-top: 	12px;
		padding-right: 	0px;
	}
	
	#acctDate-display,
	#acctFrom-display,
	#rcptDate-display,
	#rcptFrom-display {
		width: 140px;
	}	
	.summary-div{
		height: 50px;
	}
	#modal-overlay {
		background: #000 none repeat scroll 0 0;
		opacity: 0.4 !important;
	}
	
	#inline-tabs li:nth-child(6){
		float: right;
		text-align: center;
		font-weight: normal;
	}
	#inline-tabs li:nth-child(6) a.button{
		height: 17px;
		margin-top: -5px;
		padding-top: 12px;
		text-align: center;
		width: auto;
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
                Inventory
            </li>
        </ul>
    </div>

    <div class="patient-header new-patient-header">
        <div class="demographics" style="width: 100%;">
            <h1 class="name" style="border-bottom: 1px solid #ddd;">
                <span>INVENTORY DASHBOARD &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
            </h1>
        </div>
		
		<div id="show-icon">
			&nbsp;
		</div>
		<div class="clear"></div>

        <div id="tabs" style="margin-top: 5px!important;">
            <ul id="inline-tabs">
                <li><a href="#stock">Drug Stock</a></li>
                <li><a href="#manage">Expired Drugs</a></li>
                <li><a href="#receipts">Receipts</a></li>
                <li><a href="#transers">Transfer</a></li>
                <li><a href="#accounts">Issue to Account</a></li>
				
                <li>
					<a class="button task add-receipts" style="display: none; color: #fff;">
						<i class="icon-plus small"> </i>
						Add Receipts
					</a>
				</li>
            </ul>

            <div id="stock">
                { ui.includeFragment("inventoryapp", "stockBalance") }
            </div>

            <div id="manage">
				{ui.includeFragment("inventoryapp", "stockBalanceExpiry")}
            </div>

            <div id="receipts">
				{ ui.includeFragment("inventoryapp", "receiptsToGeneralStore") }
            </div>

            <div id="transers">
                {ui.includeFragment("inventoryapp", "transferDrugFromGeneralStore")}
            </div>
			
			<div id="accounts">
				{ui.includeFragment("inventoryapp", "issueDrugAccountList")}
			</div>
        </div>

    </div>
</div>