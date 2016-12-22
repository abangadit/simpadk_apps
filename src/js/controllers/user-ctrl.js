/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('UserService', function () {

    })
	.controller('UserCtrl', ['$timeout','$rootScope','$scope', '$http','$state','UserService', function ($timeout,$rootScope,$scope,$http,$state,UserService) {
		var page = 1;
		$scope.refreshUser = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/users/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);
				
				console.log(response);
				$scope.data_user = response.data;
			});
		}
		$scope.detailUser = function(id){
			UserService.user_id=id;
			$scope.user_id = id;
			$state.go('detail_user');
		};
		
		$scope.deleteUser = function(id){
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/users/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");
					
					$state.go('master_user');
					$scope.refreshUser();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}
		};
		$scope.refreshUser();
		
	}])
	.controller('UserDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','UserService', function ($timeout,$rootScope,$scope,$http,$state,UserService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};

		$http.get(base_url+"api/"+api_key+"/users/"+UserService.user_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response.data[0]);
			$scope.postData = response.data[0];
		});
		$scope.editUser = function (){
			$rootScope.isLoading = true;
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/users",
				data 	 : {
					user_id:parseInt($scope.postData.user_id),
					user_name:$scope.postData.user_name,
					password:$scope.postData.password,
					user_level:$scope.postData.user_level,
					isactive:1
				},
				transformRequest: function(obj) {
					var str = [];
					for(var p in obj){
					  str.push(encodeURIComponent(p) + '=' + encodeURIComponent(obj[p]));
					}
					return str.join('&');
				}
			}).then(function successCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Data Berhasil Ditambahkan");
				$state.go('master_user');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}

	}])
	.controller('UserAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','UserService', function ($timeout,$rootScope,$scope,$http,$state,UserService) {
		$scope.postData = {};
		//$rootScope.isLoading = true;
		//load merk dropdown
		
		$scope.submitUser = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/users",
				data 	 : {
					user_id:0,
					user_name:$scope.postData.user_name,
					password:$scope.postData.password,
					user_level:$scope.postData.user_level,
					isactive:1
				},
				transformRequest: function(obj) {
					var str = [];
					for(var p in obj){
					  str.push(encodeURIComponent(p) + '=' + encodeURIComponent(obj[p]));
					}
					return str.join('&');
				}
			}).then(function successCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Data Berhasil Ditambahkan");
				$state.go('master_user');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])



;
