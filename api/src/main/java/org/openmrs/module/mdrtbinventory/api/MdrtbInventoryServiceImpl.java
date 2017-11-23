package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.openmrs.module.mdrtbinventory.db.MdrtbInventoryServiceDAO;

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
    public List<InventoryDrugFacility> getFacilityDrug(List<Location> locations) {
        return dao.getFacilityDrug(locations);
    }

    @Override
    public InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug) {
        return dao.saveFacilityDrug(drug);
    }
}
