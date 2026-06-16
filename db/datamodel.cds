namespace anubhav.db; // check the CSV name it starts from here and then CONTEXT then TABLE

using {
    cuid,
    managed,
    Currency,
    temporal
} from '@sap/cds/common';

using {anubhav.common} from './csv/common';


context master {

    entity BusinessPartner : cuid, managed, common.Amount { //both from standard and custom

        bpNumber     : String(20);
        bpName       : String(100);
        sex          : common.Gender;

        // 1 = Customer
        // 2 = Vendor
        b_id         : Integer;

        email        : common.email;
        phoneNumber  : String(20);
        gstNumber    : String(20);
        companyCode  : String(10);
        salary       : common.AmountT; // from self declared common.cds then using it here
        currencyCode : Currency; // from common aspect from SAP directly

        add_id       : UUID;

        address      : Association to Address
                           on address.ID = add_id;
    }

    annotate master.BusinessPartner with {
        companyCode @title: '{i18n>companyCode}';
        bpName      @title: '{i18n>bpName}';
    };

    entity Address : cuid, managed {

        street          : String(100);
        city            : String(50);
        state           : String(50);
        pincode         : String(10);
        country         : String(50);

        bp_id           : UUID;

        businessPartner : Association to BusinessPartner
                              on businessPartner.ID = bp_id;
    }

    entity employees : cuid, temporal {

        nameFirst     : String(40);
        nameMiddle    : String(40);
        nameLast      : String(40);
        nameInitials  : String(40);
        sex           : common.Gender;
        language      : String(1);
        phoneNumber   : common.phoneNumber;
        email         : common.email;
        loginName     : String(12);
        Currency      : Currency;
        salaryAmount  : common.AmountT;
        accountNumber : String(16);
        bankId        : String(8);
        bankName      : String(64);

    }

}

context transaction {
entity ProductText {

    key NODE_KEY          : UUID;

    PARENT                : Association to Product;

    LANGUAGE              : String(2);
    TEXT                  : String(256);
}

 entity POItems {

    key NODE_KEY          : UUID;

    PARENT                : Association to PurchaseOrder;

    PO_ITEM_POS           : Integer;

    PRODUCT               : Association to Product;

    CURRENCY_CODE         : String(4);

    GROSS_AMOUNT          : Decimal(15,2);
    NET_AMOUNT            : Decimal(15,2);
    TAX_AMOUNT            : Decimal(15,2);
}

entity PurchaseOrder {

    key NODE_KEY          : UUID;

    PO_ID                 : String(24);

    PARTNER               : Association to master.BusinessPartner;

    CURRENCY_CODE         : String(4);

    GROSS_AMOUNT          : Decimal(15,2);
    NET_AMOUNT            : Decimal(15,2);
    TAX_AMOUNT            : Decimal(15,2);

    LIFECYCLE_STATUS      : String(1);
    OVERALL_STATUS        : String(1);

    Items                 : Composition of many POItems
                            on Items.PARENT = $self;
}

entity Product {

    key NODE_KEY          : UUID;

    PRODUCT_ID            : String(28);
    TYPE_CODE             : String(2);
    CATEGORY              : String(32);

    TAX_TARIF_CODE        : Integer;

    MEASURE_UNIT          : String(2);

    WEIGHT_MEASURE        : Decimal(15,2);
    WEIGHT_UNIT           : String(2);

    CURRENCY_CODE         : String(4);
    PRICE                 : Decimal(15,2);

    WIDTH                 : Decimal(15,2);
    DEPTH                 : Decimal(15,2);
    HEIGHT                : Decimal(15,2);
    DIM_UNIT              : String(2);

    SUPPLIER              : Association to master.BusinessPartner;

    Texts                 : Composition of many ProductText
                            on Texts.PARENT = $self;
}
}
