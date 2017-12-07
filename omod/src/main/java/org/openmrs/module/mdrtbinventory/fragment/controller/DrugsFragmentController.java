package org.openmrs.module.mdrtbinventory.fragment.controller;

import org.apache.commons.lang.StringUtils;
import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.model.LocationCentres;
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

    public List<SimpleObject> getFacilityIssues(@RequestParam(value = "location") Location location,
                                                UiUtils ui){
        List<InventoryDrugIssues> issues = service.getInventoryDrugIssues(this.getLocationsByUser(location));
        return SimpleObject.fromCollection(issues, ui, "id", "date", "account", "description");
    }

    public List<SimpleObject> getDrugsBatches(@RequestParam(value = "item") Integer item_id,
                                              UiUtils ui){
        InventoryDrugFacility item = service.getFacilityDrug(item_id);
        List<InventoryDrugBatches> batches = service.getInventoryDrugBatches(item, null);
        if (batches!=null){
            Collections.sort(batches, new Comparator<InventoryDrugBatches>() {
                @Override
                public int compare(InventoryDrugBatches o1, InventoryDrugBatches o2) {
                    return o1.getExpiry().compareTo(o2.getExpiry());
                }
            });

            return SimpleObject.fromCollection(batches, ui, "id", "batch", "company", "available", "manufactured", "expiry");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
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

    public SimpleObject addIssues(@BindParams("issues") DrugItemsWrapper wrapper,
                                  HttpServletRequest request,
                                  UiSessionContext session)
            throws SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        InventoryDrugIssues issue = new InventoryDrugIssues();
        issue.setDate(wrapper.getDate());
        issue.setLocation(session.getSessionLocation());
        issue.setAccount(wrapper.getAccount());
        issue.setDescription(wrapper.getDescription());
        issue = this.service.saveInventoryDrugIssue(issue);

        for (Map.Entry<String, String[]> params : ((Map<String, String[]>) request.getParameterMap()).entrySet()) {
            if (StringUtils.contains(params.getKey(), "quantity.")) {
                String value = params.getValue()[0].replace(",", "").trim();
                if (StringUtils.isBlank(value)){
                    continue;
                }

                Double quantity = new Double(value);
                if (quantity <= 0){
                    continue;
                }

                Integer key = Integer.parseInt(params.getKey().substring("quantity.".length()));
                InventoryDrugBatches batch = service.getInventoryDrugBatch(key);
                InventoryDrugFacility item = batch.getItem();

                InventoryDrugIssuesDetails details = new InventoryDrugIssuesDetails();
                details.setBatch(batch);
                details.setIssue(issue);
                details.setQuantity(quantity);
                this.service.saveInventoryDrugIssuesDetail(details);

                batch.setAvailable(batch.getAvailable() - quantity);
                this.service.saveInventoryDrugBatches(batch);

                item.setAvailable(item.getAvailable() - quantity);
                this.service.saveFacilityDrug(item);

                InventoryDrugTransaction transaction = new InventoryDrugTransaction();
                transaction.setDate(wrapper.getDate());
                transaction.setType(new InventoryDrugTransactionType(3));
                transaction.setItem(item);
                transaction.setTransaction(issue.getId());
                transaction.setOpening(item.getAvailable() + quantity);
                transaction.setIssue(quantity);
                transaction.setClosing(item.getAvailable());
                transaction.setDescription("ISSUE TO " + wrapper.getAccount().toUpperCase());
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
