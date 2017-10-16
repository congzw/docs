#分支模型简介 - TFVC的分支策略

>写在前头：通过近期的概念整理，我有一个体会：**分支策略**无法**独立**解决我们面临的所有维度的问题，分支策略应结合实际的需要综合考虑（可操作性，工具的影响，开发团队的因素，业务实际要求等）。

我们目前有几个方面的问题需要改善：

- 产品线定义和发布计划
- 敏捷实践（单元测试，持续集成等）
- 软件架构（版本管理，版本兼容性，主题定制等）

分支策略不能独立的解决这些问题，应综合考虑和寻求解决方案。我们需要一个清晰的产品定义，要对项目定制有合理把握，重新梳理定义公共基础库和模块，对编码设计也要认真考虑，加强自动化测试等持续集成要素的实践等。

## [分支的作用](https://docs.microsoft.com/zh-cn/vsts/tfvc/branch-folders-files)

利用分支可以：

- 隔离影响（例如，满足多个团队对同一代码库的并行工作）
- 隔离变化（例如，引入发版分支和开发分支）
- 独立演化（例如，提取快照，引入定制项目分支）


但引入分支也会增加复杂性

- 学习、操作成本（例如，选择合适的分支策略，进行拉取，合并，删除等操作）
- 冲突处理（例如，并行开发的冲突，可能需要人为选择和干预）
- 工具的选择与依赖（例如，git和tfvc的不同设计思想，导致了不同的分支实践方案）

