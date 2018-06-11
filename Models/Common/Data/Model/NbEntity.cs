using System;

namespace ZQNB.Common.Data.Model
{
    public interface INbEntity<TPk>
    {
        /// <summary>
        /// 主键
        /// </summary>
        TPk Id { get; set; }
    }

    public abstract class NbEntityBase<T, TPk> : INbEntity<TPk> where T : class, INbEntity<TPk>
    {
        public virtual TPk Id { get; set; }

        private readonly TPk _defaultIdValue = default(TPk);
        private int? _oldHashCode;

        public override int GetHashCode()
        {
            // once we have a hashcode we'll never change it
            if (_oldHashCode.HasValue)
                return _oldHashCode.Value;
            // when this instance is new we use the base hash code
            // and remember it, so an instance can NEVER change its
            // hash code.
            var thisIsNew = Equals(Id, _defaultIdValue);
            if (thisIsNew)
            {
                _oldHashCode = base.GetHashCode();
                return _oldHashCode.Value;
            }
            return Id.GetHashCode();
        }

        public override bool Equals(object obj)
        {
            var other = obj as T;
            if (other == null) return false;

            var thisIsNew = Equals(Id, _defaultIdValue);
            var otherIsNew = Equals(other.Id, _defaultIdValue);

            if (thisIsNew && otherIsNew)
                return ReferenceEquals(this, other);

            return Id.Equals(other.Id);
        }

        public static bool operator ==(NbEntityBase<T, TPk> lhs, NbEntityBase<T, TPk> rhs)
        {
            return Equals(lhs, rhs);
        }

        public static bool operator !=(NbEntityBase<T, TPk> lhs, NbEntityBase<T, TPk> rhs)
        {
            return !Equals(lhs, rhs);
        }
    }

    //aggregate root entity
    public abstract class NbEntity<T> : NbEntityBase<T, Guid> where T : class ,INbEntity<Guid>
    {
    }
}
