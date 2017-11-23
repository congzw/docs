# 持续集成

## 前言

> Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. Many teams find that this approach leads to significantly reduced integration problems and allows a team to develop cohesive software more rapidly. This article is a quick overview of Continuous Integration summarizing the technique and its current usage.

持续集成(Continuous Integration, CI)是一种软件开发实践，在实践中项目成员频繁地进行集成，通常每个成员每天都会做集成工作，如此，每天整个项目将会有多次集成。每次集成后都会通过自动化构建（包括测试）来尽快发现其中的错误。许多团队都发现这种方法大大地减少了集成问题并且能够快速地开发出高内聚性的软件。本文简要地总结了持续集成技术及其现状。

> I vividly remember one of my first sightings of a large software project. I was taking a summer internship at a large English electronics company. My manager, part of the QA group, gave me a tour of a site and we entered a huge depressing warehouse stacked full with cubes. I was told that this project had been in development for a couple of years and was currently integrating, and had been integrating for several months. My guide told me that nobody really knew how long it would take to finish integrating. From this I learned a common story of software projects: integration is a long and unpredictable process.

我还清楚地记得我刚加入一个大型软件项目时的情形，那时我正在英国一个电子公司做暑期实习。我的经理（属于QA部门）领我参观了一个巨大并很压抑的房间，里面全是格子间。经理告诉我这个项目已经开发了有些年头，现在正在做集成，并且已经集成了好几个月了。经理还告诉我说，没有人真正知道完成集成工作需要多少时间。由此我学到了软件项目的一个通病：软件集成是一个漫长并且无法预测的过程。

> But this needn't be the way. Most projects done by my colleagues at ThoughtWorks, and by many others around the world, treat integration as a non-event. Any individual developer's work is only a few hours away from a shared project state and can be integrated back into that state in minutes. Any integration errors are found rapidly and can be fixed rapidly.

然而，软件集成不必像这样的。在ThoughtWorks的大多数项目还有世界上许多其它组织的软件项目中，软件集成并不是什么难事。每个开发人员离共享的工程状态只有咫尺之遥，并且可以在几分钟之内将自己的代码集成进去。任何集成错误都能被快速地发现并得到快速的修正。

> This contrast isn't the result of an expensive and complex tool. The essence of it lies in the simple practice of everyone on the team integrating frequently, usually daily, against a controlled source code repository.

这种鲜明的对比并不是源自于后者有多么昂贵或复杂的工具，而关键在于每人都频繁集成这种简单实践，通常是每天向一个被管控的代码库集成。

> When I've described this practice to people, I commonly find two reactions: "it can't work (here)" and "doing it won't make much difference". What people find out as they try it is that it's much easier than it sounds, and that it makes a huge difference to development. Thus the third common reaction is "yes we do that - how could you live without it?"

当我向人们阐述这种实践时，通常得到两种反应：“（在我们这里）行不通”和“无关紧要”。当人们尝试了这种实践之后，他们发现其实做起来比说起来简单，而且这样的实践对于开发“至关重要”。因此有了第三种反应：“是的，我们就是这么做的，不然该怎么活啊？”

> The term 'Continuous Integration' originated with the Extreme Programming development process, as one of its original twelve practices. When I started at ThoughtWorks, as a consultant, I encouraged the project I was working with to use the technique. Matthew Foemmel turned my vague exhortations into solid action and we saw the project go from rare and complex integrations to the non-event I described. Matthew and I wrote up our experience in the original version of this paper, which has been one of the most popular papers on my site.

“持续集成”源自于极限编程（XP），并且是XP最初的12种实践之一。当我以咨询师的角色加入ThoughtWorks时，我鼓励我的团队使用这种技术。Matthew Foemmel将我的建议变成了实实在在的行动，由此软件集成从少有发生并且复杂的状态变成了小事一桩。Matthew和我将我们的经验写在了本文的第一版中，而本文也是我的个人网站上最受欢迎的文章之一。

> Although Continuous Integration is a practice that requires no particular tooling to deploy, we've found that it is useful to use a Continuous Integration server. The best known such server is CruiseControl, an open source tool originally built by several people at ThoughtWorks and now maintained by a wide community. Since then several other CI servers have appeared, both open source and commercial - including Cruise from ThoughtWorks Studios.

虽然持续集成并不需要使用特别的工具来部署，但是我们发现拥有一台持续集成服务器将大有益处，其中最著名的有开源的CruiseControl，该软件最初由ThoughtWorks的几个员工开发，现在由一个很大的社区维护着。后来几款其它的持续集成服务器也相继出现了，有开源的，也有商业化的，包括ThoughtWorks Studios的Cruise。

## Building a Feature with Continuous Integration
在开发中使用持续集成

> The easiest way for me to explain what CI is and how it works is to show a quick example of how it works with the development of a small feature. Let's assume I have to do something to a piece of software, it doesn't really matter what the task is, for the moment I'll assume it's small and can be done in a few hours. (We'll explore longer tasks, and other issues later on.)

对于我来说，解释持续集成及其工作原理最简单的方法便是以一个小的软件功能的开发为例来进行演示。假设我们需要向软件添加一点功能，至于是什么样的功能并不重要，我们假定它很小并且可以在几个小时内完成。

> I begin by taking a copy of the current integrated source onto my local development machine. I do this by using a source code management system by checking out a working copy from the mainline.

首先我们需要在本地机器上保留一份当前已经处于集成状态的代码的拷贝。我通过代码管理系统在代码库的主线（mainline）上迁出（check out）一份工作代码拷贝。

> The above paragraph will make sense to people who use source code control systems, but be gibberish to those who don't. So let me quickly explain that for the latter. A source code control system keeps all of a project's source code in a repository. The current state of the system is usually referred to as the 'mainline'. At any time a developer can make a controlled copy of the mainline onto their own machine, this is called 'checking out'. The copy on the developer's machine is called a 'working copy'. (Most of the time you actually update your working copy to the mainline - in practice it's the same thing.)

上一段文字主要针对使用代码控制系统的人，对于不使用代码控制系统的人来说便是胡言乱语了。因此，我将向后者解释一下。代码控制系统用于将项目所有的代码保存在一个代码库（repository）中，项目当前的状态通常被称为主线。任何时候开发人员都可以从主线上获得一份拷贝到本地机器，这被称为“checking out”。本地机器上的代码拷贝称为“working copy”。（多数时候，实际上你是在更新（update）本地代码到主线状态，实践中它们是一样的效果。）

> Now I take my working copy and do whatever I need to do to complete my task. This will consist of both altering the production code, and also adding or changing automated tests. Continuous Integration assumes a high degree of tests which are automated into the software: a facility I call self-testing code. Often these use a version of the popular XUnit testing frameworks.

现在，为了完成软件的功能添加，我对本地代码进行修改，其中既包括修改产品代码，也包括添加自动化测试。持续集成非常看重测试，并且在软件代码本身中达到了测试自动化——我将其称为自测试代码，通常使用流行的XUnit测试框架的一个版本。

> Once I'm done (and usually at various points when I'm working) I carry out an automated build on my development machine. This takes the source code in my working copy, compiles and links it into an executable, and runs the automated tests. Only if it all builds and tests without errors is the overall build considered to be good.

当我完成了功能开发（或者在我开发过程的不同阶段），我将在本地开发机上完成自动化构建。构建过程将编译并链接本地代码，然后跑自动化测试。只有当构建和测试都没有错误时，该次构建才能算是好的构建。

