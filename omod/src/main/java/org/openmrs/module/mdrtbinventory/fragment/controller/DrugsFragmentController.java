package org.openmrs.module.mdrtbinventory.fragment.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.SimpleObject;
import org.openmrs.ui.framework.UiUtils;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class DrugsFragmentController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public List<SimpleObject> getFacilityDrugs(@RequestParam(value = "location") Location location,
                                               UiUtils ui){
        List<Location> locations = new ArrayList<Location>();
        if (location == null) {
            locations = this.getLocationsByUser();
        }
        else {
            locations.add(location);
        }

        List<InventoryDrugFacility> drugs = service.getFacilityDrugs(locations);
        if (drugs != null){
            return SimpleObject.fromCollection(drugs, ui, "id", "available", "reorder", "drug.drug.name", "drug.category.name", "drug.formulation.name", "drug.formulation.dosage");
        }

        return SimpleObject.fromCollection(Collections.EMPTY_LIST, ui);
    }



    //Return Locations
    List<Location> getLocationsByUser(){
        return Context.getService(MdrtbService.class).getLocationsByUser();
    }
}
