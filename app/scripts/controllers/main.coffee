'use strict'

###*
 # @ngdoc function
 # @name rdmApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the rdmApp
###
angular.module('rdmApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
