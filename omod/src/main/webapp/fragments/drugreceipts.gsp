<script>
	var receiptTable;
	var receiptTableObject;
	var receiptResultsData = [];
	
	var getReceiptsStockList = function(){
		receiptTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			location:	jq('#locations').val(),
			end:		jq('#to-field').val(),
			start:		jq('#from-field').val(),
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbinventory", "Drugs", "getFacilityReceipts") }', requestData)
			.success(function (data) {
				updateReceiptTableResults(data);
			}).error(function (xhr, status, err) {
				updateReceiptTableResults([]);
			}
		);
	};
	
	var updateReceiptTableResults = function(results){
		receiptResultsData = results || [];
		var dataRows = [];
		_.each(receiptResultsData, function(result){
			var drug = '<a href="drugs.page?id=' + result.id + '">'+result.item.drug.drug.name.toUpperCase()+' ('+ result.item.drug.formulation.name +' '+result.item.drug.formulation.dosage +')</a>';
			var icon = '<a>Edit</a> | <a>View</a>'
			
			dataRows.push([0, result.date, drug, result.item.drug.category.name.toUpperCase(), result.description.toUpperCase(), result.receipt.toString().formatToAccounting(), icon]);
		});

		receiptTable.api().clear();
		
		if(dataRows.length > 0) {
			receiptTable.fnAddData(dataRows);
		}

		refreshInTable(receiptResultsData, receiptTable);
	};
	
	jq(function(){
		receiptTableObject = jq("#receiptTable");
		
		receiptTable = receiptTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Receipts",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Receipts Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Receipts)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(receiptResultsData, receiptTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		receiptTable.on( 'order.dt search.dt', function () {
			receiptTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#receiptText').on('keyup', function () {
			receiptTable.api().search( this.value ).draw();
		});
		
		jq('#from-display, #to-display').change(function(){
			getReceiptsStockList();
		});
	});
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-list-ul"></i>
            <h3 class="name">RECEIPT DRUGS</h3>
			
			<div class="filter-list">
				<i class="icon-filter" style="font-size: 26px ; color: #5b57a6" ></i>
                <label for="stockCategoryId" style="color: #f26522;">FILTER:</label>
				<input id="receiptText" type="text" placeholder="Filter Requests" />
				
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'from.date', id: 'from', label: 'FROM:', useTime: false, defaultToday: false])}
				${ui.includeFragment("uicommons", "field/datetimepicker", [formFieldName: 'to.date',   id: 'to',   label: 'TO:', useTime: false, defaultToday: false])}
			</div>
			<div class="clear"></div>
        </div>
    </div>
</div>

<table id="receiptTable">
    <thead>
		<th style="width:1px">#</th>
		<th style="width:70px;">DATE</th>
		<th>DRUG NAME</th>
		<th style="width:100px;">CATEGORY</th>
		<th>DESCRIPTION</th>
		<th style="width:80px;">QUANTITY</th>
		<th style="width:80px">ACTIONS</th>
    </thead>
	
    <tbody>
    </tbody>
</table>