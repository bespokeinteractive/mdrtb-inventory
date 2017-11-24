<script>
	var stockTable;
	var stockTableObject;
	var stockResultsData = [];
	
	var getDrugStockList = function(){
		stockTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			location:	jq('#locations').val(),
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbinventory", "Drugs", "getFacilityDrugs") }', requestData)
			.success(function (data) {
				updateStockTableResults(data);
			}).error(function (xhr, status, err) {
				updateStockTableResults([]);
			}
		);
	};
	
	var updateStockTableResults = function(results){
		stockResultsData = results || [];
		var dataRows = [];
		_.each(stockResultsData, function(result){
			var drug = '<a href="drugs.page?id=' + result.id + '">' + result.drug.drug.name.toUpperCase() + '</a>';
			var icon = '<a title="Receive Stock"><i class="icon-arrow-down small"></i></a> <a title="Transfer Stock"><i class="icon-share-alt small"></i></a> <a title="Remove Item"><i class="icon-remove small"></i></a>'
			
			dataRows.push([0, drug, result.drug.category.name.toUpperCase(), result.drug.formulation.name +' '+result.drug.formulation.dosage, result.available.toString().formatToAccounting(), result.reorder.toString().formatToAccounting(), icon]);
		});

		stockTable.api().clear();
		
		if(dataRows.length > 0) {
			stockTable.fnAddData(dataRows);
		}

		refreshInTable(stockResultsData, stockTable);
	};
	
	jq(function(){
		stockTableObject = jq("#drugstock");
		
		stockTable = stockTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Items",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Items Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Items)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(stockResultsData, stockTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		stockTable.on( 'order.dt search.dt', function () {
			stockTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#drugStockName, #stockCategoryId').on('keyup change', function () {
			var val = jq('#drugStockName').val() + ' ' + jq('#stockCategoryId').val();
			stockTable.api().search( val ).draw();
		});
		
		getDrugStockList();
	});
</script>


<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-folder-open"></i>
            <h3 class="name">VIEW DRUGS</h3>
            <div style="float:right;margin:-5px 5px 2px 10px;">
                <i class="icon-filter" style="font-size: 26px ; color: #5b57a6" ></i>
                <label for="stockCategoryId" style="color: #f26522;">Category</label>
                <select id = "stockCategoryId" style="width: 200px" name = "stockCategoryId">
					<option value="">ALL CATEGORIES</option>
					<% categories.eachWithIndex { catg, index -> %>
						<option value="${catg.name}">${catg.name.toUpperCase()}</option>
					<% } %>
				</select>
                <label for="drugStockName" style="color: #f26522;">&nbsp;&nbsp; Name </label>
                <input id = "drugStockName" type="text" value name = "drugStockName" placeholder="Drug Name" style="width:300px" />
            </div>
			<div class="clear"></div>
        </div>
    </div>
</div>


<table id="drugstock">
    <thead>
		<th style="width:1px">#</th>
		<th>DRUG NAME</th>
		<th style="width:180px;">CATEGORY</th>
		<th style="width:120px;">FORMULATION</th>
		<th style="width:80px">QUANTITY</th>
		<th style="width:80px">REORDER</th>
		<th style="width:80px">ACTIONS</th>
    </thead>
	
    <tbody>
    </tbody>
</table>