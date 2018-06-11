#Using MSBuild and Team Foundation Build - 2nd Edition
---------

##1 MSBulid Quick Start

Project File Detials

- Project: DefaultTargets, InitialTargets
- PropertyGroup, <Property>
- Target,<Task>
- ItemGroup, <Item>, <Item Metadata>
- Item Transformation: @(ItemType-> '...%()...')
- Every Xml Element: ==, !=, Exist, !Exist
- Target Command Line: /p:Configuration=Debug /t:PrintContent /nologo ...


$(SomeProperty)，@(SomeItem)


Extending The Build Process

- Pre-build & Post-build
- overrride BeforeBuild, AfterBuild
- Extend the BuildDependsOn list

MSBuildFile -> MSBuild project file -> a Xml file
Target包含Task
wildcard: ?， *， **


##2 MSBulid Deep Dive, Part1

conversions:

- .proj
- .targets
- .props
- .tasks

xsd files:

- Micorosft.Build.xsd
	- Micorosft.Build.Core.xsd
	- Micorosft.Build.Commontypes.xsd

Properties

- Environment Variables
- Reserved Properties
- Command-Line Properties
- Dynamic Properties


MSBuild processes the entire file for roperties and items before any targets are executed!

Items

common use for files and directories

Copy Tasks




## Common Tasks

	CallTarget
	