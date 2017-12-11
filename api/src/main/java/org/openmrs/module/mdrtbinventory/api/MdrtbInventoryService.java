package org.openmrs.module.mdrtbinventory.api;

import org.openmrs.Location;
import org.openmrs.api.OpenmrsService;
import org.openmrs.module.mdrtbinventory.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */

@Transactional
public interface MdrtbInventoryService
        extends OpenmrsService {
    InventoryDrug getInventoryDrug(Integer id);
    List<InventoryDrug> getInventoryDrugs();

    InventoryDrugFacility getFacilityDrug(Integer id);
    InventoryDrugFacility getFacilityDrug(Location location, InventoryDrug drug);
    List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations);
    List<InventoryDrugFacility> getFacilityDrugsWithBatches(List<Location> locations);
    InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug);

    List<InventoryDrugCategory> getInventoryDrugCategories();

    List<InventoryDrugTransaction> getInventoryDrugTransactions(InventoryDrugFacility item);
    List<InventoryDrugTransaction> getInventoryDrugTransactions(List<Location> locations, InventoryDrugTransactionType type, Date startDate, Date endDate);
    InventoryDrugTransaction saveInventoryDrugTransaction(InventoryDrugTransaction transaction);

    InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id);

    InventoryDrugBatches getInventoryDrugBatch(Integer id);
    InventoryDrugBatches getInventoryDrugBatch(InventoryDrugFacility item, String batch, String company);
    List<InventoryDrugBatches> getInventoryDrugBatches(InventoryDrugFacility item, Date expiry);
    List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented);
    List<InventoryDrugBatches> getShortExpiryBatches(List<Location> locations, Date ExpireBy);
    InventoryDrugBatches saveInventoryDrugBatches(InventoryDrugBatches batch);

    InventoryDrugIssues getInventoryDrugIssue(Integer id);
    List<InventoryDrugIssues> getInventoryDrugIssues(List<Location> locations);
    InventoryDrugIssues saveInventoryDrugIssue(InventoryDrugIssues issue);

    InventoryDrugIssuesDetails getInventoryDrugIssuesDetail(Integer id);
    List<InventoryDrugIssuesDetails> getInventoryDrugIssuesDetails(InventoryDrugIssues issue);
    InventoryDrugIssuesDetails saveInventoryDrugIssuesDetail(InventoryDrugIssuesDetails details);

    InventoryDrugDispense saveInventoryDrugDispense(InventoryDrugDispense dispense);
    InventoryDrugDispense getInventoryDrugDispense(Integer id);
    List<InventoryDrugDispense> getInventoryDrugDispense(Location location);

    InventoryDrugDispenseDetails saveInventoryDrugDispenseDetails(InventoryDrugDispenseDetails details);
    List<InventoryDrugDispenseDetailsTbSummary> getInventoryDrugDispenseDetailsTbSummary(InventoryDrugDispense dispense);
    List<InventoryDrugDispenseDetailsTbSummaryPatients> getInventoryDrugDispenseDetailsTbSummaryPatients(Location location, String period);

    List<InventoryDrugDispenseSummary> getInventoryDrugDispenseSummary(InventoryDrugDispense dispense);
}
