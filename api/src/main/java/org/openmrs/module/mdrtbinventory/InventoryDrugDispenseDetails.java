package org.openmrs.module.mdrtbinventory;

import org.openmrs.PatientProgram;

import java.io.Serializable;

/**
 * Created by Dennis Henry
 * Created on 12/06/2017.
 */

public class InventoryDrugDispenseDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private InventoryDrugDispense dispense;
    private InventoryDrugFacility item;
    private InventoryDrugBatches batch;
    private PatientProgram patientProgram;
    private Double quantity;


    //Constructors
    public InventoryDrugDispenseDetails(){ }
    public InventoryDrugDispenseDetails(InventoryDrugDispense dispense){
        this.dispense = dispense;
    }

    //Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
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

    public InventoryDrugBatches getBatch() {
        return batch;
    }

    public void setBatch(InventoryDrugBatches batch) {
        this.batch = batch;
    }

    public PatientProgram getPatientProgram() {
        return patientProgram;
    }

    public void setPatientProgram(PatientProgram patientProgram) {
        this.patientProgram = patientProgram;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }
}
