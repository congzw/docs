-- ���Ұ���<����>�����б�.  
select object_name(id) as TableName, name as ColumnName from syscolumns
	where 
[name]= 'SiteId' 
and  OBJECTPROPERTY(id,'IsUserTable')=1
--and  object_name(id)='App_KTPJ_CourseInfo'

-- ���Ұ���<����>�����б�.  ƴ�Ӳ�ѯ��������ݵ����
SELECT
'SELECT '+ name + ' FROM ' +  object_name(id)
 from syscolumns
	where 
[name]= 'SiteId' 
and  OBJECTPROPERTY(id,'IsUserTable')=1


-- ���Ұ���<����>�����б�.  ƴ�Ӳ�ѯ��������ݵ����
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



----��ѯ���е����б���
--select * from sysobjects where xtype='u'
--��ѯָ�������������
select * from syscolumns where id in (
select id from sysobjects where xtype='u'
)
and name like 'DomainGuid%'

select * from syscolumns where id= '1205579333' or id ='213575799'
select * from sysobjects where xtype='u' and (id= '1205579333' or id ='213575799')

-- �����Ϊ<����>,Ҫ��ӵ��ֶ���<����>.  
select *  from syscolumns where 
[name]= '<����>' 
and OBJECTPROPERTY(id,'IsUserTable')=1
and object_name(id)='<����>'



-- �鿴���Ƿ����ĳ���У������Ϊ<����>,Ҫ��ӵ��ֶ���<����>. ��
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
--	--�޸����ݿ��Ľű�
--	ALTER TABLE [dbo].[App_KTPJ_CourseInfo]
--	ADD [Title] nvarchar(255) null
--	UPDATE [dbo].[App_KTPJ_CourseInfo]
--	   SET [Title] = '�γ̱���'
--	WHERE [Title] is null
--end
--


--sqlserver�и���ϵͳ�������
--sysaltfiles �����ݿ� �������ݿ���ļ�
--syscharsets �����ݿ� �ַ���������˳��
--sysconfigures �����ݿ� ����ѡ��
--syscurconfigs �����ݿ� ��ǰ����ѡ��
--sysdatabases �����ݿ� �������е����ݿ�
--syslanguages �����ݿ� ����
--syslogins �����ݿ� ��½�ʺ���Ϣ
--sysoledbusers �����ݿ� ���ӷ�������½��Ϣ
--sysprocesses �����ݿ� ����
--sysremotelogins�����ݿ� Զ�̵�¼�ʺ�

--syscolumns ÿ�����ݿ� ��
--sysconstrains ÿ�����ݿ� ����
--sysfilegroups ÿ�����ݿ� �ļ���
--sysfiles ÿ�����ݿ� �ļ�
--sysforeignkeys ÿ�����ݿ� �ⲿ�ؼ���
--sysindexs ÿ�����ݿ� ����
--sysmenbers ÿ�����ݿ� ��ɫ��Ա
--sysobjects ÿ�����ݿ� �������ݿ����
--syspermissions ÿ�����ݿ� Ȩ��
--systypes ÿ�����ݿ� �û�������������
--sysusers ÿ�����ݿ� �û�


----��ѯ���е����а�����OrgXXX�ı�
--select * from sysobjects where xtype='u' and id in (
--	select id from syscolumns where id in (
--	select id from sysobjects where xtype='u'
--)
--and name like 'Org%'
--)



----���б�������е���Ϣ
--SELECT
--[����]=CASE WHEN T.column_id = 1 THEN OBJECT_NAME(T.object_id) ELSE '' END ,
--[�ֶα��]=T.column_id,
--[�ֶ���]=T.name,
--[����]=case when exists(SELECT 1 FROM sys.key_constraints  where type='PK' and object_id=T.OBJECT_ID) THEN '��' ELSE '' END,
--[��ʶ��]=CASE T.is_identity  WHEN 1 THEN '��' ELSE '' END,
--[������]=CASE T.is_computed WHEN 1 THEN '��' ELSE '' END,
--[�ֶ�����]=(SELECT name FROM sys.types WHERE user_type_id = T.user_type_id),
--[�ֶγ���]= T.PRECISION,
--[С��λ] = T.Scale,
--[�����] = CASE T.is_nullable  WHEN 1 THEN '��' ELSE '' END,
--[Ĭ��ֵ]= ISNULL((SELECT definition from sys.default_constraints where object_id = T.default_object_id),''),
--[�ֶ�˵��]=(SELECT VALUE FROM sys.extended_properties WHERE major_id = T.OBJECT_ID AND minor_id  =T.column_id)
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
