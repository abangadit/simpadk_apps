/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .config(['ChartJsProvider', function (ChartJsProvider) {
	    // Configure all charts
	    ChartJsProvider.setOptions({
	      chartColors: ['#FF5252', '#FF8A80'],
	      responsive: false
	    });
	    // Configure all line charts
	    ChartJsProvider.setOptions('line', {
	      showLines: false
	    });
	  }])
	.controller('DashboardCtrl', ['$scope', '$http','$state','$timeout','$rootScope', function ($scope,$http,$state,$timeout,$rootScope) {
		console.log("dashboard page");
		$scope.labels = [];
		$scope.series = ['Series A', 'Series B'];
		$scope.data = [];


    //get widget sales//
    $rootScope.isLoading = true;
    $http.get(base_url+"api/"+api_key+"/dashboards/saleswidget")
    .then(function(response) {
      $rootScope.isLoading = false;

      $scope.daily = response.data[0].DailySales;
      $scope.weekly = response.data[0].WeeklySales;
      $scope.monthly = response.data[0].MonthlySales;
      console.log(response.data);
    });
    //----//

    //get grafik dashboard//
    $http.get(base_url+"api/"+api_key+"/dashboards/graphic/month")
    .then(function(response) {
      $rootScope.isLoading = false;
      var i=1;
      console.log("response",response.data)
      for(var x = 0;x<=response.data.length;x++){
        
        var item = response.data[x];
        console.log("item",item)
        $scope.labels.push(item.label);
        $scope.data.push(item.value);
        i++;
      }
/*      for(var x = 1;x<=response.data.length;x++){
        $scope.labels.push(x);
        $scope.data.push(response.data[x]);
      }*/
    });
    //----//

    //get peringatan stok dashboard//
    $http.get(base_url+"api/"+api_key+"/dashboards/stock")
    .then(function(response) {
      $rootScope.isLoading = false;
      $scope.data_stok = response.data;
      console.log(response.data);
    });
    //----//

    $scope.onClick = function (points, evt) {
			console.log(points, evt);
		};

	}])


;
