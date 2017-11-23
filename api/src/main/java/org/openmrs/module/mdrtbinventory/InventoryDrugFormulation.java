package org.openmrs.module.mdrtbinventory;

import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class InventoryDrugFormulation
        implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String name;
    private String dosage;
    private String description;
    private Date createdOn;
    private User createdBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    public InventoryDrugFormulation(){
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
