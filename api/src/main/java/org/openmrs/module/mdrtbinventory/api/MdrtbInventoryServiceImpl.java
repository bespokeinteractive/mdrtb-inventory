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
    public InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug) {
        return dao.saveFacilityDrug(drug);
    }

    @Override
    public List<InventoryDrugCategory> getInventoryDrugCategories() {
        return dao.getInventoryDrugCategories();
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
    public List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented) {
        return dao.getExpiredBatches(locations, indented);
    }

    @Override
    public InventoryDrugBatches saveInventoryDrugBatches(InventoryDrugBatches batch) {
        return dao.saveInventoryDrugBatches(batch);
    }
}
