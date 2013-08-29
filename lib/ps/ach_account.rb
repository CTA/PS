module PS
  class AchAccount < CustomerAccount
    attr_accessor :is_checking_account, :routing_number, :account_number, :bank_name 
  end
end
