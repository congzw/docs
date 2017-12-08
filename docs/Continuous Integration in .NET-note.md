#Continuous Integration in .NET

目录

- make it happen（基础）
	- 1 了解持续集成
		- CI的基本理论
		- HelloWorld Example
		- CI工具列表
		- Project for CI：Calculator App
	- 2 搭建代码版本管理
		- 选择版本管理系统
		- 使用Subversion
		- 设置TFS
	- 3 自动化流程
		- 选择自动化构建工具
		- 使用MSBuild
		- 扩展MSBuild
	- 4 选择CI服务器
		- CI服务器简介
		- 选择合适的CI服务器
		- 设置CruiseControl.Net, TeamCity, TFS
		- 讨论构建触发器
		- 探索CI服务器的一些扩展功能
	- 5 持续反馈
		- 从CI服务器活的反馈
		- 获取构建状态
		- 使用CCNet, TeamCity, TFS
		- 扩展构建通知
	- 6 对集成代码进行单元测试
		- 在CI环境下进行单元测试
		- 持续检查测试覆盖率
		- 测试桩
- extend it（进阶）
	- 7 集成测试，系统测试和验收测试
		- 集成测试和测试模拟
		- 各种项目类型的自动化UI测试
		- 用FitNmesse进行验收测试
	- 8 代码分析
		- 用FxCop和StyleCop进行静态分析
		- 把FxCop和StyleCop集成进CI流程
		- 用自定义规则扩展CI流程
		- 使用Ndepend
- Smooth and polish it （打磨）
	- 9 创建文档
		- 使用XML注释文档
		- 用Sandcastle创建文档
	- 10 部署和交付
		- 创建setup项目
		- 使用Wix创建安装包和集成CI
		- 使用MSDeploy发布Web
	- 11 持续数据库集成
		- 基本的数据库集成
		- 如何使用VisualStudio维护数据库
		- 数据库的测试
	- 12 持续集成的扩展
		- 处理缓慢的构建
		- 调校CI流程
		- 度量CI流程的成熟度

## 1 了解持续集成

### 什么是持续集成？

