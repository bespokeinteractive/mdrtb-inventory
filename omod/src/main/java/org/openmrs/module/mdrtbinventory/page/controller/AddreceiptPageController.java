package org.openmrs.module.mdrtbinventory.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbinventory.InventoryDrug;

import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.page.PageModel;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/24/2017.
 */
public class AddreceiptPageController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public String get(PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        List<Location> locations = Context.getService(MdrtbService.class).getLocationsByUser();
        List<InventoryDrug> drugs = service.getInventoryDrugs();

        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("locations", locations);
        model.addAttribute("drugs", drugs);

        return null;
    }
}
