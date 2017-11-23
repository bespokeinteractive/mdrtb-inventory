package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.mdrtbinventory.db.MdrtbInventoryServiceDAO;

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


}
