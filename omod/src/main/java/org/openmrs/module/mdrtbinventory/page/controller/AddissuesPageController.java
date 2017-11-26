package org.openmrs.module.mdrtbinventory.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.page.PageModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/25/2017.
 */
public class AddissuesPageController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public String get(PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        List<Location> locations = new ArrayList<Location>();
        locations.add(session.getSessionLocation());

        List<InventoryDrugFacility> items = service.getFacilityDrugsWithBatches(locations);
        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("items", items);

        return null;
    }
}