> With a good build, I can then think about committing my changes into the repository. The twist, of course, is that other people may, and usually have, made changes to the mainline before I get chance to commit. So first I update my working copy with their changes and rebuild. If their changes clash with my changes, it will manifest as a failure either in the compilation or in the tests. In this case it's my responsibility to fix this and repeat until I can build a working copy that is properly synchronized with the mainline.

有了本地的成功构建，我便可以考虑将我修改的代码提交到代码库了。但是，在我提交之前，其他开发人员可能已经向主线提交了他们的修改，所以首先我需要将他们的修改更新到我本地并且重新构建。如果他人的修改与我的修改有冲突，那么在本地编译或者测试阶段将会发生错误，这种情况下，我需要负责修改本地代码直到与主线代码保持适当同步为止。

> Once I have made my own build of a properly synchronized working copy I can then finally commit my changes into the mainline, which then updates the repository.

当本地代码与主线代码同步之后，我便可以向主线提交自己的修改了，代码库也得以更新。

> However my commit doesn't finish my work. At this point we build again, but this time on an integration machine based on the mainline code. Only when this build succeeds can we say that my changes are done. There is always a chance that I missed something on my machine and the repository wasn't properly updated. Only when my committed changes build successfully on the integration is my job done. This integration build can be executed manually by me, or done automatically by Cruise.

然而，单是提交了修改并不表示我的工作就完成了。我需要再次构建，但这次是在一台拥有主线代码的集成机器上进行。只有这次构建成功了才表示我的任务完成。通常会出现这样的情况：我忘了提交本地机器上的一些东西，因此代码库并没有得到适当的更新。只有我提交的修改在集成机器上成功构建之后，我的工作才算完成。这样的集成构建可以由我手动完成，也可以由Cruise自动完成。

> If a clash occurs between two developers, it is usually caught when the second developer to commit builds their updated working copy. If not the integration build should fail. Either way the error is detected rapidly. At this point the most important task is to fix it, and get the build working properly again. In a Continuous Integration environment you should never have a failed integration build stay failed for long. A good team should have many correct builds a day. Bad builds do occur from time to time, but should be quickly fixed.

当两个开发者的代码有冲突时，通常会在第二个开发者更新本地代码时捕获到，否则，集成构建应该会失败。在这两种途径中，错误都可以被快速地发现。在持续集成环境中，你决不应该使失败的集成构建保留太长时间。一个好的团队每天都应该有许多成功的构建。当然，失败的构建也会时常发生，但需要尽快的修复。

> The result of doing this is that there is a stable piece of software that works properly and contains few bugs. Everybody develops off that shared stable base and never gets so far away from that base that it takes very long to integrate back with it. Less time is spent trying to find bugs because they show up quickly.

这样做的结果是，我们总会得到一个稳定并且工作正常的软件。每个人都围绕着一个共享并稳定的基础代码库工作，绝不离基础代码库太远以至于需要很长的时间将自己的修改集成到基础代码库中。如此这般，我们花在找bug上的时间减少了，因为bug在频繁的集成中经常出现。

## Practices of Continuous Integration
持续集成实践

> The story above is the overview of CI and how it works in daily life. Getting all this to work smoothly is obviously rather more than that. I'll focus now on the key practices that make up effective CI.

上文只是关于持续集成的一个概要和它在日常开发中的工作原理。让所有这些都能很好的运作显然不止于此。现在，就让我们来看看有效持续集成所需的关键实践。　

### Maintain a Single Source Repository.
维护一个单一的代码库

> Software projects involve lots of files that need to be orchestrated together to build a product. Keeping track of all of these is a major effort, particularly when there's multiple people involved. So it's not surprising that over the years software development teams have built tools to manage all this. These tools - called Source Code Management tools, configuration management, version control systems, repositories, or various other names - are an integral part of most development projects. The sad and surprising thing is that they aren't part of all projects. It is rare, but I do run into projects that don't use such a system and use some messy combination of local and shared drives.

软件项目需要大量的文件协同工作来构建出最终的产品。跟踪所有的文件需要大量的工作，尤其是在多个开发者参与的项目中。因此，我们可以并不惊奇的看到，不同的软件开发团队都在开发用于管理这些文件的工具——源代码管理工具，也叫配置管理，版本控制系统，代码库等。这些工具是多数软件项目不可分的组成部分。然而，令人伤心并吃惊的是，并不是所有的项目都使用了这样的工具。我的确见到（虽然很少）不使用这些工具的项目，它们使用本地和共享磁盘这种混乱的结合来共同工作。

> So as a simple basis make sure you get a decent source code management system. Cost isn't an issue as good quality open-source tools are available. The current open source repository of choice is Subversion. (The older open-source tool CVS is still widely used, and is much better than nothing, but Subversion is the modern choice.) Interestingly as I talk to developers I know most commercial source code management tools are liked less than Subversion. The only tool I've consistently heard people say is worth paying for is Perforce.

因此，做为最基本的持续集成实践，请保证你使用一款体面的代码管理系统。成本不是问题，有许多高质量的开源代码管理工具存在。当前的选择为Subversion（译者注：现在有了更新的hg和git）。（更老的开源工具CVS如今仍然被大量使用，虽然比没有强，但是Subversion是更现代的选择。）有趣的是，当我和一些开发者聊天时，我发现相比起多数商业化的代码管理系统，他们更喜欢Subversion。据我所知，唯一值得花钱买的只有Perforce。

> Once you get a source code management system, make sure it is the well known place for everyone to go get source code. Nobody should ever ask "where is the foo-whiffle file?" Everything should be in the repository.

当你有了代码管理系统之后，确保每个开发者都能方便的获得到源代码。不应该有人还在问：“foo-whiffle 文件在哪儿？”所有东西都必须在代码库里。

> Although many teams use repositories a common mistake I see is that they don't put everything in the repository. If people use one they'll put code in there, but everything you need to do a build should be in there including: test scripts, properties files, database schema, install scripts, and third party libraries. I've known projects that check their compilers into the repository (important in the early days of flaky C++ compilers). The basic rule of thumb is that you should be able to walk up to the project with a virgin machine, do a checkout, and be able to fully build the system. Only a minimal amount of things should be on the virgin machine - usually things that are large, complicated to install, and stable. An operating system, Java development environment, or base database system are typical examples.

虽然许多团队都在使用代码库，但是我经常发现，他们并不把所有东西都放在里面。如果大家需要使用一个文件，他们知道该文件放到代码库中，但是，构建所需的所有都应该包含在代码库里，包括测试脚本，属性文件，数据库模式文件，安装脚本和第三方库等。我所知道的有项目将编译器加到代码库中的（对于早期脆弱的C++编译器来说非常重要）。基本原则是：在一台新机器上check out代码后构建也能构建成功。新机器上的东西应该尽量的少，通常包括很大的，难于安装的，并且稳定的软件，比如操作系统，Java开发环境或者数据库管理系统等。

> You must put everything required for a build in the source control system, however you may also put other stuff that people generally work with in there too. IDE configurations are good to put in there because that way it's easy for people to share the same IDE setups.

你需要将构建所需的所有东西都加到代码管理系统中，同时也需要将大家经常操作的东西方进去，IDE配置便是一个很好的例子，这样便于大家共享IDE配置。

> One of the features of version control systems is that they allow you to create multiple branches, to handle different streams of development. This is a useful, nay essential, feature - but it's frequently overused and gets people into trouble. Keep your use of branches to a minimum. In particular have a mainline: a single branch of the project currently under development. Pretty much everyone should work off this mainline most of the time. (Reasonable branches are bug fixes of prior production releases and temporary experiments.)

