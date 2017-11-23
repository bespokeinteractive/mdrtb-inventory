package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.mdrtbinventory.InventoryDrugCategory;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */

@Transactional
public interface MdrtbInventoryService
        extends OpenmrsService {
    //DrugFacility
    InventoryDrugFacility getFacilityDrug(Integer id);
    List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations);
    InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug);

    //Categories
    List<InventoryDrugCategory> getInventoryDrugCategories();
}
