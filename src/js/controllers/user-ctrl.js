/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('UserService', function () {

    })
	.controller('UserCtrl', ['$timeout','$rootScope','$scope', '$http','$state','UserService', function ($timeout,$rootScope,$scope,$http,$state,UserService) {
		var page = 1;
		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/users/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			
			console.log(response);
			$scope.data_user = response.data;
		});

		$scope.detailUser = function(id){
			UserService.user_id=id;
			$scope.user_id = id;
			$state.go('detail_user');
		};
	}])
	.controller('UserDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','UserService', function ($timeout,$rootScope,$scope,$http,$state,UserService) {
		var page = 1;
		$rootScope.isLoading = true;

		$http.get(base_url+"api/"+api_key+"/users/"+UserService.user_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response);
			$scope.data_user_detail = response.data;
		});
	}])


;
