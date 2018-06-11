using System;
using System.Linq;

namespace ZQNB.BaseLib.Users
{
    public interface IUserService<T> : ICrudService<T, Guid> where T : User, new()
    {
        User GetByLoginName(string loginName); 
        bool IsLoginNameExist(string loginName, Guid? excludedId = null);
        bool IsEmailExist(string email, Guid? excludedId = null);
        bool IsCustomNoExist(string customNo, Guid? excludedId = null); 
        User GetByEmail(string email);
        bool ChangeUserOrg(ChangeUserOrgDto changeUserOrgDto);
        IQueryable<T> QueryUsers(QueryUsersArgs queryUsersArgs);
    }

    public class QueryUsersArgs
    {
        public Guid? SiteId { get; set; }
        public string Name { get; set; }
        public string RoleCode { get; set; }
        public Guid? OrgId { get; set; }
        public bool IncludeChildOrg { get; set; }
    }

    public class ChangeUserOrgDto
    {
    }

}
