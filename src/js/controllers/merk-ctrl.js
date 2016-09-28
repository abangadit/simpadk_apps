/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('MerkService', function () {

    })
	.controller('MerkCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		var page = 1;
		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/brands/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			
			console.log(response);
			$scope.data_merk = response.data;
		});

		$scope.detailMerk = function(id){
			MerkService.merks_id=id;
			$scope.merks_id = id;
			$state.go('detail_merk');
		};
	}])
	.controller('MerkDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		var page = 1;
		$rootScope.isLoading = true;

		$http.get(base_url+"api/"+api_key+"/brands/"+MerkService.merks_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response);
			$scope.data_merk_detail = response.data;
		});
	}])


;
