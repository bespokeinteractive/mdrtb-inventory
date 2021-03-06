<script>
	var expiryTable;
	var expiryTableObject;
	var expiryResultsData = [];
	
	var getExpiryStockList = function(){
		expiryTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			location:	jq('#locations').val(),
			end:		jq('#to-field').val(),
			start:		jq('#from-field').val(),
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbinventory", "Drugs", "getExpiredFacilityDrugs") }', requestData)
			.success(function (data) {
				updateExpiryTableResults(data);
			}).error(function (xhr, status, err) {
				updateExpiryTableResults([]);
			}
		);
	};
	
	var updateExpiryTableResults = function(results){
		expiryResultsData = results || [];
		var dataRows = [];
		_.each(expiryResultsData, function(result){
			var drug = '<a href="drugs.page?id=' + result.id + '">'+result.item.drug.drug.name.toUpperCase()+' ('+ result.item.drug.formulation.name +' '+result.item.drug.formulation.dosage +')</a>';
			var icon = '<a>Edit</a> | <a>Indent</a>'
			
			dataRows.push([0, drug, result.item.drug.category.name.toUpperCase(), result.batch, result.expiry, result.available.toString().formatToAccounting(), icon]);
		});

		expiryTable.api().clear();
		
		if(dataRows.length > 0) {
			expiryTable.fnAddData(dataRows);
		}

		refreshInTable(expiryResultsData, expiryTable);
	};
	
	jq(function(){
		expiryTableObject = jq("#expiryTable");
		
		expiryTable = expiryTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Expired Items",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Expired Items Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Items)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(expiryResultsData, expiryTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		expiryTable.on( 'order.dt search.dt', function () {
			expiryTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#expiryName, #expiryCategory').on('keyup change', function () {
			var value = jq('#expiryName').val() + ' ' + jq('#expiryCategory').val();			
			expiryTable.api().search( value ).draw();
		});
	});
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-calendar"></i>
            <h3 class="name">EXPIRED DRUGS</h3>
            <div class="filter-list">
                <i class="icon-filter" style="font-size: 26px ; color: #5b57a6" ></i>
                <label for="expiryCategory" style="color: #f26522;">Category</label>
                <select id = "expiryCategory" style="width: 200px" name = "stockCategoryId">
					<option value="">ALL CATEGORIES</option>
					<% categories.eachWithIndex { catg, index -> %>
						<option value="${catg.name}">${catg.name.toUpperCase()}</option>
					<% } %>
				</select>
				
                <label for="expiryName" style="color: #f26522;">&nbsp;&nbsp; Filter </label>
                <input id = "expiryName" type="text" placeholder="Drug Name" style="width:300px" />
            </div>
			<div class="clear"></div>
        </div>
    </div>
</div>

<table id="expiryTable">
    <thead>
	    <th style="width:1px">#</th>
	    <th>DRUG NAME</th>
	    <th style="width:150px;">CATEGORY</th>
	    <th style="width:80px;">BATCH#</th>
	    <th style="width:80px;">EXPIRY</th>
	    <th style="width:80px">QUANTITY</th>
	    <th style="width:100px">ACTIONS</th>
    </thead>
	
    <tbody>
    </tbody>
</table>