版本控制系统的一大功能是它允许你创建多个分支，以此来处理不同的“开发流”。这种功能很有用，但却经常被过度使用以至给开发者带来了不少麻烦。所以，你需要将分支的使用最小化，特别建议使用主线，即项目中只有单一的开发分支，并且每人在多数时间里都在“离线”工作。

> In general you should store in source control everything you need to build anything, but nothing that you actually build. Some people do keep the build products in source control, but I consider that to be a smell - an indication of a deeper problem, usually an inability to reliably recreate builds.

总之，你应该将构建所需的所有东西都放在代码管理系统中，而不应该将构建的输出放进去。有些朋友确实将构建输出放在代码管理系统中，但我认为这是一个坏味道，可能导致更深的问题——通常是你无法完成重新构建。

### Automate the Build
使构建自动化

> Getting the sources turned into a running system can often be a complicated process involving compilation, moving files around, loading schemas into the databases, and so on. However like most tasks in this part of software development it can be automated - and as a result should be automated. Asking people to type in strange commands or clicking through dialog boxes is a waste of time and a breeding ground for mistakes.

将源代码变成一个能运行的软件系统通常是一个复杂的过程，包括编译，文件搬移，加载数据库模式等等。但其中大多数任务都是可以自动化的，并且也应该被自动化。让人去输入奇怪的命令或点击对话框是非常耗时的，而且从根本上来说也是个错误的做法。

> Automated environments for builds are a common feature of systems. The Unix world has had make for decades, the Java community developed Ant, the .NET community has had Nant and now has MSBuild. Make sure you can build and launch your system using these scripts using a single command.

构建所需的自动化环境对于软件系统来说是一个通用功能。Unix的Make已经诞生好多年了，Java社区有Ant， .NET社区有Nant，现在又有了MSBuild。当你用这些工具构建和启动系统时，请确保只使用一个命令完成任务。

> A common mistake is not to include everything in the automated build. The build should include getting the database schema out of the repository and firing it up in the execution environment. I'll elaborate my earlier rule of thumb: anyone should be able to bring in a virgin machine, check the sources out of the repository, issue a single command, and have a running system on their machine.

一个常见的错误是在自动化构建里并没有完全包括构建所需的东西。构建过程中应该从代码库里取得数据库模式文件并自动执行之。结合我上文所讲的原则来看，任何人都应该能够在一台新机器上拉下代码库中的代码，并只用一个命令将系统运行起来。

> Build scripts come in various flavors and are often particular to a platform or community, but they don't have to be. Although most of our Java projects use Ant, some have used Ruby (the Ruby Rake system is a very nice build script tool). We got a lot of value from automating an early Microsoft COM project with Ant.

构建脚本是多种多样的，通常特定于某个平台或社区，但情况并不必须如此。我们的多数Java项目都使用Ant，而另外有些用Ruby（Ruby世界的Rake是一个非常不错的构建工具）。我们用Ant完成了早期的一个微软COM工程的构建自动化，并从中大获裨益。

> A big build often takes time, you don't want to do all of these steps if you've only made a small change. So a good build tool analyzes what needs to be changed as part of the process. The common way to do this is to check the dates of the source and object files and only compile if the source date is later. Dependencies then get tricky: if one object file changes those that depend on it may also need to be rebuilt. Compilers may handle this kind of thing, or they may not.

大型的构建通常需要很长的时间，而在你只做了很小的修改的情况下，你是不想运行所有的构建步骤的。因此，优秀的构建工具能够分析出哪些地方需要做相应的修改，并将这个分析过程本身做为整个构建过程的一部分。通常的做法是检查源代码和目标文件的修改日期，只有当源代码的修改日期晚于其对应的目标文件时才执行编译。依赖关系因此变得微妙起来了：如果一个目标文件发生了修改，那些依赖于它的文件也需要重新构建。有些编译器能够处理这种依赖关系，而有些就不见得。

> Depending on what you need, you may need different kinds of things to be built. You can build a system with or without test code, or with different sets of tests. Some components can be built stand-alone. A build script should allow you to build alternative targets for different cases.

根据自己的需要，你可以选择不同的东西进行构建。构建中既可以包括测试，也可以不包括，甚至可以包括不同的测试板块。有些组件可以进行单独构建。构建脚本应该能够允许你针对不同的情形进行不同的构建目标。

> Many of us use IDEs, and most IDEs have some kind of build management process within them. However these files are always proprietary to the IDE and often fragile. Furthermore they need the IDE to work. It's okay for IDE users set up their own project files and use them for individual development. However it's essential to have a master build that is usable on a server and runnable from other scripts.	So on a Java project we're okay with having developers build in their IDE, but the master build uses Ant to ensure it can be run on the development server.

我们大多数都使用IDE，而多数IDE都或多或少地集成了构建管理功能。但是这样构建文件通常是特定于IDE的，而且非常脆弱。此外，它们需要依赖于IDE才能工作。虽然对于开发者个人来说，在IDE中做这样的构建配置并无不妥，但对于持续集成服务器来说，一份能够被其它脚本调用的主构建脚本却是至关重要的。比如一个Java项目，各个开发者可以在自己的IDE中进行构建，但应该还有一个Ant主构建脚本来保证构建能在集成服务器上顺利完成。

### Make Your Build Self-Testing
使构建自测试

> Traditionally a build means compiling, linking, and all the additional stuff required to get a program to execute. A program may run, but that doesn't mean it does the right thing. Modern statically typed languages can catch many bugs, but far more slip through that net.

传统意义上的构建包括只编译，链接等过程。此时程序也许能运行起来，但这并不意味着系统就能正确地运行。虽然现在的静态语言已经能够捕捉到许多bug，但是漏网之鱼却更多。

> A good way to catch bugs more quickly and efficiently is to include automated tests in the build process. Testing isn't perfect, of course, but it can catch a lot of bugs - enough to be useful. In particular the rise of Extreme Programming (XP) and Test Driven Development (TDD) have done a great deal to popularize self-testing code and as a result many people have seen the value of the technique.

一种快速并高效发现bug的方法是将自动化测试包含到构建过程中。当然，测试也不见得完美，但的确能发现很多bug——足够多了。特别是随着极限编程（XP）的升温，测试驱动开发（TDD）也使自测试代码流行起来，越来越多的人开始注意到这种技术的价值所在。

> Regular readers of my work will know that I'm a big fan of both TDD and XP, however I want to stress that neither of these approaches are necessary to gain the benefits of self-testing code. Both of these approaches make a point of writing tests before you write the code that makes them pass - in this mode the tests are as much about exploring the design of the system as they are about bug catching. This is a Good Thing, but it's not necessary for the purposes of Continuous Integration, where we have the weaker requirement of self-testing code. (Although TDD is my preferred way of producing self-testing code.)

经常读我著作的读者可能知道我是一个TDD和XP的大粉丝，然而我想强调的是这两种方法和自测试并没有必然联系。TDD和XP都要求先写测试代码，再写功能代码使测试通过。在这种模式下，测试既用于发现bug，又用于完成系统设计。这是非常好的，但对于持续集成来说不必如此，因为此时我们自测试代码的要求并不那么高。（然而TDD是我写自测试代码的首选。）

> For self-testing code you need a suite of automated tests that can check a large part of the code base for bugs. The tests need to be able to be kicked off from a simple command and to be self-checking. The result of running the test suite should indicate if any tests failed. For a build to be self-testing the failure of a test should cause the build to fail.

对于自测试代码而言，你需要一组自动化测试来检测一大部分代码库中的bug。测试能通过一个简单得命令来运行并且具备自检功能。测试的结果应该能指出哪些测试是失败的。对于自测试的构建来说，测试失败应导致构建失败。

