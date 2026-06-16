using { anubhav.db.master as master } from '../db/datamodel';

service CatalogService @(path:'/CatalogService') 
{
entity EmployeeSet as projection on master.Address;


entity BPSet as projection on master.BusinessPartner;
}