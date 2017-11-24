package org.openmrs.module.mdrtbinventory.page.controller;

import org.openmrs.Location;
import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtb.service.MdrtbService;
import org.openmrs.module.mdrtbinventory.InventoryDrugCategory;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.page.PageModel;

import java.util.List;

/**
 * Created by David Mukungi
 * Created on 11/23/2017.
 */
public class MainPageController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public String get(PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }
        List<Location> locations = Context.getService(MdrtbService.class).getLocationsByUser();
        List<InventoryDrugCategory> categories = service.getInventoryDrugCategories();

        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("locations", locations);
        model.addAttribute("categories", categories);

        return null;
    }
}
