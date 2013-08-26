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

class Country
  MERICA = 1 # :D
  AMERICA = 1
  CANADA = 3
end

class States
  AP = 74
  WI = 49
  GA = 11
  MD = 21
  ME = 22
  GU = 68
  CA = 5
  VT = 47
  AR = 3
  ID = 14
  VA = 46
  AS = 71
  CT = 7
  FL = 10
  OH = 36
  AA = 76
  FM = 75
  MH = 70
  KY = 18
  PR = 52
  SK = 64
  MI = 23
  PA = 39
  AB = 53
  OK = 37
  NS = 59
  LA = 19
  NB = 56
  NT = 58
  AE = 72
  NC = 28
  NU = 60
  TX = 44
  PW = 73
  PE = 62
  ON = 61
  NV = 34
  ND = 29
  VI = 69
  YT = 65
  AZ = 4
  NE = 30
  WA = 48
  IL = 15
  MN = 24
  UT = 45
  MO = 25
  RI = 40
  NY = 35
  MP = 67
  DC = 8
  WV = 50
  IN = 16
  NH = 31
  AK = 1
  OR = 38
  OTHER = 66
  NJ = 32
  SC = 41
  BC = 54
  AL = 2
  MA = 20
  QC = 63
  MS = 26
  SD = 42
  TN = 43
  DE = 9
  MB = 55
  KS = 17
  NL = 57
  MT = 27
  WY = 51
  CO = 6
  NM = 33
  IA = 13
  HI = 12
end

