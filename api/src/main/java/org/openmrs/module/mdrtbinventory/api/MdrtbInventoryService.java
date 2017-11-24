package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.mdrtbinventory.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */

@Transactional
public interface MdrtbInventoryService
        extends OpenmrsService {
    InventoryDrugFacility getFacilityDrug(Integer id);
    List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations);
    InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug);

    List<InventoryDrugCategory> getInventoryDrugCategories();

    List<InventoryDrugTransaction> getInventoryDrugTransactions(List<Location> locations, InventoryDrugTransactionType type, Date startDate, Date endDate);

    InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id);

    List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented);
}
