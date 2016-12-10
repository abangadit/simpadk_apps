/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('CustomerService', function () {

    })
	.controller('CustomerCtrl', ['$timeout','$rootScope','$scope', '$http','$state','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,CustomerService) {
		var page = 1;
		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/customers/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);

			console.log(response);
			$scope.data_customer = response.data;
		});

		$scope.detailCustomer = function(id){
			CustomerService.customer_id=id;
			$scope.customer_id = id;
			$state.go('detail_customer');
		};

		$scope.priceCustomer = function(id){
			CustomerService.customer_id=id;
			$scope.customer_id = id;
			$state.go('harga_customer');
		};

	}])
	.controller('CustomerDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,CustomerService) {
		var page = 1;
		$rootScope.isLoading = true;

		$http.get(base_url+"api/"+api_key+"/customers/"+CustomerService.customer_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response);
			$scope.data_customer_detail = response.data;
		});
	}])
	.controller('CustomerHargaCtrl', ['$timeout','$rootScope','$scope', '$http','$state','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,CustomerService) {
		var page = 1;
		//$rootScope.isLoading = true;
		// $http.get(base_url+"api/"+api_key+"/customers/"+CustomerService.customer_id+"/"+page)
		// .then(function(response) {
		// 	$timeout( function(){
    //     		$rootScope.isLoading = false;
	  //       }, 1000);
		// 	console.log(response);
		// 	$scope.data_customer_detail = response.data;
		// });
	}])


;
