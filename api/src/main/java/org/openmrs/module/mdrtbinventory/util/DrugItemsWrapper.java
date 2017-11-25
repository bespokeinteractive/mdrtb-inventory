package org.openmrs.module.mdrtbinventory.util;

import java.util.Date;

/**
 * Created by Dennys Henry
 * Created on 11/25/2017.
 */
public class DrugItemsWrapper {
    private Integer id;
    private Date date;
    private Integer facility;
    private String supplier;
    private String description;

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

    public Integer getFacility() {
        return facility;
    }

    public void setFacility(Integer facility) {
        this.facility = facility;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
