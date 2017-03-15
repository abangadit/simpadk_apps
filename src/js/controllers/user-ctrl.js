/**
 * Alerts Controller
 */

angular.module('RDash').service('UserService', function () {})
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
				$scope.page_count=response.data[0].page_count;
				$scope.page_next=page>$scope.page_count?$scope.page_count:page+1;
				$scope.page_prev=page<=1?1:page-1;

				console.log("pagecount:",$scope.page_count);
				$scope.pages = [];
				var i=1;
				for(i=1;i<=$scope.page_count;i++){
					if(i>=page-5 && i<=page+5){
						$scope.pages.push(page==i?"["+i+"]":i);
					}


				}
			});
		}
		$scope.setpage=function(page_no){
			console.log("gotopage",page_no);
			page=page_no;
			$scope.refreshUser();

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
