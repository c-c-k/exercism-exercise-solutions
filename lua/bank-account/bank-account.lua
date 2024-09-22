local BankAccount = {}

BankAccount.__index = BankAccount

BankAccount.new = function(self)
  local account = setmetatable({}, self)
  account._balance = 0
  account._active = true
  return account
end

BankAccount.close = function(self)
  self._active = false
  return self
end

BankAccount.balance = function(self)
  return self._balance
end

BankAccount.deposit = function(self, amount)
  assert(amount > 0, 'ERROR: Deposite amount must be positive')
  assert(self._active, 'ERROR: Can not deposite to closed account')
  self._balance = self._balance + amount
end

BankAccount.withdraw = function(self, amount)
  assert(amount > 0, 'ERROR: Withdrawal amount must be positive')
  assert(
    amount <= self._balance,
    'ERROR: Overdraw not allowed, withdrawal amount must not be greater than balance'
  )
  assert(self._active, 'ERROR: Can not withdraw from closed account')
  self._balance = self._balance - amount
end

return BankAccount
