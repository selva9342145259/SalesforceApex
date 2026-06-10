public with sharing class AccountHandler {

public static  void accountPriyority(Map<id, Account> oldAccounts,List<Account> newAcc){

for (Account acc : newAcc) {
    Account oldAccount =oldAccounts.get(acc.id);
    if(acc.AnnualRevenue!=null&& acc.AnnualRevenue!=oldAccount.AnnualRevenue&&acc.AnnualRevenue>50000000){
        acc.Rating='Hot';
    }
}
}
}