#TODO: make this not suck
module PS
  class SubType
    TYPES = {
      "PsCustomer" => PS::Customer,
      "PsCustomerAccount" => PS::CustomerAccount,
      "PsPayment" => PS::Payment
    }
  end
end
