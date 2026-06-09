Account acc = new Account(
    Name = 'accAmount',
    Rating = 'Hot'
);

insert acc;

Opportunity opp = new Opportunity(
    Name = 'TamilTest',
    StageName = 'Closed Won',
    CloseDate = System.today().addDays(5),
    Amount = 100,
    AccountId = acc.Id
);

insert opp;

System.debug(opp.Id);