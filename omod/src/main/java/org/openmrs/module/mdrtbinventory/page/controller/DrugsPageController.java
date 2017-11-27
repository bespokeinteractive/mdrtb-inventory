package org.openmrs.module.mdrtbinventory.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtbinventory.InventoryDrugFacility;
import org.openmrs.module.mdrtbinventory.InventoryDrugTransaction;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/26/2017.
 */
public class DrugsPageController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        InventoryDrugFacility item  = service.getFacilityDrug(id);
        List<InventoryDrugTransaction> transactions = service.getInventoryDrugTransactions(item);

        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("item", item);
        model.addAttribute("transactions", transactions);

        return null;
    }
}
