# Linq


## Linq Group Count


### 2 sqls


    var queryUser = QueryUser();
    var groupBy = queryUser.GroupBy(x => x.OrgId)
        .Select(x => new OrgUserCount() { OrgId = x.Key, Count = x.Count() });
    var orgUserCounts =  groupBy.ToList();


### group join into


    //https://stackoverflow.com/questions/695506/linq-left-join-group-by-and-count
            
    //You shouldn't need the left join at all if all you're doing is Count(). 
    //Note that join...into is actually translated to GroupJoin which returns groupings like 
    //new{parent, IEnumerable<child>} 
    //so you just need to call Count() on the group:
    var query =
        from p in QueryOrg()
        join c in QueryUser() on p.Id equals c.OrgId into g
        select new OrgUserCount() { OrgId = p.Id, OrgName = p.Name, Count = g.Count() };
    return query.ToList();


###  sub query

    var query =
    from p in QueryOrg()
    let cCount =
    (
        from c in QueryUser()
        where p.Id == c.OrgId
        select c
    ).Count()
    select new OrgUserCount() { OrgId = p.Id, OrgName = p.Name, Count = cCount };
    return query.ToList();

