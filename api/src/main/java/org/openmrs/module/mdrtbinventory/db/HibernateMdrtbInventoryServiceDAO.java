package org.openmrs.module.mdrtbinventory.db;

import com.sun.org.apache.xpath.internal.operations.Bool;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.openmrs.Location;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.mdrtbinventory.*;

import java.util.Date;
import java.util.List;

/**
 * Created by Dennys Henry
 * Created on 11/23/2017.
 */
public class HibernateMdrtbInventoryServiceDAO
        implements MdrtbInventoryServiceDAO {
    protected final Log log = LogFactory.getLog(getClass());
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) throws DAOException {
        this.sessionFactory = sessionFactory;
    }
    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }


    @Override
    public InventoryDrugFacility getFacilityDrug(Integer id) {
        Criteria criteria = getSession().createCriteria(InventoryDrugFacility.class);
        criteria.add(Restrictions.eq("id", id));

        return  (InventoryDrugFacility) criteria.uniqueResult();
    }

    @Override
    public List<InventoryDrugFacility> getFacilityDrugs(List<Location> locations) {
        Criteria criteria = getSession().createCriteria(InventoryDrugFacility.class);
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.in("location", locations));

        return criteria.list();
    }

    @Override
    public InventoryDrugFacility saveFacilityDrug(InventoryDrugFacility drug) {
        return (InventoryDrugFacility)getSession().merge(drug);
    }

    @Override
    public List<InventoryDrugCategory> getInventoryDrugCategories() {
        Criteria criteria = getSession().createCriteria(InventoryDrugCategory.class);
        criteria.add(Restrictions.eq("voided", false));

        return criteria.list();
    }

    @Override
    public List<InventoryDrugTransaction> getInventoryDrugTransactions(List<Location> locations, InventoryDrugTransactionType type, Date startDate, Date endDate) {
        Criteria criteria = getSession().createCriteria(InventoryDrugTransaction.class);
        criteria.createAlias("item", "item");
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.in("item.location", locations));

        if (type != null){
            criteria.add(Restrictions.eq("type", type));
        }

        if (startDate != null && endDate != null){
            criteria.add(Restrictions.between("date", startDate, endDate));
        }
        else if(endDate != null){
            criteria.add(Restrictions.le("date", endDate));
        }
        else if(startDate != null){
            criteria.add(Restrictions.ge("date", startDate));
        }

        return criteria.list();
    }

    @Override
    public InventoryDrugTransactionType getInventoryDrugTransactionType(Integer id) {
        Criteria criteria = getSession().createCriteria(InventoryDrugTransactionType.class);
        criteria.add(Restrictions.eq("id", id));

        return  (InventoryDrugTransactionType) criteria.uniqueResult();
    }

    @Override
    public List<InventoryDrugBatches> getExpiredBatches(List<Location> locations, Boolean indented) {
        Criteria criteria = getSession().createCriteria(InventoryDrugBatches.class);
        criteria.createAlias("item", "item");
        criteria.add(Restrictions.eq("voided", false));
        criteria.add(Restrictions.le("expiry", new Date()));
        criteria.add(Restrictions.in("item.location", locations));

        if (indented != null && indented){
            criteria.add(Restrictions.isNotNull("indentedOn"));
        }
        else if (indented != null && !indented){
            criteria.add(Restrictions.isNull("indentedOn"));
        }

        return criteria.list();
    }
}