"Permalink to Version Control - Branching strategies with TFVC" [阅读原文](https://www.visualstudio.com/en-us/articles/branching-strategies-with-tfvc "Permalink to Version Control - Branching strategies with TFVC")

分支模型可以分为两类：
- repository scoped(git)
- path scoped（tfvc）

git是轻量级分支，跟git鼓励频繁使用分支和合并不同，tfvc的分支是重量级，分支和合并的开销代价较大，所以它建议尽量避免分支，只在必要的时候才考虑使用分支（例如多团队要在同一代码库工作，或隔离开发和发版等情况）。
[git vs tfvc](Choosing the right version control for your project)


如果要使用TFS进行分支管理，以下是一些可以参考的基本策略（目前项目使用Release isolation策略）

- Main Only（单主线）
- Development isolation（开发隔离）
- Feature isolation（功能隔离）
- **Release isolation（发版隔离）**
- Servicing and Release isolation（服务包和发版隔离）
- Servicing, Hotfix, Release isolation（服务包、热修复和发版隔离）

## Main Only

**Main Only**以主文件夹[转换成分支][5]的方式支持功能开发。你提交到主分支，并根据需要用标签（label）来标示发布里程碑（release milestone）。

![Main Only][6]

> 注意：标签对控制易变性和追踪历史不够给力，容易给版本控制增加风险。

建议以MainOnly为起点，按需引入其他策略[branch strategically][7]。

## Development isolation

当需要保证**主**分支的稳定，可以通过拉出一个开发分支，将并行的开发任务隔离。可以按照功能，组织或临时写作的开发分支来隔离工作。

![Developer Isolation][8]

**main**分支的变化，应该在**dev**分支向**main**分支回归(RI)之前 ，由**main**分支向**dev**分支进行正向整合(FI)。为了保证多分支的质量，**dev**分支应该总是执行那些在**main**分支上的测试标准。按需要运用此策略。

> 注意：应用这条策略的团队，可能会永远保持**dev**分支，潜在的问题是产生大量的合并历史。

## Feature isolation

**Feature isolation**是由**Development isolation**派生, 允许同时开发多个**feature**分支从**main**分支，就跟**dev**分支类似。

![Feature Isolation][9]

如果需要对特定的功能进行开发，**feature**分支一般是个好主意.

你应该保持功能开发的**feature**分支生命周期尽量的短。应该经常性的进行(FI)，但仅在**feature**分支功能稳定达成共识的时候进行一次性的(RI)。从**main**分支回滚功能会代价高昂并且需要重新测试。

## Release isolation

**Release integration** 从**main**分支派生一个或多个**release**分支，保证并行多个发版管理，并且保持着准确的代码库快照。
发版分支允许同时维护多个发布的版本，当代码库做好发版和冻结的准备时，创建一个新的发版分支通常是个好主意。

![Release Isolation][10]

永远不要从**main**分支向**release**分支进行(FI)，一旦发版就控制对发版分支的修改权限，防止对发版分支的无故修改。**release**分支上的热修复和补丁可以被(RI)回**main**分支。

> 注意：没有分支是稳定的，这也就是为什么你看到紧急修复在**release**分支上进行。要结合需求，复杂度和代价等情况，对分支策略进行演化。

## Servicing and Release isolation

**Servicing and Release Isolation**策略引入**servicing**分支，来增加并发的服务包管理，并且在服务和发版时保存快照.

![Service Release Isolation][11]

当打算为客户提供升级到下个主版本，并且每个发版都提供服务补丁包时，考虑此策略。

就像release isolation一样，**servicing**隔离和**release**分支是在发版就绪时创建。永远不要从主线向服务分支，或者服务分支向发版分支合并，并且锁定发版分支防止修改。未来的服务变化体现在服务分支上。

如果想做到这个粒度的隔离，就应用此策略。

Create new servicing and release branches for subsequent releases if you require that level of isolation.

## Servicing, Hotfix, Release isolation

尽管不推荐，但你可以继续演化上一策略，引入**hotfix**分支和发版配合。

![Service HotFix Release Isolation][12]

至此，你浏览了一些常见的TFVC分支场景。你可以演化和研究其他的策略例如**feature toggling**等，开关功能来决定一个功能是否可用。

[参考：分支向导](http://vsarbranchingguide.codeplex.com/)

## Q&A

### 为什么分支的生命周期应该尽可能短？

分支越短命，合并冲突就越少。

### 为什么尽量不要分支？

拥抱 [DevOps][14] 你需要依赖自动化编译、测试和部署。变化是持续的，合并操作经常需要人为干预，因此建议采用其他策略避免分支，例如 **feature toggling**策略.

### 为何要删除分支？

你的目标是尽快的回归**main**主线，减轻长期的合并冲突。临时的，无用的废弃的分支会困扰团队。

### 代码库能跨项目分支吗？

是但不推荐，除非团队只能共享代码又不能共享流程。

### 如何看待**code promotion**策略？

**code promotion**策略貌似属于瀑布模型开发时代，不再推荐.参照[branching guidance][4]。

### 当从**dev**向**main**合并，为啥没有变化对照了？

你应该是上次合并忽略了变化，例如使用`keep source`解决冲突方案。参见[merging developement branch to main: there were no changes to merge][15]。


### TFVC and Git是否有相似之处？

TFVC Feature Isolation和Git相似。 [topic branches][16].

[1]: _img/tfvc.png
[2]: https://msdn.microsoft.com/en-us/library/ms181237.aspx
[3]: https://msdn.microsoft.com/en-us/library/ms181423.aspx
[4]: http://vsarbranchingguide.codeplex.com
[5]: https://msdn.microsoft.com/en-us/library/ms181425.aspx
[6]: _img/branching-scenarios-main-only.gif
[7]: https://msdn.microsoft.com/en-us/library/ee782536.aspx
[8]: _img/branching-scenarios-developer-isolation.gif
[9]: _img/branching-scenarios-feature-isolation.gif
[10]: _img/branching-scenarios-release-isolation.gif
[11]: _img/branching-scenarios-service-release-isolation.gif
[12]: _img/branching-scenarios-service-hotfix-release-isolation.gif
[13]: https://msdn.microsoft.com/en-ca/magazine/dn683796.aspx
[14]: http://aka.ms/devops
[15]: http://stackoverflow.com/questions/27590388/merging-developement-branch-to-main-there-were-no-changes-to-merge
[16]: http://www.git-scm.com/book/en/v2/Git-Branching-Branching-Workflows#Topic-Branches
  
## Vocabulary

revision: 修订，版本
revision number: 修订版本号
timestamp: 时间戳
intergration: 集成，整合
Forward Intergration: 正向整合，向前整合 （父 -> 子）
Backward Intergration, Reverse Intergration: 向后整合，反向整合 （子 -> 父）
Tag,Label: 标签，提交的变更标识
Baseline: 基线（通常用来强调指示特定的标签，例如里程碑，分支，发版等事件）
branch: 分支
conflict: 冲突
Trunk,Main,Master,Base 主线

