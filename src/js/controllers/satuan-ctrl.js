/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('SatuanService', function () {

    })
	.controller('SatuanCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SatuanService', function ($timeout,$rootScope,$scope,$http,$state,SatuanService) {
		var page = 1;
		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/units/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			
			console.log(response);
			$scope.data_satuan = response.data;
		});

		$scope.detailSatuan = function(id){
			SatuanService.satuan_id=id;
			$scope.satuan_id = id;
			$state.go('detail_satuan');
		};
	}])
	.controller('SatuanDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SatuanService', function ($timeout,$rootScope,$scope,$http,$state,SatuanService) {
		var page = 1;
		$rootScope.isLoading = true;

		$http.get(base_url+"api/"+api_key+"/units/"+SatuanService.satuan_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response);
			$scope.data_satuan_detail = response.data;
		});
	}])


;
