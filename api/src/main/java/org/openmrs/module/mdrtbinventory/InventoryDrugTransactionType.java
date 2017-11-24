package org.openmrs.module.mdrtbinventory;

import java.io.Serializable;

/**
 * Created by Dennys Henry
 * Created on 11/24/2017.
 */
public class InventoryDrugTransactionType implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private String name;
    private Integer direction;

    public InventoryDrugTransactionType(){}

    public InventoryDrugTransactionType(Integer id){
        this.id = id;
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

    public Integer getDirection() {
        return direction;
    }

    public void setDirection(Integer direction) {
        this.direction = direction;
    }
}
