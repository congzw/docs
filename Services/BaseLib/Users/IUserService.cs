using System;

namespace ZQNB.BaseLib.Users
{
    public interface IUserService
    {
        User GetByLoginName(string loginName); 
        bool IsLoginNameExist(string loginName, Guid? excludedId = null);
        bool IsEmailExist(string email, Guid? excludedId = null);
        bool IsCustomNoExist(string customNo, Guid? excludedId = null); 
        User GetByEmail(string email);
        bool ChangeUserOrg(ChangeUserOrgDto changeUserOrgDto);
    }

    public class ChangeUserOrgDto
    {
    }
}
