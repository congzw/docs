-- 查找包含<列名>的所有表.  
select object_name(id) as TableName, name as ColumnName from syscolumns
	where 
[name]= 'SiteId' 
and  OBJECTPROPERTY(id,'IsUserTable')=1
--and  object_name(id)='App_KTPJ_CourseInfo'

-- 查找包含<列名>的所有表.  拼接查询列相关数据的语句
SELECT
'SELECT '+ name + ' FROM ' +  object_name(id)
 from syscolumns
	where 
[name]= 'SiteId' 
and  OBJECTPROPERTY(id,'IsUserTable')=1


-- 查找包含<列名>的所有表.  拼接查询列相关数据的语句
--SELECT
--'INSERT INTO [dbo].[Temp_Table](TableName,SiteIdCount)
--SELECT ''' + OBJECT_NAME(id) + ''' AS TableName, COUNT(SiteId) AS SiteIdCount FROM ' + OBJECT_NAME(id)
--+'
--;'
-- from syscolumns
--	where 
--[name]= 'SiteId' 
--and  OBJECTPROPERTY(id,'IsUserTable')=1

--CREATE TABLE [dbo].[Temp_Table](
--	[TableName] [nvarchar](500) NOT NULL,
--	[SiteIdCount] [int] NOT NULL
--) ON [PRIMARY]

--TRUNCATE TABLE Temp_Table
--SELECT * FROM [dbo].[Temp_Table]



----查询库中的所有表名
--select * from sysobjects where xtype='u'
--查询指定表的所有列名
select * from syscolumns where id in (
select id from sysobjects where xtype='u'
)
and name like 'DomainGuid%'

select * from syscolumns where id= '1205579333' or id ='213575799'
select * from sysobjects where xtype='u' and (id= '1205579333' or id ='213575799')

-- 假设表为<表名>,要添加的字段是<列名>.  
select *  from syscolumns where 
[name]= '<列名>' 
and OBJECTPROPERTY(id,'IsUserTable')=1
and object_name(id)='<表名>'



-- 查看表是否存在某个列（假设表为<表名>,要添加的字段是<列名>. ）
select 1 WHERE
EXISTS (
	select object_name(id) as TableName, name as ColumnName from syscolumns
	 where 
	[name]= 'Title' 
	and  OBJECTPROPERTY(id,'IsUserTable')=1
	and  object_name(id)='App_KTPJ_CourseInfo'
)

--use [NbV3.1Db]
--GO

--IF NOT EXISTS (
--	select object_name(id) as TableName, name as ColumnName from syscolumns
--	 where 
--	[name]= 'Title' 
--	and  OBJECTPROPERTY(id,'IsUserTable')=1
--	and  object_name(id)='App_KTPJ_CourseInfo'
--)
--begin
--	--修改数据库表的脚本
--	ALTER TABLE [dbo].[App_KTPJ_CourseInfo]
--	ADD [Title] nvarchar(255) null
--	UPDATE [dbo].[App_KTPJ_CourseInfo]
--	   SET [Title] = '课程标题'
--	WHERE [Title] is null
--end
--


--sqlserver中各个系统表的作用
--sysaltfiles 主数据库 保存数据库的文件
--syscharsets 主数据库 字符集与排序顺序
--sysconfigures 主数据库 配置选项
--syscurconfigs 主数据库 当前配置选项
--sysdatabases 主数据库 服务器中的数据库
--syslanguages 主数据库 语言
--syslogins 主数据库 登陆帐号信息
--sysoledbusers 主数据库 链接服务器登陆信息
--sysprocesses 主数据库 进程
--sysremotelogins主数据库 远程登录帐号

--syscolumns 每个数据库 列
--sysconstrains 每个数据库 限制
--sysfilegroups 每个数据库 文件组
--sysfiles 每个数据库 文件
--sysforeignkeys 每个数据库 外部关键字
--sysindexs 每个数据库 索引
--sysmenbers 每个数据库 角色成员
--sysobjects 每个数据库 所有数据库对象
--syspermissions 每个数据库 权限
--systypes 每个数据库 用户定义数据类型
--sysusers 每个数据库 用户


----查询库中的所有包含列OrgXXX的表
--select * from sysobjects where xtype='u' and id in (
--	select id from syscolumns where id in (
--	select id from sysobjects where xtype='u'
--)
--and name like 'Org%'
--)



----所有表的所有列的信息
--SELECT
--[表名]=CASE WHEN T.column_id = 1 THEN OBJECT_NAME(T.object_id) ELSE '' END ,
--[字段编号]=T.column_id,
--[字段名]=T.name,
--[主键]=case when exists(SELECT 1 FROM sys.key_constraints  where type='PK' and object_id=T.OBJECT_ID) THEN '●' ELSE '' END,
--[标识列]=CASE T.is_identity  WHEN 1 THEN '●' ELSE '' END,
--[计算列]=CASE T.is_computed WHEN 1 THEN '●' ELSE '' END,
--[字段类型]=(SELECT name FROM sys.types WHERE user_type_id = T.user_type_id),
--[字段长度]= T.PRECISION,
--[小数位] = T.Scale,
--[允许空] = CASE T.is_nullable  WHEN 1 THEN '●' ELSE '' END,
--[默认值]= ISNULL((SELECT definition from sys.default_constraints where object_id = T.default_object_id),''),
--[字段说明]=(SELECT VALUE FROM sys.extended_properties WHERE major_id = T.OBJECT_ID AND minor_id  =T.column_id)
--FROM sys.COLUMNS T
--INNER JOIN sys.objects O ON T.object_id = O.object_id AND O.type = 'U'
--WHERE RIGHT(OBJECT_NAME(T.object_id),3) <> 'Log' AND OBJECT_NAME(T.object_id) <>'AuditDDLEvents' AND OBJECT_NAME(T.object_id) <>'dtproperties'
--ORDER BY OBJECT_NAME(T.object_id),T.column_id



--USE [ZQNB_SM]
--GO

--select * from sysobjects where xtype='u' and id in (
--	select id from syscolumns where id in (
--	select id from sysobjects where xtype='u'
--	)
--	and name like 'DomainGuid%' or name like 'DomainUniqueName%'
--)

--select * from sysobjects where xtype='u' and id in (
--	select id from syscolumns where id in (
--	select id from sysobjects where xtype='u'
--	)
--	and name like '%LoginName%' or name like '%UserGuid%'
--)
