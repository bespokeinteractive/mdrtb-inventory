<script>
	var issuesTable;
	var issuesTableObject;
	var issuesResultsData = [];
	
	var getIssuesStockList = function(){
		issuesTableObject.find('td.dataTables_empty').html('<span><img class="search-spinner" src="'+emr.resourceLink('uicommons', 'images/spinner.gif')+'" /></span>');
		
		var requestData = {
			location:	jq('#locations').val()
		}
		
		jq.getJSON('${ ui.actionLink("mdrtbinventory", "Drugs", "getFacilityIssues") }', requestData)
			.success(function (data) {
				updateIssuesTableResults(data);
			}).error(function (xhr, status, err) {
				updateIssuesTableResults([]);
			}
		);
	};
	
	var updateIssuesTableResults = function(results){
		issuesResultsData = results || [];
		var dataRows = [];
		_.each(issuesResultsData, function(result){
			var drug = '<a href="issues.page?id='+result.id+'">'+result.account.toUpperCase()+'</a>';
			var icon = '<a href="issues.page?id='+result.id+'">View</a> | <a>Edit</a> |<a><i class="icon-remove small"></i><a/>';
			
			dataRows.push([0, result.date, drug, result.description.toUpperCase(), icon]);
		});

		issuesTable.api().clear();
		
		if(dataRows.length > 0) {
			issuesTable.fnAddData(dataRows);
		}

		refreshInTable(issuesResultsData, issuesTable);
	};
	
	jq(function(){
		issuesTableObject = jq("#issuesTable");
		
		issuesTable = issuesTableObject.dataTable({
			autoWidth: false,
			bFilter: true,
			bJQueryUI: true,
			bLengthChange: false,
			iDisplayLength: 25,
			sPaginationType: "full_numbers",
			bSort: false,
			sDom: 't<"fg-toolbar ui-toolbar ui-corner-bl ui-corner-br ui-helper-clearfix datatables-info-and-pg"ip>',
			oLanguage: {
				"sInfo": "Issues",
				"sInfoEmpty": " ",
				"sZeroRecords": "No Issues Found",
				"sInfoFiltered": "(Showing _TOTAL_ of _MAX_ Issues)",
				"oPaginate": {
					"sFirst": "First",
					"sPrevious": "Previous",
					"sNext": "Next",
					"sLast": "Last"
				}
			},

			fnDrawCallback : function(oSettings){
				if(isTableEmpty(issuesResultsData, issuesTable)){
					return;
				}
			},
			
			fnRowCallback : function (nRow, aData, index){
				return nRow;
			}
		});
		
		issuesTable.on( 'order.dt search.dt', function () {
			issuesTable.api().column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
				cell.innerHTML = i+1;
			} );
		}).api().draw();
		
		jq('#issueText').on('keyup', function () {
			issuesTable.api().search( this.value ).draw();
		});
	});
</script>

<div class="dashboard clear">
    <div class="info-section">
        <div class="info-header">
            <i class="icon-list-ol"></i>
            <h3 class="name">ISSUE DRUGS</h3>
			
			<div class="filter-list">
				<i class="icon-filter" style="font-size: 26px ; color: #5b57a6" ></i>
                <label for="stockCategoryId" style="color: #f26522;">FILTER:</label>
				<input id="issueText" type="text" placeholder="Filter Issues" style="width: 300px" />
				
				<span class="button confirm add add-issues"><i class="icon-plus small"></i></span>
			</div>
			<div class="clear"></div>

        </div>
    </div>
</div>

<table id="issuesTable">
    <thead>
		<th style="width:1px">#</th>
		<th style="width:100px">DATE</th>
		<th style="width:250px;">ACCOUNT</th>
		<th>NOTES</th>
		<th style="width:110px">ACTIONS</th>
    </thead>
	
    <tbody>
    </tbody>
</table>
</div>