> Over the last few years the rise of TDD has popularized the XUnit family of open-source tools which are ideal for this kind of testing. XUnit tools have proved very valuable to us at ThoughtWorks and I always suggest to people that they use them. These tools, pioneered by Kent Beck, make it very easy for you to set up a fully self-testing environment.

过去这些年里，TDD使开源的XUnit家族流行起来，成为了理想的测试工具。在ThoughtWorks，XUnit已经是非常有用的测试工具，我也经常建议人们使用。这组工具起初由Kent Beck开发，它们使自测试环境的搭建变得非常简单。

> XUnit tools are certainly the starting point for making your code self-testing. You should also look out for other tools that focus on more end-to-end testing, there's quite a range of these out there at the moment including FIT, Selenium, Sahi, Watir, FITnesse, and plenty of others that I'm not trying to comprehensively list here.

XUnit当之无愧地是你进行代码自测试的起点。当然，你也应当多看看那些更侧向于端到端测试的工具，包括FIT，Selenium，Sahi，Watir，FITnesse等等，我就不逐一列举了。

> Of course you can't count on tests to find everything. As it's often been said: tests don't prove the absence of bugs. However perfection isn't the only point at which you get payback for a self-testing build. Imperfect tests, run frequently, are much better than perfect tests that are never written at all.

当然，别指望测试就是万能的。常言道，测试并不能证明没bug。然而，完美并不是你从自测试构建中得到的唯一好处。经常运行的不完美测试，总比从来不写的完美测试要强。

### Everyone Commits To the Mainline Every Day
每人每天都向主线提交代码

> Integration is primarily about communication. Integration allows developers to tell other developers about the changes they have made. Frequent communication allows people to know quickly as changes develop.

集成首先在于交流，它使其他成员能够看到你所做的修改。在这种频繁的交流下，大家都能很快地知道开发过程中所做的修改。

> The one prerequisite for a developer committing to the mainline is that they can correctly build their code. This, of course, includes passing the build tests. As with any commit cycle the developer first updates their working copy to match the mainline, resolves any conflicts with the mainline, then builds on their local machine. If the build passes, then they are free to commit to the mainline.

在向主线提交代码之前，开发人员必须保证本地构建成功。这当然也包括使测试全部通过。另外，在提交之前需要更新本地代码以匹配主线代码，然后在本地解决主线代码与本地代码之间的冲突，再在本地进行构建。如果构建成功，便可以向主线提交代码了。

> By doing this frequently, developers quickly find out if there's a conflict between two developers. The key to fixing problems quickly is finding them quickly. With developers committing every few hours a conflict can be detected within a few hours of it occurring, at that point not much has happened and it's easy to resolve. Conflicts that stay undetected for weeks can be very hard to resolve.

在这种频繁提交下，开发者可以快速地发现自己代码与他人代码之间的冲突。快速解决问题的关键在于快速地发现问题。几个小时的提交间隔使得代码冲突也可以在几个小时内发现，此时大家的修改都不多，冲突也不大，因此解决冲突也很简单。对于好几周都发现不了的冲突，通常是很难解决的。

> The fact that you build when you update your working copy means that you detect compilation conflicts as well as textual conflicts. Since the build is self-testing, you also detect conflicts in the running of the code. The latter conflicts are particularly awkward bugs to find if they sit for a long time undetected in the code. Since there's only a few hours of changes between commits, there's only so many places where the problem could be hiding. Furthermore since not much has changed you can use diff-debugging to help you find the bug.

在更新本地代码库时就进行构建，这意味着我们既可以发现文本上的冲突，又可以发现编译冲突。既然构建是自测试的，那么运行时的冲突也可以被检测出来，而这样的冲突往往是一些特别烦人的bug。由于提交间隔只有短短的几个小时，bug便没多少藏身之处了。再者，因为每次提交的修改都不多，你可以使用diff-debugging来帮你找出这些bug。

> My general rule of thumb is that every developer should commit to the repository every day. In practice it's often useful if developers commit more frequently than that. The more frequently you commit, the less places you have to look for conflict errors, and the more rapidly you fix conflicts.

我的基本原则是：每个开发者每天都应当向代码库进行提交。在实践中，越是频繁提交，可能导致冲突的地方就越少，因而也越容易发现。

> Frequent commits encourage developers to break down their work into small chunks of a few hours each. This helps track progress and provides a sense of progress. Often people initially feel they can't do something meaningful in just a few hours, but we've found that mentoring and practice helps them learn.

频繁提交鼓励开发人员以几个小时为单位来分割他们的代码，这样便于跟踪进度。通常，人们一开始认为在短短的几个小时内做不了什么事情，但我们发现找个导师和多实践可以帮助他们学习。
 
### Every Commit Should Build the Mainline on an Integration Machine
每次提交都应在集成机上进行构建

> Using daily commits, a team gets frequent tested builds. This ought to mean that the mainline stays in a healthy state. In practice, however, things still do go wrong. One reason is discipline, people not doing an update and build before they commit. Another is environmental differences between developers' machines.

有了每日提交，也就又了每日测试，这应该表明主线处于健康状态。但是在实践中，的确有出错的时候，原因之一在于纪律——有人并没有在提交之前进行本地更新和构建。另外，不同开发机之间的环境不同也是一个原因。

> As a result you should ensure that regular builds happen on an integration machine and only if this integration build succeeds should the commit be considered to be done. Since the developer who commits is responsible for this, that developer needs to monitor the mainline build so they can fix it if it breaks. A corollary of this is that you shouldn't go home until the mainline build has passed with any commits you've added late in the day.

因此，你应该保证在集成机上进行构建，只有当集成机上构建成功后，才表明你的任务完成了。由于提交者需要对自己的提交负责，他就得盯着主线上的构建，如果失败，马上修改。如果下班之前你提交的修改失败了，那么，对不起，请修改好了才回家。

> There are two main ways I've seen to ensure this: using a manual build or a continuous integration server.

我见到过两种方式来保证主线构建的成功：一是手动构建，二是使用持续集成服务器。

