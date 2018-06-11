#AngularJs

## Features


MVC
数据绑定
依赖注入（迪米特法则， 例如:controller不应该操心$scope等的创建和来源）
指令（HTML指令扩展）



## 非侵入式javascript

曾经，在Html中加入click等内联事件，非常糟糕，理由：

1 不是所有浏览器都支持js
2 禁用js
3 类似于IE兼容性问题
4 全局污染
5 绑定数据结构和行为，难以维护、扩展和理解。


问题不是出在事件处理器上，而是写js的方式有问题（代码逻辑绑定了DOM），Angular不存在这个问题。
一旦绑定了DOM，对于单元测试或后期的维护、扩展都将是灾难。


## directive

ng-repeat

	$index
	$first
	$middle
	$last

ng-show, ng-hide

ng-class, ng-style

	ng-class='{error: isError, warning: isWarning}'

ng-src, ng-herf

	angular没有办法拦截src和href（浏览器的机制）

expression

	避免将业务逻辑渗透到模板里！
	并不是js的eval（），有一定局限性！

MVC的职责分离

	建议，为单独的功能建立单独的controller，例如MenuCtrl, BreadcrumbCtrl, ...
	controller是可以嵌套和继承的（真实的嵌套发生在$scope上）