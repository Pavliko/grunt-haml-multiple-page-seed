'use strict'

angular.module('app')
  .controller 'MainCtrl', ($scope, $http) ->
    console.log 'MainCtrl'

    $http.jsonp('http://localhost:3000/test.js?callback=JSON_CALLBACK').success (data) ->
      $scope.jsonpText = data
