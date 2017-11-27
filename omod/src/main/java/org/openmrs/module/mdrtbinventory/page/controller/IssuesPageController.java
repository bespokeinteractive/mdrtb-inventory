package org.openmrs.module.mdrtbinventory.page.controller;

import org.openmrs.api.context.Context;
import org.openmrs.module.appui.UiSessionContext;
import org.openmrs.module.mdrtbinventory.InventoryDrugIssues;
import org.openmrs.module.mdrtbinventory.InventoryDrugIssuesDetails;
import org.openmrs.module.mdrtbinventory.api.MdrtbInventoryService;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/27/2017.
 */
public class IssuesPageController {
    MdrtbInventoryService service = Context.getService(MdrtbInventoryService.class);

    public String get(@RequestParam(value = "id") Integer id,
                      PageModel model,
                      UiSessionContext session){
        if (!session.isAuthenticated()){
            return "redirect: index.htm";
        }

        InventoryDrugIssues issue = service.getInventoryDrugIssue(id);
        List<InventoryDrugIssuesDetails> details = service.getInventoryDrugIssuesDetails(issue);

        model.addAttribute("location", session.getSessionLocation());
        model.addAttribute("issue", issue);
        model.addAttribute("details", details);

        return null;
    }
}