> The manual build approach is the simplest one to describe. Essentially it's a similar thing to the local build that a developer does before the commit into the repository. The developer goes to the integration machine, checks out the head of the mainline (which now houses his last commit) and kicks off the integration build. He keeps an eye on its progress, and if the build succeeds he's done with his commit. (Also see Jim Shore's description.)

手动构建是最简单的，基本上与开发者在本地做的构建差不多——先到集成机上拉下主线的最新代码，然后运行构建命令，在构建过程中你得盯着构建过程，如果构建成功，表明你的任务完成。（另见Jim Shore的描述。）

> A continuous integration server acts as a monitor to the repository. Every time a commit against the repository finishes the server automatically checks out the sources onto the integration machine, initiates a build, and notifies the committer of the result of the build. The committer isn't done until she gets the notification - usually an email.

持续集成服务器则一直监视着代码库，一旦检测到有提交，便自动拉下代码到本机，然后开始构建，并将结构通知提交者。只有当提交者收到通知后——通常是以电子邮件的方式，才表明自己的任务完成。

> At ThoughtWorks, we're big fans of continuous integration servers - indeed we led the original development of CruiseControl and CruiseControl.NET, the widely used open-source CI servers. Since then we've also built the commercial Cruise CI server. We use a CI server on nearly every project we do and have been very happy with the results.

在ThoughtWorks，我们是持续集成服务器的忠实粉丝，我们领导了CruiseControl和CruiseControl.NET的初期开发，此两者均是广为使用的CI服务器。从那时起，我们也开发了商业化的Cruise。在几乎每个项目中，我们都使用了CI服务器，并且结果是令人愉悦的。

> Not everyone prefers to use a CI server. Jim Shore gave a well argued description of why he prefers the manual approach. I agree with him that CI is much more than just installing some software. All the practices here need to be in play to do Continuous Integration effectively. But equally many teams who do CI well find a CI server to be a helpful tool.

不是所有人都倾向于使用CI服务器的，Jim Shore便给出了一个很好的论述，在此论述中，他解释了为什么他更倾向于手动构建。我同意他的看法——CI不过是安装一些软件而已，所有的实践都应当旨在有效地完成持续集成。但同样，许多使用CI服务器的团队的确发现CI服务器是很好的工具。

> Many organizations do regular builds on a timed schedule, such as every night. This is not the same thing as a continuous build and isn't enough for continuous integration. The whole point of continuous integration is to find problems as soon as you can. Nightly builds mean that bugs lie undetected for a whole day before anyone discovers them. Once they are in the system that long, it takes a long time to find and remove them.

有很多团队定期的进行构建，比如每晚构建。这和持续构建并不是一回事，而且对于持续集成来说，也是不够的。持续集成的关键在于尽快地发现问题。而每晚构建意味着整个白天都发现不了bug，如此，需要很长的时间发现并清除这些bug。

### Fix Broken Builds Immediately
快速修复构建

> A key part of doing a continuous build is that if the mainline build fails, it needs to be fixed right away. The whole point of working with CI is that you're always developing on a known stable base. It's not a bad thing for the mainline build to break, although if it's happening all the time it suggests people aren't being careful enough about updating and building locally before a commit. When the mainline build does break, however, it's important that it gets fixed fast.

持续构建的重点在于，如果主线构建失败，你应该马上进行修改。在持续集成中，你一直是在一个稳定的代码库基础上进行开发。主线构建失败并不是一件坏事，但是，如果这样的情况经常发生，那么就意味着开发人员对于本地更新并没在意或者在提交之前并没在本地构建。主线构建一旦失败，必须马上修正。

> A phrase I remember Kent Beck using was "nobody has a higher priority task than fixing the build". This doesn't mean that everyone on the team has to stop what they are doing in order to fix the build, usually it only needs a couple of people to get things working again. It does mean a conscious prioritization of a build fix as an urgent, high priority task.

我记得Kent Beck说过，“没有比修正构建问题更高优先级的任务”。这并不代表所有人停下来去做这个修正，经常只需要几个人去让构建工作恢复正常。它确实意味着一个构建问题的修复是紧急、最高的任务。

> Often the fastest way to fix the build is to revert the latest commit from the mainline, taking the system back to the last-known good build. Certainly the team should not try to do any debugging on a broken mainline. Unless the cause for the breakage is immediately obvious, just revert the mainline and debug the problem on a development workstation.

通常修复构建的最快方法，是回溯到上一次系统正常构建的那个提交。当然团队不应该尝试去在一个破坏了的主线上进行调试。除非这个破坏的原因很明显，否则直接回溯并且在开发机器上调试这个问题。

> To help avoid breaking the mainline at all you might consider using a pending head.

为了彻底避免主线构建失败，也许你可以试试(pending head)[https://www.martinfowler.com/bliki/PendingHead.html]。

> When teams are introducing CI, often this is one of the hardest things to sort out. Early on a team can struggle to get into the regular habit of working mainline builds, particularly if they are working on an existing code base. Patience and steady application does seem to regularly do the trick, so don't get discouraged.

当团队刚引入CI，这通常是最难解决的事之一。团队早期可能会很难养成保证主线构建的习惯，特别是工作在已有的代码库上的时候。耐心和稳定的应用似乎是主要的手段, 所以不要气馁。

### Keep the Build Fast
保持快速构建

> The whole point of Continuous Integration is to provide rapid feedback. Nothing sucks the blood of a CI activity more than a build that takes a long time. Here I must admit a certain crotchety old guy amusement at what's considered to be a long build. Most of my colleagues consider a build that takes an hour to be totally unreasonable. I remember teams dreaming that they could get it so fast - and occasionally we still run into cases where it's very hard to get builds to that speed.

持续集成的关键在于快速反馈，需要长时间构建的CI是极其糟糕的。我的多数同事都认为一个小时的构建时间对于CI来说决无道理可言。我也记得曾经有团队梦想着他们的构建能有多么多么的快，但有时我们不得不面对很难快速构建的情况。

> For most projects, however, the XP guideline of a ten minute build is perfectly within reason. Most of our modern projects achieve this. It's worth putting in concentrated effort to make it happen, because every minute you reduce off the build time is a minute saved for each developer every time they commit. Since CI demands frequent commits, this adds up to a lot of time.

对于多数项目来说，将构建时间维持在10钟之内是合理的，这也是XP的方针之一，我们多数项目也达到了这个目标。这种做法是值得的，因为这样省下的时间是为开发者节约的。

> If you're staring at a one hour build time, then getting to a faster build may seem like a daunting prospect. It can even be daunting to work on a new project and think about how to keep things fast. For enterprise applications, at least, we've found the usual bottleneck is testing - particularly tests that involve external services such as a database.

如果你的构建长到了一小时，那么想使其加速便不是那么容易了。对于企业级应用来说，我们发现构建时间的瓶颈通常发生在测试上，特别是那些需要于外部交互的测试——比如数据库。

> Probably the most crucial step is to start working on setting up a deployment pipeline. The idea behind a deployment pipeline (also known as build pipeline or staged build) is that there are in fact multiple builds done in sequence. The commit to the mainline triggers the first build - what I call the commit build. The commit build is the build that's needed when someone commits to the mainline. The commit build is the one that has to be done quickly, as a result it will take a number of shortcuts that will reduce the ability to detect bugs. The trick is to balance the needs of bug finding and speed so that a good commit build is stable enough for other people to work on.

可能最好的解决办法是引入阶段性构建（也叫构建管道或者部署管道），因为构建事实上是分阶段性的。代码提交后首先触发的是构建称为提交构建，提交构建应该快速完成，而棘手的是怎么保持速度与查找bug之间的平衡。

> Once the commit build is good then other people can work on the code with confidence. However there are further, slower, tests that you can start to do. Additional machines can run further testing routines on the build that take longer to do.

提交构建成功后，其他人便可自信的工作了。但是，你可能还有其它跑得比较慢的测试需要写，这时可以用额外的机器来专门跑这些耗时的测试。

> A simple example of this is a two stage deployment pipeline. The first stage would do the compilation and run tests that are more localized unit tests with the database completely stubbed out. Such tests can run very fast, keeping within the ten minute guideline. However any bugs that involve larger scale interactions, particularly those involving the real database, won't be found. The second stage build runs a different suite of tests that do hit the real database and involve more end-to-end behavior. This suite might take a couple of hours to run.

一个简单的例子是将构建分为两个阶段，第一个阶段完成编译，并且跑那些不需要外部交互的单元测试，数据库交互也通过stub的方式完全消除掉。这些测试可以很快跑完，原则是将其保持在10分钟之内。但是，对于那些需要大量外部交互——特别是涉及到真实数据库交互时才能发现的bug，这个阶段便无能为力了。第二个阶段跑的测试则需要操作真实的数据库了，同时还应包括端到端测试。这个阶段可能需要几个小时。

> In this scenario people use the first stage as the commit build and use this as their main CI cycle. The second-stage build runs when it can, picking up the executable from the latest good commit build for further testing. If this secondary build fails, then this may not have the same 'stop everything' quality, but the team does aim to fix such bugs as rapidly as possible, while keeping the commit build running. As in this example, later builds are often pure tests since these days it's usually tests that cause the slowness.

在这种情况下，通常将第一阶段视为提交构建，并将此做为主要的CI周期。第二阶段则可在有必要时才进行，如果这个阶段构建失败，它也不需要像第一阶段那样“停下全部手头的工作”，但也应该得到尽快的修改。第二阶段的构建不见得需要保持一直通过，对于已经发现的bug来说，可以在之后几天修改。对于这个案例来说，第二阶段全是测试，因为通常情况下最慢的即是测试。

> If the secondary build detects a bug, that's a sign that the commit build could do with another test. As much as possible you want to ensure that any later-stage failure leads to new tests in the commit build that would have caught the bug, so the bug stays fixed in the commit build. This way the commit tests are strengthened whenever something gets past them. There are cases where there's no way to build a fast-running test that exposes the bug, so you may decide to only test for that condition in the secondary build. Most of time, fortunately, you can add suitable tests to the commit build.

如果第二阶段构建发现了bug，通常意味着应该在第一阶段中引入新的测试来予以保证。

> This example is of a two-stage pipeline, but the basic principle can be extended to any number of later stages. The builds after the commit build can also be done in parallel, so if you have two hours of secondary tests you can improve responsiveness by having two machines that run half the tests each. By using parallel secondary builds like this you can introduce all sorts of further automated testing, including performance testing, into the regular build process.

当然，以上的两阶段构建只是一个例子，你完全可以加入多个构建阶段。提交构建之后的其它构建是可以并行完成的，如果这些阶段的构建需要好几个小时，那么可以用几台机器来并行完成。通过这种并行化，你可以将提交构建之外的所有测试都引入到构建过程中来，比如性能测试。

### Test in a Clone of the Production Environment
在与生产环境的拷贝环境中运行测试

> The point of testing is to flush out, under controlled conditions, any problem that the system will have in production. A significant part of this is the environment within which the production system will run. If you test in a different environment, every difference results in a risk that what happens under test won't happen in production.

测试旨在发现可能在生产环境中出现的问题，因此如果你的测试环境与生产环境不同，那么测试很有可能发现不了生产环境中的bug。

> As a result you want to set up your test environment to be as exact a mimic of your production environment as possible. Use the same database software, with the same versions, use the same version of operating system. Put all the appropriate libraries that are in the production environment into the test environment, even if the system doesn't actually use them. Use the same IP addresses and ports, run it on the same hardware.

因此，你的测试环境应该尽量与生产环境相同。使用相同的数据库，相同的操作系统，并且版本都应该一样。另外，将生产环境中的库文件也放到测试环境中，即使构建时用不到这些库。IP地址和端口号也应当相同，当然还包括硬件。

> Well, in reality there are limits. If you're writing desktop software it's not practicable to test in a clone of every possible desktop with all the third party software that different people are running. Similarly some production environments may be prohibitively expensive to duplicate (although I've often come across false economies by not duplicating moderately expensive environments). Despite these limits your goal should still be to duplicate the production environment as much as you can, and to understand the risks you are accepting for every difference between test and production.

但事实上这是有限制的。如果你开发的是桌面软件，很难预测你的客户在使用哪些第三方库。再者，生产环境可能非常昂贵。即便存在这么多限制，你依然应当尽量去复制生产环境，并熟知因测试环境和生产环境的不同而可能导致的风险。

> If you have a pretty simple setup without many awkward communications, you may be able to run your commit build in a mimicked environment. Often, however, you need to use test doubles because systems respond slowly or intermittently. As a result it's common to have a very artificial environment for the commit tests for speed, and use a production clone for secondary testing.

如果你搭建的环境足够简单并没有多少烦人的外部交互，那么你的提交构建便可在仿真环境中进行。但是，由于系统反应慢等原因，你可能需要test doubles。因此，通常情况是在人工环境下跑提交构建以获取速度，而用一个生产环境的拷贝环境来跑其它测试。

> I've noticed a growing interest in using virtualization to make it easy to put together test environments. Virtualized machines can be saved with all the necessary elements baked into the virtualization. It's then relatively straightforward to install the latest build and run tests. Furthermore this can allow you to run multiple tests on one machine, or simulate multiple machines in a network on a single machine. As the performance penalty of virtualization decreases, this option makes more and more sense.

我注意到，虚拟化技术越来越引起人们的兴趣。由于虚拟机可以保存构建所需的所有东西，故在虚拟机中运行构建和测试相对比较容易。另外，虚拟机技术也允许你在一台机器上运行多个测试，或者可以模拟多台机器同时访问网络的情况。随着虚拟机性能逐渐提升，它将引起更多的注意。

### Make it Easy for Anyone to Get the Latest Executable
使任何人都能轻易获得可执行文件

》 One of the most difficult parts of software development is making sure that you build the right software. We've found that it's very hard to specify what you want in advance and be correct; people find it much easier to see something that's not quite right and say how it needs to be changed. Agile development processes explicitly expect and take advantage of this part of human behavior.

软件开发最困能的事情之一便是你不能保证所开发的是正确的软件。我们发现人们往往很难预知自己究竟想要什么，而相反，对已有的东西进行评判和修改却容易的多。敏捷开发过程则恰恰是符合人类这种行为习惯的。

> To help make this work, anyone involved with a software project should be able to get the latest executable and be able to run it: for demonstrations, exploratory testing, or just to see what changed this week.

为此，项目中的所有成员都应能够获得最新的可执行文件并能成功的运行，目的可以包括做演示，浏览测试或者仅仅看看项目本周有何修改。

> Doing this is pretty straightforward: make sure there's a well known place where people can find the latest executable. It may be useful to put several executables in such a store. For the very latest you should put the latest executable to pass the commit tests - such an executable should be pretty stable providing the commit suite is reasonably strong.

这是很容易达到的：确保一个通用的地方来存放最新可执行文件。在同一个地方存放多个可执行文件也是很有用的。对于最新的可执行文件，应当保证能够通过提交测试。

> If you are following a process with well defined iterations, it's usually wise to also put the end of iteration builds there too. Demonstrations, in particular, need software whose features are familiar, so then it's usually worth sacrificing the very latest for something that the demonstrator knows how to operate.

如果你的开发过程有一个很好的迭代计划，将每次迭代最后一次构建生成的可执行文件存放起来也是明智的做法。

### Everyone can see what's happening
人人都能看到正在发生什么

> Continuous Integration is all about communication, so you want to ensure that everyone can easily see the state of the system and the changes that have been made to it.

持续集成主要在于交流，因此应当保证每人都能轻易看到当前系统的状态和已做的修改。

> One of the most important things to communicate is the state of the mainline build. If you're using Cruise there's a built in web site that will show you if there's a build in progress and what was the state of the last mainline build. Many teams like to make this even more apparent by hooking up a continuous display to the build system - lights that glow green when the build works, or red if it fails are popular. A particularly common touch is red and green lava lamps - not just do these indicate the state of the build, but also how long it's been in that state. Bubbles on a red lamp indicate the build's been broken for too long. Each team makes its own choices on these build sensors - it's good to be playful with your choice (recently I saw someone experimenting with a dancing rabbit.)

主线的构建状态是非常重要的，Cruise服务器包含一个网站，你可以在该网站上看到当前的构建状态和最后一次主线构建的结果，许多团队喜欢用比较显眼的标识来反应构建状态，比如在屏幕上放一盏灯，灯绿表示构建成功，灯红表示失败。尤其常见的是lava lamps——不仅表明构建状态，还可显示构建时间。如果红灯中有了气泡，则表明构建已经失败了很长一段时间了。每个团队都有自己的选择，当然，适合自己的才是最好的。

> If you're using a manual CI process, this visibility is still essential. The monitor of the physical build machine can show the status of the mainline build. Often you have a build token to put on the desk of whoever's currently doing the build (again something silly like a rubber chicken is a good choice). Often people like to make a simple noise on good builds, like ringing a bell.

对于手工完成的持续集成过程，这种可见性也是很重要的，构建机器的显示器应该能显示主线构建的状态。通常，正在做集成的人会放一个token在桌上来表明他正在做集成。人们喜欢在构建成功后播放一些简单的声音，比如闹铃之类的。

> CI servers' web pages can carry more information than this, of course. Cruise provides an indication not just of who is building, but what changes they made. Cruise also provides a history of changes, allowing team members to get a good sense of recent activity on the project. I know team leads who like to use this to get a sense of what people have been doing and keep a sense of the changes to the system.

当然，CI服务器的网站可以展示更多的信息。Cruise不但能可以显示是谁在构建，并且能显示最新提交的修改。另外，Cruise还可以查看提交历史，这样，团队成员便可以很清楚项目的进展情况。据我所知，有些团队的头便是通过这种方式来了解项目成员的工作情况和整个系统的修改情况。

> Another advantage of using a web site is that those that are not co-located can get a sense of the project's status. In general I prefer to have everyone actively working on a project sitting together, but often there are peripheral people who like to keep an eye on things. It's also useful for groups to aggregate together build information from multiple projects - providing a simple and automated status of different projects.

使用CI网站的另一个好处是，哪怕不在一起工作的人都可以看到当前项目的状态。再者，你也可以将不同项目的构建信息放到一起。

> Good information displays are not only those on a computer screens. One of my favorite displays was for a project that was getting into CI. It had a long history of being unable to make stable builds. We put a calendar on the wall that showed a full year with a small square for each day. Every day the QA group would put a green sticker on the day if they had received one stable build that passed the commit tests, otherwise a red square. Over time the calendar revealed the state of the build process showing a steady improvement until green squares were so common that the calendar disappeared - its purpose fulfilled.

并不是只有CI网站才能展示显示构建信息。由于构建的不稳定性是一直存在的，这时我们可以将全年的日历画在一张墙上，每天对应一个方块，如果构建成功，QA则在该天的方块贴上绿色标签，否则贴上红色标签。时间一久，这份日历便可显示出项目的稳定性进展情况。

### Automate Deployment
自动化部署

> To do Continuous Integration you need multiple environments, one to run commit tests, one or more to run secondary tests. Since you are moving executables between these environments multiple times a day, you'll want to do this automatically. So it's important to have scripts that will allow you to deploy the application into any environment easily.

做持续集成需要多种环境，不同的构建阶段需要不同的环境。每天，项目的可执行文件都会在这些环境之间搬来移去，于是你希望将这些过程自动化。因此，自动化部署脚本便很重要了，不仅包括测试环境的脚本，也包括针对生产环境的部署脚本。虽然我们不是每天都向生产环境部署，但自动化部署不仅可以加速部署过程，并且能够减少部署错误。

> A natural consequence of this is that you should also have scripts that allow you to deploy into production with similar ease. You may not be deploying into production every day (although I've run into projects that do), but automatic deployment helps both speed up the process and reduce errors. It's also a cheap option since it just uses the same capabilities that you use to deploy into test environments.


> If you deploy into production one extra automated capability you should consider is automated rollback. Bad things do happen from time to time, and if smelly brown substances hit rotating metal, it's good to be able to quickly go back to the last known good state. Being able to automatically revert also reduces a lot of the tension of deployment, encouraging people to deploy more frequently and thus get new features out to users quickly. (The Ruby on Rails community developed a tool called Capistrano that is a good example of a tool that does this sort of thing.)

如果你已经有了生产环境的自动化部署，那么也应该考虑一下相应的自动化回滚。由于失败是时而会发生的事情，在这种情况下，我们希望能快速回滚到失败之前的状态。这样一来，我们在部署是也不用那么畏首畏尾了，于是我们可以频繁的发布软件，用户亦能尽快的享受到新的功能。（Ruby on Rails社区有一款名为Capistrano的工具即是一个典型的例子。）

> In clustered environments I've seen rolling deployments where the new software is deployed to one node at a time, gradually replacing the application over the course of a few hours.

在集群环境中，我看到有每次只向一个节点部署的情况，由此在几个小时之内逐渐完成所有节点的部署。

> A particularly interesting variation of this that I've come across with public web application is the idea of deploying a trial build to a subset of users. The team then sees how the trial build is used before deciding whether to deploy it to the full user population. This allows you to test out new features and user-interfaces before committing to a final choice. Automated deployment, tied into good CI discipline, is essential to making this work.

对于一些面向大众的web应用，我所了解的另外一种很有趣的部署方式是，先试验性针对一部分用户进行部署，再通过这些用户的试用情况来决定是否向所有用户部署。自动化部署，做为CI的一项原则，能够很好的胜任这些工作。


## Benefits of Continuous Integration
持续集成的好处

> On the whole I think the greatest and most wide ranging benefit of Continuous Integration is reduced risk. My mind still floats back to that early software project I mentioned in my first paragraph. There they were at the end (they hoped) of a long project, yet with no real idea of how long it would be before they were done.

总的来说，我认为持续集成的最大好处在于降低风险。我又想起了我在本文一开始提到的那个项目——已经处于项目的末期，但是仍然不知到何时才能结束。

> The trouble with deferred integration is that it's very hard to predict how long it will take to do, and worse it's very hard to see how far you are through the process. The result is that you are putting yourself into a complete blind spot right at one of tensest parts of a project - even if you're one of the rare cases where you aren't already late.

延期集成的缺点在于，很难预测集成到底要花多少时间，更糟的是，你很难了解集成的进展情况。

> Continuous Integration completely finesses this problem. There's no long integration, you completely eliminate the blind spot. At all times you know where you are, what works, what doesn't, the outstanding bugs you have in your system.

持续集成正好解决了这些问题。每次集成的时间都不长，任何时候你都知道自己所处的情况，软件的哪些地方在工作，哪些没有。

> Bugs - these are the nasty things that destroy confidence and mess up schedules and reputations. Bugs in deployed software make users angry with you. Bugs in work in progress get in your way, making it harder to get the rest of the software working correctly.

Bug——恶心的玩意儿，伤害我们的自信，搅乱我们的日程，还破坏我们的名声。如果在生产环境中遇到了bug，那么用户将会把气往你身上撒。而在开发环境中，bug拦着你的路，迫使你无法完成余下的工作。

> Continuous Integrations doesn't get rid of bugs, but it does make them dramatically easier to find and remove. In this respect it's rather like self-testing code. If you introduce a bug and detect it quickly it's far easier to get rid of. Since you've only changed a small bit of the system, you don't have far to look. Since that bit of the system is the bit you just worked with, it's fresh in your memory - again making it easier to find the bug. You can also use diff debugging - comparing the current version of the system to an earlier one that didn't have the bug.

持续集成并不能消除bug，却能帮你快速的发现bug并予以清除。这种情况下，持续集成更像是自测试的代码。当遇到bug时，由于你只做了很小的修改，这样便大大缩小的bug的查找范围。另外，由于是你刚写的代码，你还记得很清楚，因此也使查找bug更加容易。你还可以使用diff debugging，将当前的代码版本和先前没有bug的版本进行比较。

> Bugs are also cumulative. The more bugs you have, the harder it is to remove each one. This is partly because you get bug interactions, where failures show as the result of multiple faults - making each fault harder to find. It's also psychological - people have less energy to find and get rid of bugs when there are many of them - a phenomenon that the Pragmatic Programmers call the Broken Windows syndrome.

Bug也存在积累性，bug越多，越难清除。部分原因在于bug之间存在牵连。另外也存在心理因素，bug一多，人便没那么多精力去修了——这就是所谓的“Broken Windows 综合征”。

> As a result projects with Continuous Integration tend to have dramatically less bugs, both in production and in process. However I should stress that the degree of this benefit is directly tied to how good your test suite is. You should find that it's not too difficult to build a test suite that makes a noticeable difference. Usually, however, it takes a while before a team really gets to the low level of bugs that they have the potential to reach. Getting there means constantly working on and improving your tests.

因此，对于采用持续集成的团队，bug将大大减少，不管是在生产环境，还是在开发环境。但是，我想强调的是，你的获益程度取决于测试的好坏程度。你或许已发现，写出好多测试并不难。然而，要达到低bug率的程度依然是需要时间的，你还得不断地引入并改进自己的测试。

> If you have continuous integration, it removes one of the biggest barriers to frequent deployment. Frequent deployment is valuable because it allows your users to get new features more rapidly, to give more rapid feedback on those features, and generally become more collaborative in the development cycle. This helps break down the barriers between customers and development - barriers which I believe are the biggest barriers to successful software development.

有了持续集成，频繁部署也不是什么难事了。频繁部署的价值在于，你的客户可以快速的享用软件的新功能，并能快速的提出反馈。这将有利于清除客户和开发之间的障碍——我认为这是软件开发最大的障碍。

 　　
## Introducing Continuous Integration
引入持续集成

> So you fancy trying out Continuous Integration - where do you start? The full set of practices I outlined above give you the full benefits - but you don't need to start with all of them.

然后你开始试着玩持续集成了，但该从何入手呢？上文中我所罗列持续集成实践可以给你带来太多的好处，但是你并不必在一开始就完全采用这些实践的。

> There's no fixed recipe here - much depends on the nature of your setup and team. But here are a few things that we've learned to get things going.

做持续集成没有套路，主要取决于你团队自身的情况，但是我们发现以下几点对于持续集成来说是比较通用的。

> One of the first steps is to get the build automated. Get everything you need into source control get it so that you can build the whole system with a single command. For many projects this is not a minor undertaking - yet it's essential for any of the other things to work. Initially you may only do build occasionally on demand, or just do an automated nightly build. While these aren't continuous integration an automated nightly build is a fine step on the way.

第一步需要将构建自动化，并将你所需的所有东西都放在代码管理系统中，以至于可以通过一个命令来构建整个系统。对很多项目来说，这并非易事。一开始，你可以按照需要进行构建，或者可以只做自动化的夜晚构建。虽然，这些做法都不能称为持续集成，但夜晚构建确是一个好的起点。

> Introduce some automated testing into your build. Try to identify the major areas where things go wrong and get automated tests to expose those failures. Particularly on an existing project it's hard to get a really good suite of tests going rapidly - it takes time to build tests up. You have to start somewhere though - all those cliches about Rome's build schedule apply.

在构建中引入一些自动化测试，试着确定出现问题的主要范围，并用自动化测试去发现这些问题。尤其对于已有的项目来说，很难快速建立真正的一套测试，需要耗费时间。这时你就得另寻它路了：罗马不是一天建成的。

> Try to speed up the commit build. Continuous Integration on a build of a few hours is better than nothing, but getting down to that magic ten minute number is much better. This usually requires some pretty serious surgery on your code base to do as you break dependencies on slow parts of the system.

使提交构建快速完成。虽然好几个小时的持续集成比没有要好，但是如果你能将构建时间缩短到几十分钟，或者就短短的10分钟，这就再好不过了。这通常需要在您的代码库中进行一些重大的调整, 以便解耦哪些慢速的依赖关系。

> If you are starting a new project, begin with Continuous Integration from the beginning. Keep an eye on build times and take action as soon as you start going slower than the ten minute rule. By acting quickly you'll make the necessary restructurings before the code base gets so big that it becomes a major pain.

对于新项目，从项目开始就采用持续集成。注意构建时间，如果构建时间违背了“10分钟原则”，那么请尽快采取行动。通过快速响应，在代码库变得如此庞大、成为主要痛苦之前进行必要的重组。

> Above all get some help. Find someone who has done Continuous Integration before to help you. Like any new technique it's hard to introduce it when you don't know what the final result looks like. It may cost money to get a mentor, but you'll also pay in lost time and productivity if you don't do it. (Disclaimer / Advert - yes we at ThoughtWorks do some consultancy in this area. After all we've made most of the mistakes that there are to make.)

除了以上，还要寻找帮助，找有经验的人帮助你。和其它的新技术一样，当不知到结果会是什么样时，很难开头。找一个导师可能要花钱，但是不找的话，你所付出的代价是时间的浪费和低下的生产力。（ThoughtWorks提供这样的咨询服务，毕竟你可能遇到的问题我们之前都遇到过。）
 
## Final Thoughts
总结

> In the years since Matt and I wrote the original paper on this site, Continuous Integration has become a mainstream technique for software development. Hardly any ThoughtWorks projects goes without it - and we see others using CI all over the world. I've hardly ever heard negative things about the approach - unlike some of the more controversial Extreme Programming practices.

自Matt和我发布了本文的第一版之后，持续集成逐渐变成了软件开发的主流技术，在ThoughtWorks，几乎所有的项目都使用到持续集成，同时我们也看到世界上其他组织也在使用持续集成技术。相比起充满争议的极限编程来说，持续集成很少得到负面的评论。

> If you're not using Continuous Integration I strongly urge you give it a try. If you are, maybe there are some ideas in this article that can help you do it more effectively. We've learned a lot about Continuous Integration in the last few years, I hope there's still more to learn and improve.

如果你还没有采用持续集成，我强烈建议你试一试。如果你已经采用了持续集成，本文可能会帮助你进一步提高效率。这些年来，我们已经学到了许多关于持续集成的知识，我们也希望有更多可以学习和改进的地方。

## Further Reading
延伸阅读

> An essay like this can only cover so much ground, but this is an important topic so I've created a [guide page](https://www.martinfowler.com/delivery.html) on my website to point you to more information.

像本文这样的文章通常只能涵盖一些基本，但它却是一种重要的话题，所以我在自己网站上放了一个guide page，那里你可以获得更多的信息。

> To explore Continuous Integration in more detail I suggest taking a look at Paul Duvall's [appropriately titled book](https://www.martinfowler.com/books/duvall.html) on the subject (which won a Jolt award - more than I've ever managed). For more on the broader process of Continuous Delivery, take a look at [Jez Humble and Dave Farley's book](http://www.thoughtworks.com/continuous-integration) - which also beat me to a Jolt award.

如果想了解持续集成更多的细节，我建议Paul Duvall（Jolt奖得主）的Continuous Integration: Improving Software Quality and Reducing Risk。对于更宽泛的持续交付，可以看看Humble 和 Dave Farley的Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation。

> You can also find more information on Continuous Integration on [the ThoughtWorks site](http://www.thoughtworks.com/continuous-integration).

您也可以从ThoughtWorks这里找到更多关于持续集成的信息。