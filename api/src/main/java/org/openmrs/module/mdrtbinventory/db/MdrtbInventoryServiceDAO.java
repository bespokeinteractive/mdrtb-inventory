package org.openmrs.module.mdrtbinventory.db;

import org.openmrs.Location;
import org.openmrs.module.mdrtbinventory.InventoryDrugCategory;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;

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

    //Categories
    List<InventoryDrugCategory> getInventoryDrugCategories();
}
