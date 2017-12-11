package org.openmrs.module.mdrtbinventory;

import org.openmrs.module.mdrtb.model.PatientProgramDetails;

/**
 * Created by Dennis Henry
 * Created on 10/12/2017
 */
public class InventoryDrugDispenseDetailsTbSummary {
    private String id;
    private InventoryDrugDispense dispense;
    private PatientProgramDetails programDetails;
    private Double rhze;
    private Double rh;
    private Double rhz;
    private Double rhp;
    private Double eth;
    private Double iso;

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

    public PatientProgramDetails getProgramDetails() {
        return programDetails;
    }

    public void setProgramDetails(PatientProgramDetails programDetails) {
        this.programDetails = programDetails;
    }

    public Double getRhze() {
        return rhze;
    }

    public void setRhze(Double rhze) {
        this.rhze = rhze;
    }

    public Double getRh() {
        return rh;
    }

    public void setRh(Double rh) {
        this.rh = rh;
    }

    public Double getRhz() {
        return rhz;
    }

    public void setRhz(Double rhz) {
        this.rhz = rhz;
    }

    public Double getRhp() {
        return rhp;
    }

    public void setRhp(Double rhp) {
        this.rhp = rhp;
    }

    public Double getEth() {
        return eth;
    }

    public void setEth(Double eth) {
        this.eth = eth;
    }

    public Double getIso() {
        return iso;
    }

    public void setIso(Double iso) {
        this.iso = iso;
    }
}
