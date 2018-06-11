using System;
using System.Collections.Generic;

namespace ZQNB.BaseLib.Users
{
    public interface IOrgUserCountService
    {
        /// <summary>
        /// 组织的用户计数
        /// </summary>
        /// <returns></returns>
        IList<OrgUserCount> GetOrgUserCounts();

        /// <summary>
        /// 获取某个组织下的用户计数
        /// </summary>
        /// <param name="orgId"></param>
        /// <returns></returns>
        int CountOrgUser(Guid orgId);
    }

    public class OrgUserCount
    {
        public Guid OrgId { get; set; }
        public Guid? ParentOrgId { get; set; }
        public string OrgName { get; set; }
        public int UserCount { get; set; }
    }
}