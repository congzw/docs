using System.Collections.Generic;

namespace ZQNB.BaseLib.Users
{
    /// <summary>
    /// 用户类型描述仓储
    /// </summary>
    public interface IUserTypeDescRepository
    {
        /// <summary>
        /// 所有用户类型描述
        /// </summary>
        /// <returns></returns>
        IList<UserTypeDesc> GetAllUserTypeDescs();
    }
    
    /// <summary>
    /// 用户类型描述
    /// </summary>
    public class UserTypeDesc
    {
        /// <summary>
        /// 唯一码
        /// </summary>
        public string Code { get; set; }
        /// <summary>
        /// 名称
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 描述
        /// </summary>
        public string Description { get; set; }
    }
}
