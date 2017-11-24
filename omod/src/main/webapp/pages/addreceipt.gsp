<%
    ui.decorateWith("appui", "standardEmrPage", [title: "Add Request"])
    ui.includeJavascript("mdrtbdashboard", "moment.js")
    ui.includeCss("mdrtbregistration", "onepcssgrid.css")



%>
<script>

    jq(function () {
        jq('#advanced').on('click', function () {
            addDialog.show();
        });

        var addDialog = emr.setupConfirmationDialog({
            dialogOpts: {
                overlayClose: false,
                close: true
            },
            selector: '#add-dialog',
            actions: {
                confirm: function () {
                    var dataString = jq('#add-form').serialize();


                    addDialog.close();
                },
                cancel: function () {
                    addDialog.close();
                }
            }
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
#locationList{
    font-size: 14px;
    margin-top: 5px;
}

form input {
    margin: 0px;
    display: inline-block;
    min-width: 50px;
    padding: 2px 10px;
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

form input:focus, form select:focus, form textarea:focus, form ul.select:focus, .form input:focus, .form select:focus, .form textarea:focus, .form ul.select:focus {
    outline: 1px none #007fff;
    box-shadow: 0 0 1px 0px #888 !important;
}

.name {
    color: #f26522;
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
    padding: 5px 0;
    text-align: center;
    width: 18%;
}

form .advanced i {
    font-size: 24px;
}

.add-on {
    float: right;
    left: auto;
    margin-left: -29px;
    margin-top: 5px;
    position: absolute;
    color: #f26522;
}

.ui-widget-content a {
    color: #007fff;
}

td a {
    cursor: pointer;
    text-decoration: none;
}

td a:hover {
    text-decoration: none;
}

.recent-seen {
    background: #fff799 none repeat scroll 0 0 !important;
    color: #000 !important;
}

.recent-lozenge {
    border: 1px solid #f00;
    border-radius: 4px;
    color: #f00;
    display: inline-block;
    font-size: 0.7em;
    padding: 1px 2px;
    vertical-align: text-bottom;
}

table th, table td {
    vertical-align: baseline;
    white-space: nowrap;
}

table th:nth-child(5),
table td:nth-child(5) {
    white-space: normal;
}

.dialog-content ul li input[type="text"],
.dialog-content ul li input[type="password"],
.dialog-content ul li select,
.dialog-content ul li textarea {
    border: 1px solid #ddd;
    display: inline-block;
    height: 40px;
    margin: 10px 0;
    min-width: 20%;
    padding: 5px 0 5px 10px;
    width: 60%;
}

#modal-overlay {
    background: #000 none repeat scroll 0 0;
    opacity: 0.3 !important;
}

form label,
.form label {
    display: inline-block;
    width: 110px;
}

.dialog select option {
    font-size: 1em;
}

#editLocations,
#addLocations {
    border-top: 1px solid #ddd;
    margin-top: 3px;
    padding-left: 0px;
}

label.user-locations {
    margin-top: 4px;
    width: 33%;
}

.dialog .dialog-content li {
    margin-bottom: 0;
}

.dialog ul {
    margin-bottom: 10px;
}

label.user-locations input {
    margin-top: 4px;
}

#overview {
    min-height: 450px;
    padding: 5px;
}

.title-answer {
    font-family: "Myriad Pro", Arial, Helvetica, Tahoma, sans-serif;
    font-size: 13px;
}

#whv {
    display: inline-block;
    width: 100%;
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
    <div class="demographics" style="width: 100%" >
        <h1 class="name" style="border-bottom: 1px solid #ddd;">
            <span>ADD RECEIPTS TO GENERAL STORE   &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
        </h1>
        <div id="advanced"  class="button confirm right">
            <i class="icon-plus-sign small"></i>
            ADD RECEIPT
        </div>
    </div>


    <table id="locationList">
        <thead>
        <th style="width:1px">#</th>
        <th style="width:80px;"><small>CATE</br>GORY</small>

        <th style="width:80px;"><small>NAME</small></th>
        <th style="width:80px"> <small>FORMULATION</small></th>
        <th style="width:80px;"><small>QTY</small></th>
        <th style="width:80px;"><small>I.COST</small></th>
        <th style="width:80px"><small>COST</small></th>
        <th style="width:80px"><small>BATCH.#</small></th>
        <th style="width:80px"> <small>COMPANY</small></th>
        <th style="width:80px"> <small>D.O.M</small></th>
        <th style="width:80px"> <small>D.O.E</small></th>
        <th style="width:80px"><small>R.D</small></th>
        <th style="width:80px"><small>FROM</small></th>

        </thead>

        <tbody>

        </tbody>
    </table>

    <div style="margin: 5px 0 10px;">
        <span class="button confirm right" id="finish" style="background: #5b57a6">
            <i class="icon-save small"></i>
            Save
        </span>

        <span class="button confirm right" id="print" style="margin-right:5px; background: #5b57a6">
            <i class="icon-print small"></i>
            Print
        </span>
    </div>

</form>

<div id="confirm-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>CONFIRM POSTING</h3>
    </div>

    <div class="dialog-content">
        <div class="confirmation">
            Confirm
        </div>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>
<div id="add-dialog" class="dialog" style="display:none;">
    <div class="dialog-header">
        <i class="icon-folder-open"></i>

        <h3>ADD RECEIPTS</h3>
    </div>

    <div class="dialog-content">
        <form id="add-form">
            <ul>
                <li>
                    <label for="addCategory">DRUG CATEGORY:</label>
                    <select type="text" name="wrap.gender" id="addCategory">
                        <option value=""></option>
                    </select>
                </li>
                <li>
                    <label for="addDrugname">DRUG NAME:</label>
                    <select type="text" name="wrap.gender" id="addDrugname">
                        <option value=""></option>
                    </select>
                </li>
                <li>
                    <label for="addFormulation">FORMULATION:</label>
                    <select type="text" name="wrap.gender" id="addFormulation">
                        <option value=""></option>
                    </select>
                </li>
                <li>
                    <label for="addQuantity">QUANTITY:</label>
                    <input type="text" name="wrap.gender" id="addQuantity"/>
                </li>
                <li>
                    <label for="addUnitprice">UNIT PRICE:</label>
                    <input type="text" name="wrap.gender" id="addUnitprice"/>
                </li>
                <li>
                    <label for="addInstitutionalcost">Institutional Cost(%):</label>
                    <input type="text" name="wrap.gender" id="addInstitutionalcost"/>
                </li>
                <li>
                    <label for="addBatchNo">Batch No:</label>
                    <select type="text" name="wrap.gender" id="addBatchNo">
                        <option value=""></option>
                    </select>
                </li>
                <li>
                    <label for="addPatientCost">Cost To The Patient:</label>
                    <input type="text" name="wrap.gender" id="addPatientCost"/>
                </li>
                <li>
                    <label for="addCompanyName">Company Name:</label>
                    <select type="text" name="wrap.gender" id="addCompanyName">
                        <option value=""></option>
                    </select>
                </li>
                <li>
                <label for="addManufactureDate" class = "date">Manufacture Date:</label>
                    <input type="text" name="wrap.gender" id="addManufactureDate"/>

            </li>
                <li>
                    <label for="addExpiryDate">Expiry Date:</label>
                    <input type="text" name="wrap.gender" id="addExpiryDate"/>
                </li>
                <li>
                    <label for="addReceiptFrom">Receipt From:</label>
                    <input type="text" name="wrap.gender" id="addReceiptFrom"/>
                </li>
            </ul>
        </form>

        <label class="button confirm right">Confirm</label>
        <label class="button cancel">Cancel</label>
    </div>
</div>