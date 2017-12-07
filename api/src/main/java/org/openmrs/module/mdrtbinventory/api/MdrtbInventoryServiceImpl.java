package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtbinventory.*;
import org.openmrs.module.mdrtbinventory.db.MdrtbInventoryServiceDAO;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class MdrtbInventoryServiceImpl
        extends BaseOpenmrsService
        implements MdrtbInventoryService {
    private MdrtbInventoryServiceDAO dao;

    public MdrtbInventoryServiceDAO getDao() {
        return dao;
    }

    public void setDao(MdrtbInventoryServiceDAO dao) {
        this.dao = dao;
    }


    @Override
    public InventoryDrug getInventoryDrug(Integer id) {
        return dao.getInventoryDrug(id);
    }

    @Override
    public List<InventoryDrug> getInventoryDrugs() {
        return dao.getInventoryDrugs();
    }

    @Override
    public InventoryDrugFacility getFacilityDrug(Integer id) {
        return dao.getFacilityDrug(id);
    }

    @Override
    public InventoryDrugFacility getFacilityDrug(Location location, InventoryDrug drug) {
        return dao.getFacilityDrug(location, drug);
    }

    @Override
    public List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations) {
        return dao.getFacilityDrugs(locations);
    }

    @Override
    public List<InventoryDrugFacility> getFacilityDrugsWithBatches(List<Location> locations) {
        List<InventoryDrugFacility> items = dao.getFacilityDrugs(locations);

        for (int i=0; i<items.size(); i++){
            List<InventoryDrugBatches> batches = dao.getInventoryDrugBatches(items.get(i), null);
            items.get(i).setBatches(batches);
            if (batches.size()>0){
                items.get(i).setHasBatches(true);
            }
        }

        return items;
    }

    @Override
    public InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug) {
        return dao.saveFacilityDrug(drug);
    }

    @Override
    public List<InventoryDrugCategory> getInventoryDrugCategories() {
        return dao.getInventoryDrugCategories();
    }

    @Override
    public List<InventoryDrugTransaction> getInventoryDrugTransactions(InventoryDrugFacility item) {
        return dao.getInventoryDrugTransactions(item);
    }

    @Override
    public List<InventoryDrugTransaction> getInventoryDrugTransactions(List<Location> locations, InventoryDrugTransactionType type, Date startDate, Date endDate) {
        return dao.getInventoryDrugTransactions(locations, type, startDate, endDate);
    }

    @Override
    public InventoryDrugTransaction saveInventoryDrugTransaction(InventoryDrugTransaction transaction) {
        return dao.saveInventoryDrugTransaction(transaction);
    }

    @Override
    public InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id) {
        return dao.getInventoryDrugTransactionType(id);
    }

    @Override
    public InventoryDrugBatches getInventoryDrugBatch(Integer id) {
        return dao.getInventoryDrugBatch(id);
    }

    @Override
    public InventoryDrugBatches getInventoryDrugBatch(InventoryDrugFacility item, String batch, String company) {
        return dao.getInventoryDrugBatch(item, batch, company);
    }

    @Override
    public List<InventoryDrugBatches> getInventoryDrugBatches(InventoryDrugFacility item, Date expiry) {
        return dao.getInventoryDrugBatches(item, expiry);
    }

    @Override
    public List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented) {
        return dao.getExpiredBatches(locations, indented);
    }

    @Override
    public InventoryDrugBatches saveInventoryDrugBatches(InventoryDrugBatches batch) {
        return dao.saveInventoryDrugBatches(batch);
    }

    @Override
    public InventoryDrugIssues getInventoryDrugIssue(Integer id) {
        return dao.getInventoryDrugIssue(id);
    }

    @Override
    public List<InventoryDrugIssues> getInventoryDrugIssues(List<Location> locations) {
        return dao.getInventoryDrugIssues(locations);
    }

    @Override
    public InventoryDrugIssues saveInventoryDrugIssue(InventoryDrugIssues issue) {
        return dao.saveInventoryDrugIssue(issue);
    }

    @Override
    public InventoryDrugIssuesDetails getInventoryDrugIssuesDetail(Integer id) {
        return dao.getInventoryDrugIssuesDetail(id);
    }

    @Override
    public List<InventoryDrugIssuesDetails> getInventoryDrugIssuesDetails(InventoryDrugIssues issue) {
        return dao.getInventoryDrugIssuesDetails(issue);
    }

    @Override
    public InventoryDrugIssuesDetails saveInventoryDrugIssuesDetail(InventoryDrugIssuesDetails details) {
        return dao.saveInventoryDrugIssuesDetail(details);
    }

    @Override
    public InventoryDrugDispense saveInventoryDrugDispense(InventoryDrugDispense dispense) {
        return dao.saveInventoryDrugDispense(dispense);
    }

    @Override
    public InventoryDrugDispenseDetails saveInventoryDrugDispenseDetails(InventoryDrugDispenseDetails details) {
        return dao.saveInventoryDrugDispenseDetails(details);
    }

    @Override
    public List<InventoryDrugDispenseSummary> getInventoryDrugDispenseSummary(InventoryDrugDispense dispense) {
        return dao.getInventoryDrugDispenseSummary(dispense);
    }
}
