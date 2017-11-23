#知识点梳理
----------


## 第一章 冷静处之的有益实践

### 1.1 实践选择
### 1.2 关注要改善的目标领域
### 1.3 整体改善
团队的整体性改善
#### 1.3.1 均衡
- 需求
- 设计
- 开发
- 质量
- 管理

#### 1.3.2 面貌一新
找到正确的人起带头作用

#### 1.3.3 可持续性
- 保持良性发展的势头，让好的实践帮助团队建立可持续的开发环境
- 持续集成服务器的必要

## 第二章 .NET实践领域

.NET编程规范的两点
- 《.NET设计规范》
- FxCop软件

### 2.1 从内部挖掘

从内部挖掘的好处
- 感兴趣
- 迫切需要
- 量身打造

技术债务


### 2.2 应用程序生命周期管理

### 2.3 设计模式和开发指南

- 界面设计模式
- 对象映射
- 依赖注入
- 


从内部挖掘的好处
- 感兴趣
- 迫切需要
- 量身打造


## 第八章 生成自动化

Task
Target


	MSBuild.exe MyProj.proj /property:Configuration=Debug
	<PropertyGroup>
    	<BuildDir>Build</BuildDir>
		<Configuration  Condition=" '$(Configuration)' == '' ">Debug</Configuration>
	</PropertyGroup>


A task is executed in an MSBuild project file by creating an element that has the name of the task as a child of a Target element. Tasks typically accept parameters, which are passed as attributes of the element. 

	<Target Name="MakeBuildDirectory">
	    <MakeDir  Directories="$(BuildDir)" />
	</Target>

[msbuildscheme](https://www.asp.net/web-forms/overview/deployment/web-deployment-in-the-enterprise/understanding-the-project-file)


Targets group tasks together in a particular order and expose sections of the project file as entry points into the build process. Targets are often grouped into logical sections to increase readability and to allow for expansion. Breaking the build steps into targets lets you call one piece of the build process from other targets without copying that section of code into every target. For example, if several entry points into the build process require references to be built, you can create a target that builds references and then run that target from every entry point where it's required.

Targets are declared in the project file by using the Target element. For example, the following code creates a target named Compile, which then calls the Csc task that has the item list that was declared in the earlier example.

	<Target Name="Compile">
	    <Csc Sources="@(Compile)" />
	</Target>

In more advanced scenarios, targets can be used to describe relationships among one another and perform dependency analysis so that whole sections of the build process can be skipped if that target is up-to-date. For more information about targets, see MSBuild Targets.

For example, in the Publish.proj file in the sample solution, take a look at the BuildProjects target.
	
	<Target Name="BuildProjects" Condition=" '$(BuildingInTeamBuild)'!='true' ">
	   <MSBuild Projects="@(ProjectsToBuild)"           
	            Properties="OutDir=$(OutputRoot);
	                        Configuration=$(Configuration);
	                        DeployOnBuild=true;
	                        DeployTarget=Package"
	            Targets="Build" />
	</Target>


- To use a property value, type $(PropertyName), where PropertyName is the name of the Property element or the name of the parameter.
- To use an item, type @(ItemName), where ItemName is the name of the Item element.

> Note: Remember that if you create multiple items with the same name, you’re building a list. In contrast, if you create multiple properties with the same name, the last property value you provide will overwrite any previous properties with the same name—a property can only contain a single value.



### 2.1 从内部挖掘


##Todo

hehe

	public class MyResourceWrapperDemo : IDisposable
	{
	    private bool _disposed = false;
	    public void Dispose()
	    {
	        //false : 从用户代码调用
	        CleanUp(true);
	        //通知Gc已经处理过了
	        GC.SuppressFinalize(this);
	    }
	    private void CleanUp(bool disposing)
	    {
	        // 确保没有重复处理！
	        if (!_disposed)
	        {
	            // 从用户代码调用，处理托管资源
	            if (disposing)
	            {
	                //处理托管资源的代码
	                //todo...
	            }
	            //处理“非”托管资源的代码
	            //todo...
	        }
	        _disposed = true;
	    }
	    ~MyResourceWrapperDemo()
	    {
	        //false : 从Gc调用
	        CleanUp(false);
	    }
	}