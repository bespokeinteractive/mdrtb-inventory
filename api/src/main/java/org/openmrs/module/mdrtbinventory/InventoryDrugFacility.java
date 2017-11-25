package org.openmrs.module.mdrtbinventory;

import org.openmrs.Location;
import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class InventoryDrugFacility
        implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private InventoryDrug drug;
    private Location location;
    private Double available;
    private Double reorder;
    private Date createdOn;
    private User createdBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    //Non-Persistent Objects
    private Boolean hasBatches;
    private List<InventoryDrugBatches> batches;

    public InventoryDrugFacility(){
        this.voided = false;
        this.reorder = 0.0;
        this.available = 0.0;

        this.createdOn = new Date();
        this.createdBy = Context.getAuthenticatedUser();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public InventoryDrug getDrug() {
        return drug;
    }

    public void setDrug(InventoryDrug drug) {
        this.drug = drug;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Double getAvailable() {
        return available;
    }

    public void setAvailable(Double available) {
        this.available = available;
    }

    public Double getReorder() {
        return reorder;
    }

    public void setReorder(Double reorder) {
        this.reorder = reorder;
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

    public Boolean getHasBatches() {
        return hasBatches;
    }

    public void setHasBatches(Boolean hasBatches) {
        this.hasBatches = hasBatches;
    }

    public List<InventoryDrugBatches> getBatches() {
        return batches;
    }

    public void setBatches(List<InventoryDrugBatches> batches) {
        this.batches = batches;
    }
}
