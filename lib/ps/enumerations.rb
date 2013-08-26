class CreditCardIssuer
  VISA     = 1
  MASTER   = 2
  AMEX     = 3
  DISCOVER = 4
end

class BillingFrequencyType
  DAILY                 = 1
  WEEKLY                = 2
  BI_WEEKLY             = 3
  FIRST_OF_MONTH        = 4
  SPECIFIC_DAY_OF_MONTH = 5
  LAST_OF_MONTH         = 6
  QUARTERLY             = 7
  SEMI_ANNUALLY         = 8
  ANNUALLY              = 9
end

class RecurringScheduleType
  PAYMENT_PLAN = 1
  BILL_PAYMENT = 2
end

class ErrorCodeType
  NONE = 0
end

class PaymentType
  CC  = 1
  ACH = 2
end

class CreditCardPaymentType
  MOTO  = 11
  SWIPE = 10
end

class AchPaymentType
  ARC  = 3
  WEB  = 4
  TEL  = 5
  PPD  = 6
  CCD  = 7
  BOC  = 8
  RCK  = 9
  ACHD = 16
end

class Sort
  ASC  = 0
  DESC = 1
end

class PaymentStatus
  ALL               = -1
  PENDING           = 0
  POSTED            = 1
  SETTLED           = 2
  FAILED            = 3
  RESUBMITTED       = 4
  VOIDED            = 5
  REVERSED          = 6
  SAVED             = 7
  SCHEDULED         = 8
  REVERSEPOSTED     = 9
  CHARGEBACK        = 10
  CLOSECHARGEBACK   = 11
  AUTHORIZED        = 12
  RETURNED          = 13
  REVERSECHARGEBACK = 14
  REVERSENSF        = 15
  REVERSERETURN     = 16
  REFUNDSETTLED     = 17
end

module PS
  class InvoiceScheduleStatus
    EXPIRED   = 1
    SUSPENDED = 2
    DRAFT     = 3
    ACTIVE    = 4
  end
  
  class InvoiceStatus
    PAID          = 0
    UNPAID        = 1
    DRAFT         = 2
    CANCELLED     = 3
    OVERDUE       = 4
    PAIDPARTIALLY = 5
  end

  class ScheduleStatus
    DISABLE     = 0
    ACTIVE      = 1
    PAUSE_UNTIL = 2
    EXPIRED     = 3
    SUSPENDED   = 4
  end

  class PaymentDateRangeType
    PAYMENT_DATE = 0
    SETTLED_DATE = 1
  end
end



