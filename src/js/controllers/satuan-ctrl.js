/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('SatuanService', function () {

    })
	.controller('SatuanCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SatuanService', function ($timeout,$rootScope,$scope,$http,$state,SatuanService) {
		var page = 1;
		$scope.refreshUnit = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/units/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);
				
				console.log(response);
				$scope.data_satuan = response.data;
			});
		}

		$scope.detailSatuan = function(id){
			SatuanService.satuan_id=id;
			$scope.satuan_id = id;
			$state.go('detail_satuan');
		};

		$scope.deleteSatuan = function(id){
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/units/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");
					
					$state.go('master_satuan');
					$scope.refreshUnit();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}
			
		};
		$scope.refreshUnit();
	}])
	.controller('SatuanDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SatuanService', function ($timeout,$rootScope,$scope,$http,$state,SatuanService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};

		$http.get(base_url+"api/"+api_key+"/units/"+SatuanService.satuan_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response.data[0]);
			$scope.data_satuan_detail = response.data[0];
		});
		$scope.editSatuan = function (){
			$rootScope.isLoading = true;
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/units",
				data 	 : {
					satuan_id:parseInt($scope.postData.satuan_id),
					satuan_nama:$scope.postData.satuan_nama,
					remarks:$scope.postData.remarks,
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
				$state.go('master_merk');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])
	.controller('SatuanAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SatuanService', function ($timeout,$rootScope,$scope,$http,$state,SatuanService) {
		$scope.postData = {};
		//$rootScope.isLoading = true;
		//load merk dropdown
		
		$scope.submitMerk = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/units",
				data 	 : {
					satuan_id:0,
					satuan_nama:$scope.postData.satuan_nama,
					remarks:$scope.postData.remarks,
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
				$state.go('master_satuan');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])


;
