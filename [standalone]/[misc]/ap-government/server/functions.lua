GetAccountData = function(business)
  if Config.JobManagementScriptName == "oxide-banking" then
    if exports["oxide-banking"]:GetAccount(business) then
      return exports["oxide-banking"]:GetAccountBalance(business)
    else exports["oxide-banking"]:CreateJobAccount(business, 0)
      return 0
    end
  else return exports[Config.JobManagementScriptName]:GetAccount(business) end
end

AddAccountMoney = function(business, amount)
  return exports[Config.JobManagementScriptName]:AddMoney(business, amount)
end

RemoveAccountMoney = function(business, amount)
  return exports[Config.JobManagementScriptName]:RemoveMoney(business, amount)
end

BankingTransaction = function(identifier, amount, tax)
  if Config.Banking.okokbanking then
    TriggerEvent('okokBanking:AddNewTransaction', "Government", "", getName(identifier), identifier, amount, tax.." Tax")
  elseif Config.Banking.other then
    -- Add event/export here.
  end
end