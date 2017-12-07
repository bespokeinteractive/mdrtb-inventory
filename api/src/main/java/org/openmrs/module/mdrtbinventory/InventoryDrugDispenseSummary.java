package org.openmrs.module.mdrtbinventory;

/**
 * Created by Dennys Henry
 * Created on 06/12/2017
 **/

public class InventoryDrugDispenseSummary {
    private String id;
    private InventoryDrugDispense dispense;
    private InventoryDrugFacility item;
    private Double quantity;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public InventoryDrugDispense getDispense() {
        return dispense;
    }

    public void setDispense(InventoryDrugDispense dispense) {
        this.dispense = dispense;
    }

    public InventoryDrugFacility getItem() {
        return item;
    }

    public void setItem(InventoryDrugFacility item) {
        this.item = item;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }
}
