package org.openmrs.module.mdrtbinventory;

import org.openmrs.Location;
import org.openmrs.User;
import org.openmrs.api.context.Context;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/24/2017.
 */
public class InventoryDrugBatches
        implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Date date;
    private InventoryDrugFacility item;
    private String batch;
    private Double receipt;
    private Double available;
    private Date manufactured;
    private Date expiry;
    private String comments;
    private Date createdOn;
    private User createdBy;
    private Date indentedOn;
    private User indentedBy;
    private Boolean voided;
    private Date voidedOn;
    private User voidedBy;
    private String voidReason;

    public InventoryDrugBatches(){
        this.voided = false;

        this.createdOn = new Date();
        this.createdBy = Context.getAuthenticatedUser();
    }

    public InventoryDrugBatches(InventoryDrugFacility item, String batch){
        super();

        this.item = item;
        this.batch = batch;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public InventoryDrugFacility getItem() {
        return item;
    }

    public void setItem(InventoryDrugFacility item) {
        this.item = item;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }

    public Double getReceipt() {
        return receipt;
    }

    public void setReceipt(Double receipt) {
        this.receipt = receipt;
    }

    public Double getAvailable() {
        return available;
    }

    public void setAvailable(Double available) {
        this.available = available;
    }

    public Date getManufactured() {
        return manufactured;
    }

    public void setManufactured(Date manufactured) {
        this.manufactured = manufactured;
    }

    public Date getExpiry() {
        return expiry;
    }

    public void setExpiry(Date expiry) {
        this.expiry = expiry;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
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

    public Date getIndentedOn() {
        return indentedOn;
    }

    public void setIndentedOn(Date indentedOn) {
        this.indentedOn = indentedOn;
    }

    public User getIndentedBy() {
        return indentedBy;
    }

    public void setIndentedBy(User indentedBy) {
        this.indentedBy = indentedBy;
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
