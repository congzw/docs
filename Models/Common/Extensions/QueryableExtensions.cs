using System.Linq;

namespace ZQNB.Common.Extensions
{
    public static class QueryableExtensions
    {
        /// <summary>
        /// 
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="query"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public static PaginatedList<T> ToPaginatedList<T>(this IQueryable<T> query, int pageIndex, int pageSize)
        {
            int totalCount = query.Count();
            IQueryable<T> collection = query.Skip((pageIndex - 1) * pageSize).Take(pageSize);

            return new PaginatedList<T>(collection, pageIndex, pageSize, totalCount);
        }

        //todo

        ///// <summary>
        ///// 转换成分页查询结果
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="query"></param>
        ///// <param name="pageIndex"></param>
        ///// <param name="pageSize"></param>
        ///// <returns></returns>
        //public static PagerQueryResult<T> ToPagerQueryResult<T>(this IQueryable<T> query, int pageIndex, int pageSize)
        //{
        //    int totalCount = query.Count();
        //    IList<T> collection = query
        //        .Skip((pageIndex - 1) * pageSize)
        //        .Take(pageSize).ToList();

        //    return PagerQueryResult<T>.Create(collection, pageIndex, pageSize, totalCount);
        //}
        
        ///// <summary>
        ///// 转换成分页查询结果
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="query"></param>
        ///// <param name="pageIndex"></param>
        ///// <param name="pageSize"></param>
        ///// <returns></returns>
        //public static PagerQueryResult<T> ToPagerQueryResult<T>(this IList<T> query, int pageIndex, int pageSize)
        //{
        //    #region Why not support IEnumerable<> query interface!

        //    //https://www.jetbrains.com/help/resharper/2016.2/PossibleMultipleEnumeration.html
        //    //Consider the following code snippet:
        //    //IEnumerable<string> names = GetNames();
        //    //foreach (var name in names)
        //    //Console.WriteLine("Found " + name);
        //    //var allNames = new StringBuilder();
        //    //foreach (var name in names)
        //    //allNames.Append(name + " ");
        //    //If necessary, you can make code issues detected with this inspection more or less noticeable by changing the severity level of this inspection (the Do not show severity will disable it altogether) or else, you can suppress the inspection for specific code with a comment or with an attribute.
        //    //Assuming that GetNames() returns an IEnumerable<string>, we are, effectively, doing extra work by enumerating this collection twice in the two foreach statements. If GetNames() results in a database query, you end up doing that query twice, while both times getting the same data.

        //    //This kind of problem can be easily fixed – simply force the enumeration at the point of variable initialization by converting the sequence to an array or a list, e.g.:

        //    //IEnumerable<string> names = GetNames().ToList();

        //    #endregion

        //    int totalCount = query.Count();
        //    IList<T> collection = query
        //        .Skip((pageIndex - 1) * pageSize)
        //        .Take(pageSize).ToList();

        //    return PagerQueryResult<T>.Create(collection, pageIndex, pageSize, totalCount);
        //}

        ///// <summary>
        ///// 转换成分页查询结果
        ///// </summary>
        ///// <typeparam name="T"></typeparam>
        ///// <param name="query"></param>
        ///// <param name="pageIndex"></param>
        ///// <param name="pageSize"></param>
        ///// <returns></returns>
        //public static PagerRecords<T> ToPageRecords<T>(this IQueryable<T> query, int pageIndex, int pageSize)
        //{
        //    return PagerRecords<T>.Create(query, pageIndex, pageSize);
        //}
    }
}