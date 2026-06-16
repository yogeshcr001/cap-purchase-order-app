using { anubhav.db.master as master,anubhav.db.transaction as transaction } from '../db/datamodel';

service CatalogService @(path:'/CatalogService') 
{
entity EmpAddress as projection on master.Address;

entity BPSet as projection on master.BusinessPartner;

entity Emplyee as projection on master.employees;

entity Items as projection on transaction.POItems;

entity Products as projection on transaction.Product;

entity Labels as projection on transaction.ProductText;

entity Orders as projection on transaction.PurchaseOrder;

}