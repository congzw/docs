#基本概念
----------
团队项目集合
团队项目
过程模板
工作项
版本控制

团队

#TFS安装关键步骤

- WindowsSetup，Fx3.5(08Sp2)
- BasicConfig: HostName: [TFS_Server01], Ip
- Update
- SqlServerSetup
- Update
- TFSSetup
- FireWallConfig
- ADSetup(zqnb.com)
- AddGroupsAndUsers(ZQNB_All, ZQNB_Develop, ZQNB_Test, ZQNB_Product, ZQNB_Deploy)

#TFS关键概念
----------
**应用层、数据层和客户端层**
构成 Team Foundation Server 的逻辑层。 这些层可能全部部署在同一台物理计算机上，也可能跨多台计算机安装。 有关详细信息，请参阅[TEAM FOUNDATION SERVER 体系结构](https://msdn.microsoft.com/zh-cn/library/ms252473(v=vs.120).aspx)。

**团队项目集合**
Team Foundation Server 中所有数据的主要组织单位。 集合可以包含一个或多个团队项目。 有关详细信息，请参阅[管理团队项目集合](https://msdn.microsoft.com/zh-cn/library/dd236915(v=vs.120).aspx)。

团队项目
一个中心点，供团队共享开发特定软件技术或产品所需的团队活动。 团队项目在团队项目集合中进行组织。 有关详细信息，请参阅[使用 Visual Studio ALM 和 TFS 跟踪工作](https://msdn.microsoft.com/zh-cn/library/dd286619(v=vs.120).aspx)。

**Team Foundation Server 管理控制台**
TFS 管理员用于配置和管理资源的集中式管理工具。 有关详细信息，请参阅[配置和管理 TFS 资源](https://msdn.microsoft.com/zh-cn/library/dd273719(v=vs.120).aspx)。

**服务帐户**
Team Foundation 中的 Web 服务和应用程序使用的帐户。 Team Foundation Server 需要服务帐户来跨服务器和 Web 服务执行操作。 这些服务帐户具有特定要求。 有关详细信息，请参阅[Team Foundation Server 中的服务帐户和依赖项](https://msdn.microsoft.com/zh-cn/library/ms253149(v=vs.120).aspx)。

**SharePoint 产品**
为团队项目门户和面板提供支持的软件。可以在 Team Foundation Server 部署中包含一个或多个 SharePoint Web 应用程序。 若要包含这些应用程序之一，必须安装和配置用于 SharePoint 产品 的 Team Foundation Server 扩展，并且必须在部署中配置权限。 有关详细信息，请参阅[使用项目门户网站共享信息](https://msdn.microsoft.com/zh-cn/library/ms242883(v=vs.120).aspx)。

**SQL Server 和 SQL Server Reporting Services**
为数据仓库提供数据库平台并且为数据集成、分析和报告解决方案提供商业智能平台的软件。 TFS 将其数据存储在 SQL Server 数据库中。 还可以选择包含运行 SQL Server Reporting Services 并自动生成团队项目的报表的服务器。 有关详细信息，请参阅[管理 TFS 报表、数据仓库和 Analysis Services 多维数据集](https://msdn.microsoft.com/zh-cn/library/ms244706(v=vs.120).aspx)。
