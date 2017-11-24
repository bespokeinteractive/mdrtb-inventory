<% 
	ui.decorateWith("appui", "standardEmrPage", [title: "Inventory Dashboard"])
	ui.includeCss("uicommons", "datatables/dataTables_jui.css")
	ui.includeJavascript("mdrtbregistration", "jq.dataTables.min.js")
	ui.includeJavascript("mdrtbdashboard", "moment.js")
	ui.includeJavascript("mdrtbdashboard", "jq.browser.select.js")
%>

<script>
	var refreshInTable = function (resultData, dTable) {
        var rowCount = resultData.length;
        if (rowCount == 0) {
            dTable.find('td.dataTables_empty').html("No Records Found");
        }
        dTable.fnPageChange(0);
    };

    var isTableEmpty = function (resultData, dTable) {
        if (resultData.length > 0) {
            return false
        }
        return !dTable || dTable.fnGetNodes().length == 0;
    };
	
	jq(function () {
		jq("#tabs").tabs();
		
		jq('#inline-tabs li').click(function(){
			if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'stock'){
				jq('.add-receipts').hide(100);
				getDrugStockList();
			}
			else if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'expired'){
				jq('.add-receipts').show(100);
				getExpiryStockList();
			}
			else if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'receipts'){
				jq('.add-receipts').show(100);
				getReceiptsStockList();
			}
			else{
				jq('.add-receipts').hide(100);
			}
		});
		
		jq('#locations').click(function(){
			if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'stock'){
				getDrugStockList();
			}
			else if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'expired'){
				getExpiryStockList();
			}
			else if (jq('#inline-tabs li.ui-tabs-active').attr('aria-controls') == 'receipts'){
				getReceiptsStockList();
			}
			else{
				//Other Pages/Functions
			}
		});
		
		jq('.add-receipts').click(function(){
            window.location.href = "addreceipt.page";
		});
	});




</script>

<style>
    body {
        margin-top: 20px;
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
        height: 38px;
		padding-left: 5px;
    }

    .newdtp {
        width: 166px;
    }

    .add-on {
        color: #f26522;
		float: right;
		font-size: 8px !important;
		left: auto;
		margin-left: -29px;
		margin-top: 8px !important;
		position: absolute;
    }
	.add-on i {
        color: #f26522!important;
		font-size: 2.5em!important;
	}

    .chrome .add-on {
        margin-left: -31px;
        margin-top: -27px !important;
        position: relative !important;
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
    }
	.name.title{
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
		padding: 10px;
		text-align: center;
		width: auto;
	}
	#locations {
		float: right;
		margin: -42px 5px 0 0;
		width: 200px;
	}
	#receiptTable,
	#expiryTable,
	#drugstock{
		font-size: 14px;
	}
	#receiptTable td:nth-child(6),
	#expiryTable td:nth-child(6),
	#drugstock td:nth-child(5),
	#drugstock td:nth-child(6){
		text-align: right;
	}
	#receiptTable td:first-child,
	#receiptTable td:last-child,
	#expiryTable td:last-child,
	#drugstock td:first-child,
	#drugstock td:last-child{
		text-align: center;
	}
	#drugstock td:last-child a{
		cursor: pointer;
	}
	i.icon-remove{
		color: #f00;
	}
	.info-header div.filter-list{
		margin: -5px 5px 2px 10px;
		float: right;
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
            <h1 class="name title" style="border-bottom: 1px solid #ddd; padding-bottom: 2px;padding-top: 5px;">
                <span>INVENTORY DASHBOARD &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
            </h1>
			
			<select id="locations">
				<option value="-1">All</option>
				<% locations.eachWithIndex { loc, index -> %>
					<option value="${loc.id}" ${loc==location?'selected':''} '>${loc.name}</option>
				<% } %>
			</select>
        </div>
		<div class="clear"></div>

        <div id="tabs" style="margin-top: 5px!important;">
            <ul id="inline-tabs">
                <li><a href="#stock">Drug Stock</a></li>
                <li><a href="#expired">Expired Drugs</a></li>
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
                ${ ui.includeFragment("mdrtbinventory", "drugstock") }
            </div>

            <div id="expired">
				${ui.includeFragment("mdrtbinventory", "drugexpired")}
            </div>

            <div id="receipts">
				${ ui.includeFragment("mdrtbinventory", "drugreceipts") }
            </div>

            <div id="transers">
                ${ui.includeFragment("mdrtbinventory", "drugtransfer")}
            </div>
			
			<div id="accounts">
				${ui.includeFragment("mdrtbinventory", "drugissueaccount")}
			</div>
        </div>

    </div>
</div>