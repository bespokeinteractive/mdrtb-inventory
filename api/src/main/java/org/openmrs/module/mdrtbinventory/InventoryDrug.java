package org.openmrs.module.mdrtbinventory;

import org.openmrs.Drug;
import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class InventoryDrug
        implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Drug drug;
    private InventoryDrugCategory category;
    private InventoryDrugFormulation formulation;
    private Date createdOn;
    private User createdBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    public InventoryDrug(){
        this.voided = false;

        this.createdOn = new Date();
        this.createdBy = Context.getAuthenticatedUser();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Drug getDrug() {
        return drug;
    }

    public void setDrug(Drug drug) {
        this.drug = drug;
    }

    public InventoryDrugCategory getCategory() {
        return category;
    }

    public void setCategory(InventoryDrugCategory category) {
        this.category = category;
    }

    public InventoryDrugFormulation getFormulation() {
        return formulation;
    }

    public void setFormulation(InventoryDrugFormulation formulation) {
        this.formulation = formulation;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Boolean getVoided() {
        return voided;
    }

    public void setVoided(Boolean voided) {
        this.voided = voided;
    }

    public Date getVoidedOn() {
        return voidedOn;
    }

    public void setVoidedOn(Date voidedOn) {
        this.voidedOn = voidedOn;
    }

    public User getVoidedBy() {
        return voidedBy;
    }

    public void setVoidedBy(User voidedBy) {
        this.voidedBy = voidedBy;
    }

    public String getVoidReason() {
        return voidReason;
    }

    public void setVoidReason(String voidReason) {
        this.voidReason = voidReason;
    }
}
