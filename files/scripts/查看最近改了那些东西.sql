----IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Basic_Menu_SelectAll]') AND type in (N'P', N'PC'))
----BEGIN
----	Select '������'
----END
----ELSE
----begin
----	select '������'
----end
--
----�鿴ĳЩobjects
--SELECT * FROM sys.objects 
--WHERE
--type in (N'P', N'PC')
----object_id = OBJECT_ID(N'[dbo].[Basic_Menu_SelectAll]')
---- AND
--
----AF = �ۺϺ��� (CLR)
----C = CHECK Լ��
----D = DEFAULT��Լ���������
----F = FOREIGN KEY Լ��
----FN = SQL ��������
----FS = ���� (CLR) ��������
----FT = ���� (CLR) ��ֵ����
----IF = SQL ������ֵ����
----IT = �ڲ���
----P = SQL �洢����
----PC = ���� (CLR) �洢����
----PG = �ƻ�ָ��
----PK = PRIMARY KEY Լ��
----R = ���򣨾�ʽ��������
----RF = ����ɸѡ����
----S = ϵͳ����
----SN = ͬ���
----SQ = �������
----TA = ���� (CLR) DML ������
----TF = SQL ��ֵ����
----TR = SQL DML ������
----TT = ������
----U = ���û��������ͣ�
----UQ = UNIQUE Լ��
----V = ��ͼ
----X = ��չ�洢����
--
----�鿴ĳ���洢���̵Ĳ����б�
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



--�鿴���������Щ����
SELECT name AS object_name 
  ,SCHEMA_NAME(schema_id) AS schema_name
  ,type_desc
  ,create_date
  ,modify_date
FROM sys.objects
WHERE modify_date > GETDATE() - 90 --�����ڵ�����
and type_desc = 'USER_TABLE'
ORDER BY modify_date desc, create_date desc;