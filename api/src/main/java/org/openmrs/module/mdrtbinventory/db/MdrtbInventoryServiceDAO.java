package org.openmrs.module.mdrtbinventory.db;

import org.openmrs.Location;
import org.openmrs.module.mdrtbinventory.*;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public interface MdrtbInventoryServiceDAO {
    //DrugFacility
    InventoryDrugFacility getFacilityDrug(Integer id);
    List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations);
    InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug);

    List<InventoryDrugCategory> getInventoryDrugCategories();

    List<InventoryDrugTransaction> getInventoryDrugTransactions(List<Location> locations, InventoryDrugTransactionType type, Date startDate, Date endDate);

    InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id);

    List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented);
}
