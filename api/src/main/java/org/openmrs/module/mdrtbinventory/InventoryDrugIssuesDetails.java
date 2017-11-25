package org.openmrs.module.mdrtbinventory;

import java.io.Serializable;

/**
 * Created by Dennys Henry
 * Created on 11/25/2017.
 */
public class InventoryDrugIssuesDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private InventoryDrugIssues issue;
    private InventoryDrugBatches batch;
    private Double quantity;
    private String comments;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public InventoryDrugIssues getIssue() {
        return issue;
    }

    public void setIssue(InventoryDrugIssues issue) {
        this.issue = issue;
    }

    public InventoryDrugBatches getBatch() {
        return batch;
    }

    public void setBatch(InventoryDrugBatches batch) {
        this.batch = batch;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
}
