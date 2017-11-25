package org.openmrs.module.mdrtbinventory.fragment.controller;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbinventory.*;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.module.mdrtbinventory.util.DrugItemsWrapper;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.BindParams;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.text.DateFormat;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class DrugsFragmentController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public List<SimpleObject> getFacilityDrugs(@RequestParam(value = "location") Location location,
                                               UiUtils ui){
        List<Location> locations = this.getLocationsByUser(location);
        List<InventoryDrugFacility> drugs = service.getFacilityDrugs(locations);
        if (drugs != null){
            return SimpleObject.fromCollection(drugs, ui, "id", "available", "reorder", "drug.drug.name", "drug.category.name", "drug.formulation.name", "drug.formulation.dosage");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public List<SimpleObject> getFacilityReceipts(@RequestParam(value = "location") Location location,
                                                  @RequestParam(value = "start", required = false) Date start,
                                                  @RequestParam(value = "end", required = false) Date end,
                                                  UiUtils ui){
        List<Location> locations = this.getLocationsByUser(location);
        List<InventoryDrugTransaction> receipts = service.getInventoryDrugTransactions(locations, new InventoryDrugTransactionType(1), start, end);
        if (receipts != null){
            return SimpleObject.fromCollection(receipts, ui, "id", "date", "transaction", "receipt", "description", "item.drug.drug.name", "item.drug.category.name", "item.drug.formulation.name", "item.drug.formulation.dosage");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }

    public List<SimpleObject> getExpiredFacilityDrugs(@RequestParam(value = "location") Location location,
                                                      UiUtils ui){
        List<InventoryDrugBatches> batches = service.getExpiredBatches(this.getLocationsByUser(location),false);
        return SimpleObject.fromCollection(batches, ui, "id", "available", "expiry", "batch", "item.drug.drug.name", "item.drug.category.name", "item.drug.formulation.name", "item.drug.formulation.dosage");
    }

    public SimpleObject addReceipt(@BindParams("receipt") DrugItemsWrapper wrapper,
                                   HttpServletRequest request)
            throws SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        Location location = Context.getLocationService().getLocation(wrapper.getFacility());

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "quantity.")) {
                String value = params.getValue()[0].replace(",", "").trim();
                if (StringUtils.isBlank(value)){
                    continue;
                }

                Double available = new Double(value);
                if (available <= 0){
                    continue;
                }

                Integer key = Integer.parseInt(params.getKey().substring("quantity.".length()));
                InventoryDrug drug = service.getInventoryDrug(key);
                InventoryDrugFacility item = service.getFacilityDrug(location, drug);
                if (item == null){
                    item = new InventoryDrugFacility();
                    item.setLocation(location);
                    item.setDrug(drug);
                }

                item.setAvailable(item.getAvailable() + available);
                item = this.service.saveFacilityDrug(item);
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);

                String batch_no = request.getParameterValues("batch." + key)[0];
                String company = request.getParameterValues("company." + key)[0];
                String comment = request.getParameterValues("comment." + key)[0];

                String manufacture = request.getParameterValues("manufacture." + key)[0];
                String expiryDate = request.getParameterValues("expiry." + key)[0];

                //Save Batches
                InventoryDrugBatches batch = service.getInventoryDrugBatch(item, company, batch_no);
                if (batch == null){
                    batch = new InventoryDrugBatches();
                    batch.setDate(wrapper.getDate());
                    batch.setItem(item);
                    batch.setBatch(batch_no);
                    batch.setCompany(company);
                    batch.setComments(comment);
                    batch.setSupplier(wrapper.getSupplier());
                    batch.setManufactured(df.parse(manufacture, new ParsePosition(0)));
                    batch.setExpiry(df.parse(expiryDate, new ParsePosition(0)));
                }

                batch.setAvailable(batch.getAvailable() + available);
                batch.setReceipt(batch.getReceipt() + available);

                batch = service.saveInventoryDrugBatches(batch);

                //Save Transaction
                InventoryDrugTransaction transaction = new InventoryDrugTransaction();
                transaction.setDate(wrapper.getDate());
                transaction.setType(new InventoryDrugTransactionType(1));
                transaction.setItem(item);
                transaction.setTransaction(batch.getId());
                transaction.setOpening(item.getAvailable() - available);
                transaction.setReceipt(available);
                transaction.setIssue(0.0);
                transaction.setClosing(item.getAvailable());
                transaction.setDescription("RECEIPT FROM " + wrapper.getSupplier().toUpperCase());
                this.service.saveInventoryDrugTransaction(transaction);
            }
        }

        return SimpleObject.create("status", "success", "message", "Facility Receipt has been added successfully");
    }

    //Return Locations
    List<Location> getLocationsByUser(Location location){
        if (location != null){
            List<Location> locations = new ArrayList<Location>();
            locations.add(location);

            return locations;
        }

        return Context.getService(MdrtbService.class).getLocationsByUser();
    }
}
