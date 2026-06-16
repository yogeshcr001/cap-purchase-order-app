namespace anubhav.common;
using {sap , common,managed  } from '@sap/cds/common';

type Gender : String(1) enum{
    MALE = 'M';
    Female = 'F';
};

type AmountT: Decimal(15,2)@(

Semantics.amount.currencyCode: 'CURRENCY_CODE',

sap.unit: 'CURRENCY_CODE'

);

aspect Amount {
    CURRENCY_CODE : String(4);
    GROSS_AMOUNT  : AmountT;
    NET_AMOUNT    : AmountT;
    TAX_AMOUNT    : AmountT;
}

type email : String(50) @assert.format : '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' ;

type phoneNumber : String(50) @assert.format : '^[6-9]\d{9}$' ;