[Continuous Integration](https://www.martinfowler.com/articles/continuousIntegration.html)
[翻译](http://www.cnblogs.com/CloudTeng/archive/2012/02/25/2367565.html)

An automated process that builds, tests, analyzes, and deploys an application to help ensure that it functions correctly, follows best practices, and is deployable. This process runs with each source-code change and provides immediate feedback to the development team. 

持续集成是一系列让团队持续交付可靠产品的最佳实践，它包括代码提交后的若干自动化的流程：构建、测试、分析、部署、反馈等。

### 常见的CI组成结构

- 版本管理
- 集成服务器
- 反馈机制

### 每次都自动构建吗？

“持续”集成是终极目标，但不太适合作为起点。持续集成并没有强制规定在哪个环节时机触发，应该因地制宜，按需定制。

一些常见的构建类型和内容：

- 持续/增量： 单元测试
- 每日/每晚： 单元测试，附加其他测试
- 每周： 单元测试，附加其他测试
- 发布： 测试所有流程
- QA： 构建、发布到QA团队的测试环境中
- Staging： 构建、发布到Staging环境中

### 如何克服阻力

一些常见的反对观点

- CI意味着增加的维护量（大部分是一次性工作量）
- 工作方法的变化太多、太突然（应该循序渐进）
- CI意味着额外的硬件、软件开销（量力而行，可选空间较大）
- 开发人员就应该做编译和测试工作（尽可能的实现自动化，把精力聚焦到更有价值的事）
- 项目已经进行太久了或没有单元测试，不适合CI（越早越好，但任何阶段都可以实施）

显而易见的好处

- 降低风险（各种自动化测试作保障）
- 可以部署的软件（全程验证）
- 项目状态可见（知道进行到哪些环节，分别发生了什么）
- 快速增量构建（提高了交付效率）

### CI工具

必选工具

- Source Code Countrol
- CI Server
- Feedback mechanisem（a website or...）
- Build Manager(MSBuild or NAnt...)
- Unit Test Framework

可选工具

- Code-analysis(FxCop, StyleCop, NCover)
- Testing Tools(Selenium, FitNesse, ...)
- XmlDoc, Setup...（Sandcastle，ClickOnce，WebDeploy，Wix）

### 本章总结

> 代码分析选择合适的警告级别，越早越好，后期启用代价较大
> 目录命名尽量短，符合项目结构
> 拥抱CI，但工具和实践的引入，应因地制宜，循序渐进。


## 2 搭建代码版本管理

### 选择合适的版本控制系统

The golden rule of CI:

Keep all the files you need to fully integrate your software in the project directory.(code, 3th lib, doc, tools, ...)

>　把集成需要的所有东西，都放在项目的版本库中，这样所有的人、环节都可以获取所需一切，快速开展相关工作。

比较版本控制系统的四个关注点：

- 免费 VS 付费
- 集中式 VS 分布式
- 是否使用文件锁定
- 是否支持事务

> 作者的一些观点：
	
	- 免费不意味着不好，贵的也不一定合适
	- 分布式与否，各有利弊。但从CI的角度，集中式反而更好些（因为单个的代码库容易集中控制，且对开发人员要求相对低一些）。
	- 建议使用支持事务的版本控制系统（不要使用类似SourceSafe的版本控制系统）
	- 建议不要使用文件锁定的工作方式（得不偿失，也没有必要）

> 版本控制系统必不可少。如果已经有一个且大家都满意，坚持用它。

### Subversion

Subversion的一些好处

- 安装简单，免费
- 管理界面简单
- 支持用户组、用户

> 对于入门级小团队，尤其是经费有限的情况下，建议作为起步的首选

### Subversion和代码库

一般来说，提交的越频繁越好；提交前，先获取最新，并确保状态良好。


单个库 VS 多个库

单个库管理容易，权限控制简单。
如果用户权限不同，则使用单个代码库管理所有代码，则不是个好主意。

> 单个库还是多个库的选择很关键，影响范围广、持续时间长，非常有必要结合自身的情况，进行思考和调研
> 代码库的划分粒度，应按需选择，恰到好处

分支，标签，和主线，这些虽然不是必须的，但确实能帮助更好的维护项目

> 一个非常好的隐喻：tree trunk。主干应该是花时间和精力最多的地方，这儿将主导开发，也是CI流程集成的最佳切入点。
> trunk，master，main...

分支的一个划分方法（按时间维度）：

- 长期分支，例如发版稳定分支
- 中期分支，例如功能分支
- 短期分支，例如实验分支

通常，为每个客户版本维护一个分支是个好主意，这有利于快速定位和修复bug。

> 对于我们的现状，应该为每个使用非标准产品的客户，建议并保留一个分支，这样才能应对将来的问题。（这点上，吃过太多次亏）
> 控制分支数量，它通常跟维护代价成正比。比如，作为通用型产品的基础（Shared），应该严格控制它的分支数量。它的分支数量会大大影响产品的复杂性和维护难度。（慎重分析创建此分支的理由，比如客户定制基础库，是否真的有必要，有无其他更优方案？）

不同分支的CI方案？

Some branches can be considered good material for the CI process. For example, release-stabilization branches should be continuously integrated, experimental ones shouldn’t, and feature branches may be. 

一些分支也非常适合进行CI。例如稳定的发版分支，应该被持续集成；实验性的分支一般不应该持续集成，功能分支可以按情况而定。

> 没有银弹，应因地制宜，并不存在对所有分支都合适的集成策略。

标签是比版本号更有意义的一个名字，通常是为了记录特定的时间点或发生的事件，比如发版或者特性的实现。我们认为，标签与CI流程无关。

> 作者认为，标签与CI流程无关，确实是这样。在考虑持续集成的一些问题的解决方案时，应牢记这点。
> 代码库的文件夹结构：很重要，没有标准答案，需要探索出最适合当前的结构。
> 命令行工具，对于自动化非常棒，但并不利于日常工作。可以选择一个图形化工具辅助（例如TortoiseSvn）。

### Referencing

Subversion可以支持外部链接（svn:externals）的方式支持Referencing

> 结合目前我们项目中的问题？关于Shared和Referencing：
> 根据作者的建议，在这些场景下(发版或分支)，不建议采用这种外部链接的方式，而是建议将引用切换为lib目录，这样管理起来要容易很多。
> 如此，把相关性的项目当做多个版本库的管理划分，是不是反而更麻烦呢？类似于Shared和Modules要面临的问题。这个问题需进一步思考。

### TFS

TFS2010以后，还是很值得。定价更亲民灵活，功能更强。

TFS的管理单位是:a team project, 注意区分代码库的project

team projects collections -> team project
a team project is a set of work items, code repositories, build definations, and so on.

> TFS是一个团队协作工具，版本管理只是一部分。team project将涵盖敏捷开发的多个方面，例如工作条目，代码，构建定义，等等。
> TFS对于目前我们团队尤其重要，需要对相关知识，进行进一步学习。 

### Summary

版本管理，是CI的必不可少的基础。单个的代码库不能满足我们构建软件的所有需要（例如监控改变，何时触发构建等）。
一个良好设计的代码库结构，应该很好的适应项目结构。我们应该根据实际情况，选择单个或多个代码库来承载我们的项目。
如果有条件使用TFS，建议使用TFS内部的版本管理，尽量不要混搭，避免不必要的麻烦。

> 结合这个章节的介绍，我们的关键是：准确定位我们的真实需要，并能结合实际，制定出恰当的项目结构和代码库粒度，以及分支管理方案。

## 3 自动化构建

### 选择一个自动化构建工具

自动化构建工具：让代码转化为可以工作的软件

Visual Studio是非常棒的开发调试环境，但不适合作为自动化工具，我们需要是一个不需要监控的自动化工具。

自动化构建：

- 编译
- 准备数据库
- 执行测试
- 分析
- 安装部署
- 创建文档

> .NET平台，建议使用基于XML的NAnt和MSBuild，尤其是MSBuild（自包含，方便）

### 使用MSBuild

rule: the target defination that's closer to your msbuild scripts counts.

### 扩展MSBuild

predefined tasks
MSBuild Community Tasks
Extending custom tasks

### Summary

自动化构建工具，最好是能脚本化，支持条件和参数化，这样就能够根据情况进行构建。
MSBuild是.NET平台的不二之选。

> 重点关注了MSBuild的介绍，因为我认为，它目前更适合作为我们团队的Build Manager。后续工作需额外阅读学习更专业的MSBuild的书和文章。

## 4 选择合适的CI服务器

### CI服务器的基础

建议使用独立的CIServer，让持续过程尽量的少依赖，只装必要的软件，保持尽可能的简单。而硬件，配置越高越好，可以节约等待时间。

### 选择合适的CI服务器

- 预算
- 是否需要写大量的符号（例如xml）
- 是否支持其他需要的工具
- 文档支持如何
- 是否易用达到目标
- 是否满足现在和将来
- 是否炫酷

### 设置设置CruiseControl.Net, TeamCity, TFS

TFS2010后，性价比还是很高的

> 貌似作者对TFS2010后的产品，青睐有加

tfs, build controllers, build agents, 

build controller: manage building tasks
build agent: services that to distribute build tasks

CIServer不应该是Build Server，它应该在代码库或测试失败时，及时提供反馈。

> TFS也是我们的重点候选CI服务器，应重点关注。后续需要选择更专业、详细的书籍和文章进行阅读学习。

## 5 持续反馈

> 没有反馈的持续集成：蒙着眼睛去开车旅行

### 反馈系统的指标

- 代码质量下降的信息
- 响应速度要快
- 提供不同的消息格式
- 指示具体的导致问题的线索
- 对团队随时可访问  

### CI的3个状态

- Working（进行中）
- Yet another successful build（成功）
- Failed（失败）

当我们得到一个构建失败的状态通知，这意味着：

- 不要进行代码更新
- 应该有人立刻修复这个问题
- 所有的提交推迟，直到这个构建失败修复

> 这些都是非常有价值且简单直接的建议，尽量遵从


### tfs的反馈简介

> 2个有趣的扩展tfs通知的例子：LED & SMS

## 6 对集成代码进行单元测试

自动化测试涵盖很广，本章只关注最基本的单元测试。集成测试，系统测试和验收测试，在下一章关注。

单元测试的几个重要原则：

- 单元测试要快，清晰（最好几分钟内）
- 尽量少依赖（不写硬盘，不用网络）
- 让错误驱动单元测试（每次发现一个bug，写单元测试，修正它，运行单元测试，证明bug被修复）

### 在CI环境下进行单元测试

NUnit VS MSTest

### 持续检查测试覆盖率

NCover， PartConver， MSTest自带覆盖率

> 虽然MSTest和其他CI集成也很简单，但仍不如TFS简单易用


## 7 Testing

> 有趣的隐喻：不会游泳能不能浮起来？

单元测试
集成测试
回归测试
压力测试
验收测试（用户验收测试）

一些常见的自动化测试工具

- NUnit 集成测试
- Mocking Framework（模拟非单元测试对象的依赖）
- White（测试WinForm和WPF，Sliverlight）
- Selenium（测试WebApp）
- FitNesse（可为非技术人员提供验收测试）

单元测试 -> 集成测试 -> 系统测试 -> 其他测试（压力，稳定性）

unit test（隔离外部依赖，数据库，网络，IO，配置等）
intergration test（多个单元一起工作的测试，不Mock内部依赖，允许但应尽力避免外部依赖，包含在日构建比较常见）
functional test（有时扩展自集成测试，有时扩展自系统测试。不Mock外部依赖，可以考虑切分小块解决耗时长的问题）
acceptance test（客户或领域专家设计，真实数据，不Mock任何）
system test（在接近于生产环境的系统中进行测试）
load，stability test（系统测试通过后，进行类似的测试）


> Functional testing is a quality assurance (QA) process] and a type of black-box testing that bases its test cases on the specifications of the software component under test. Functions are tested by feeding them input and examining the output, and internal program structure is rarely considered (unlike white-box testing).Functional testing usually describes what the system does.（输入 -> 输出）

功能测试属于黑盒测试，基于规格说明书提取测试用例，它描述了系统干什么（输入和输出），目的是为了发现与程序与规格说明书的不一致。

> Functional testing differs from system testing in that functional testing "verifies a program by checking it against ... design document(s) or specification(s)", while system testing "validate[s] a program by checking it against the published user or system requirements" (Kaner, Falk, Nguyen 1999, p. 52).

系统测试并非是测试整个系统的功能（由功能测试负责），目的是为了说明程序作为一个整体是如何不满足其目标（一组可度量的目标，例如可用性、安全性、兼容性、可靠性...）

验收测试通常是针对最终用户而言，明智的开发者会引导客户在开发过程和发布之前进行这个测试。


>Fail Fast：先执行快的测试（单元测试无疑应最先执行）；测试失败立刻停止构建

[Component Testing Vs Interface Testing Vs Integration Testing](https://www.linkedin.com/pulse/component-testing-vs-interface-integration-vimal-singh)


## 8 Analyzing the code

用FxCop和StyleCop进行静态分析
把FxCop和StyleCop集成进CI流程
用自定义规则扩展CI流程
使用Ndepend

> 当你修改一个bug的时候，时长苦恼和失望，原因往往不是那个bug，而是那些代码本身。

> 最佳的实践是应该在项目之初，就启用这个Code Analysis，并且坚持执行。后期补救的成本太大。

> https://www.codeproject.com/Articles/30762/C-Code-Reviews-using-StyleCop-Detailed-Article

> 再次提醒，不应该试图让CI流程包含所有的事情，应该权衡，例如有些费时的流程可以放在周构建中。

## 9 生成文档
## 10 deployment and delivery
## 11 database
## 12 extending CI

> 最后几章暂时忽略，先不需关注

## Next

当前背景：

- 版本库结构和分支混乱，难于维护
- 没有明确的分支策略和实施指导方案，很多客户的后续支持，处于失控、低效状态
- 对软件周期的几个重要节点（需求、开发、测试、部署等）衔接流程，缺乏共识，相关人员（产品、开发、测试、管理），难以做出判断和决定，相关配合也效率低下
- 自动化测试没有得到普及，软件质量全靠后期的人力保障，问题发现滞后
- 自动构建处于初级状态，虽然有一定的辅助工具，但基本上都是靠人干预，且如何操作，有哪些工具，也不透明
- 缺少有效的反馈机制，人力沟通成本太大

主要问题：




公共库持续集成的第一阶段的目标：

- 重新确定和划分版本库结构和项目结构，为后续的版本管理和分支策略服务。
- 确定分支策略，用于指导发版、定制项目、分支合并等场景，产出文档供相关人参考
- 确定具体的落地方案和实施办法，责任落实到到相关人，产出文档供相关人参考
- 分步骤引入自动化测试（先上单元测试，以后再考虑集成测试，验收测试等，前期对测试覆盖率不做硬性要求，“现有无，后多少”）
- 分步骤实施自动化部署（先考虑周构建和QA构建，以后再考虑Staging构建，触发和安装，考虑先手动后自动的方式进行）
- 分步骤实施反馈、沟通机制（先考虑实现对开发组的编译、测试和构建结果进行反馈，以后在考虑对产品组、测试组进行反馈）

工作计划：

- 11月底前，完成对其他持续集成书中的理论的学习和对比，总结并介绍学习体会。
- 12月开始，对目前团队使用的TFS、MSBuild等做深入学习，采用边学边做的方式，同时搭建接近于实际情况的Pilot项目。
- 12月底前，提出具体可操作的实施方案，供评审和改进。
- 2018年一季度前，先对公共库的部分项目进行改造。发现问题，反馈，改进，完成公初版持续集成方案的落地（半自动->全自动）。

特别的

在持续集成改造未完成前，项目管理和V3.4的发版等事宜，建议先参考之前的《20171023-分支方案》进行实施。

关于日构建和冒烟测试（《代码大全2》）

> 如果没有冒烟测试，日构建就像是浪费时间的演习：确定每天编译是干净的。
> 让日构建和冒烟测试自动化，如果不能自动化，则不切实际。
> 日构建和冒烟测试是否正常，一般需要专人看护。
> 要求开发人员提交到系统前，先进性冒烟测试。惩罚破坏日构建的人。修复日构建的失败，是优先级最高的事情。
> 有压力也要进行日构建和冒烟测试。

背景：

研发的瓶颈和问题，对公司的发展影响越来越大
早期：客户很少，产品结构简单，问题不明显。
当前：客户增多，多条产品线，问题逐渐明显。

表现：

产品质量差
交付速度慢
工作体验差

问题分析：

自动化程度不够，很多问题要等到后期靠人力发现
代码设计耦合，兼容性差的问题，本身是技术问题，但对它的及时发现，需要有保障手段。
产品发布策略不清晰，很多做决定的纠结来自于不知所措
分支过多，维护力不从心（对应现场的分支没有，而同时却存在一些不该有的分支，重复性工作很多，效果也不好）
配置项划分不合理，与当前产品结构和要求不匹配