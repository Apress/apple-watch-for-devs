angular.module('starter', ['ionic'])
.run(function($ionicPlatform, $rootScope) {
  $ionicPlatform.ready(function() {
    if(window.cordova && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
    }
    if(window.StatusBar) {
      StatusBar.styleDefault();
    }
    $rootScope.loadComplete = true;
  });
})
.controller("AppControl", function($scope, RatesService, $rootScope) {
    var loadInterval = setInterval(function() {
        if($rootScope.loadComplete) {
            try {
                cordova.exec($scope.currencyLoaded, function(){}, "Communicate", "readCurrency", []);
            } catch(e) {
                $scope.currencyLoaded("USD");
            }
            clearInterval(loadInterval);
        }
    }, 500);
    $scope.currencyLoaded = function(val) {
        $scope.base = val;
        $scope.loadRates();
    }
    $scope.changeBase = function(newBase) {
        $scope.base = newBase;
        $scope.updateRates();
        try {
            cordova.exec($scope.currencyLoaded, function(){}, "Communicate", "saveCurrency", [newBase]);
        } catch(e) {}
    }
    $scope.$watch('json', function() {
       if($scope.json != undefined) $scope.updateRates();
    });
    
    $scope.loadRates = function() {
        RatesService.success(function(data) {
            $scope.json = data; 
        });
    } 
    $scope.updateRates = function() {
        var rates = [];
        var choice = $scope.json[$scope.base];
        for(var s in choice) {
            rates.push({
                rate: s,
                amount: choice[s]
            });
        }
        $scope.rates = rates;
    }
})
.factory('RatesService', function($http) {
    return $http.get('rates.json');
})