using ZQNB.Common.Data.Model;

namespace ZQNB.BaseLib
{
    /// <summary>
    /// 简单模型的增删改查等数据服务接口
    /// 为典型的增删改查类型的数据服务提供一个一致性的命名接口，简单数据的服务，建议从此继承但不做强制要求
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <typeparam name="TPk"></typeparam>
    public interface ICrudService<T, in TPk> where T : INbEntity<TPk>
    {
        
    }
}
