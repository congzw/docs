----IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Basic_Menu_SelectAll]') AND type in (N'P', N'PC'))
----BEGIN
----	Select '不存在'
----END
----ELSE
----begin
----	select '存在了'
----end
--
----查看某些objects
--SELECT * FROM sys.objects 
--WHERE
--type in (N'P', N'PC')
----object_id = OBJECT_ID(N'[dbo].[Basic_Menu_SelectAll]')
---- AND
--
----AF = 聚合函数 (CLR)
----C = CHECK 约束
----D = DEFAULT（约束或独立）
----F = FOREIGN KEY 约束
----FN = SQL 标量函数
----FS = 程序集 (CLR) 标量函数
----FT = 程序集 (CLR) 表值函数
----IF = SQL 内联表值函数
----IT = 内部表
----P = SQL 存储过程
----PC = 程序集 (CLR) 存储过程
----PG = 计划指南
----PK = PRIMARY KEY 约束
----R = 规则（旧式，独立）
----RF = 复制筛选过程
----S = 系统基表
----SN = 同义词
----SQ = 服务队列
----TA = 程序集 (CLR) DML 触发器
----TF = SQL 表值函数
----TR = SQL DML 触发器
----TT = 表类型
----U = 表（用户定义类型）
----UQ = UNIQUE 约束
----V = 视图
----X = 扩展存储过程
--
----查看某个存储过程的参数列表
--SELECT SCHEMA_NAME(schema_id) AS schema_name
--    ,o.name AS object_name
--    ,o.type_desc
--    ,p.parameter_id
--    ,p.name AS parameter_name
--    ,TYPE_NAME(p.user_type_id) AS parameter_type
--    ,p.max_length
--    ,p.precision
--    ,p.scale
--    ,p.is_output
--FROM sys.objects AS o
--INNER JOIN sys.parameters AS p ON o.object_id = p.object_id
--WHERE o.object_id = OBJECT_ID(N'[dbo].[Basic_Menu_SelectAll]')
--ORDER BY schema_name, o.name, p.parameter_id;



--查看最近改了那些东西
SELECT name AS object_name 
  ,SCHEMA_NAME(schema_id) AS schema_name
  ,type_desc
  ,create_date
  ,modify_date
FROM sys.objects
WHERE modify_date > GETDATE() - 90 --局限在的天数
and type_desc = 'USER_TABLE'
ORDER BY modify_date desc, create_date desc;