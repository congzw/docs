using System;
using System.Linq;

namespace ZQNB.BaseLib.Users
{
    public interface ITeacherService
    {
        IQueryable<Teacher> QueryTeachersWithPage(QueryTeachersArgs queryTeachersArgs);
    }

    public class QueryTeachersArgs
    {
        public Guid? SiteId { get; set; }
        public Guid? OrgId { get; set; }
        public string Name { get; set; }
        public string RoleCode { get; set; }
        public string SubjectCode { get; set; }
        public string PositionCode { get; set; }
        public string PhaseCode { get; set; }
        public string SubjectPermissionCode { get; set; }
    }
}