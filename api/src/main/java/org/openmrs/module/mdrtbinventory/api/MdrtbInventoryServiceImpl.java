package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtbinventory.InventoryDrugCategory;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.openmrs.module.mdrtbinventory.InventoryDrugTransaction;
import org.openmrs.module.mdrtbinventory.InventoryDrugTransactionType;
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
    public InventoryDrugFacility getFacilityDrug(Integer id) {
        return dao.getFacilityDrug(id);
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
    public InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id) {
        return dao.getInventoryDrugTransactionType(id);
    }
}
