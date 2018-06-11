# angularjs tricks

## dynamic add dependency to an exsit module

https://stackoverflow.com/questions/18875714/re-open-and-add-dependencies-to-an-already-bootstrapped-application

	//var adminApp = angular.module('adminApp', ['mainApp', 'ui.sortable']);
	var adminApp = zqnb.adminApp;
	adminApp.requires.push('ui.sortable'); 
	//adminApp.requires.push('ui.sortable', 'demo2', 'demo...'); 