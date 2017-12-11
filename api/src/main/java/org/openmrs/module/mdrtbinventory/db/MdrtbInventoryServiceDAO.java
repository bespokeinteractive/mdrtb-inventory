package org.openmrs.module.mdrtbinventory.db;

import org.openmrs.Drug;
import org.openmrs.Location;
import org.openmrs.module.mdrtbinventory.*;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public interface MdrtbInventoryServiceDAO {
    InventoryDrug getInventoryDrug(Integer id);
    List<InventoryDrug> getInventoryDrugs();

    InventoryDrugFacility getFacilityDrug(Integer id);
    InventoryDrugFacility getFacilityDrug(Location location, InventoryDrug drug);
    List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations);
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
    List<InventoryDrugBatches> getShortExpiryBatches(List<Location> locations, Date expireBy);
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
