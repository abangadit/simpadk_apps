/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('SupplierService', function () {

    })
	.controller('SupplierCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SupplierService', function ($timeout,$rootScope,$scope,$http,$state,SupplierService) {
		var page = 1;
		$scope.refreshSupplier = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/suppliers/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);
				
				console.log(response);
				$scope.data_supplier = response.data;
			});
		}
		$scope.detailSupplier = function(id){
			SupplierService.Supplier_id=id;
			$scope.Supplier_id = id;
			$state.go('detail_supplier');
		};
		
		$scope.deleteSupplier = function(id){
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/suppliers/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");
					
					$state.go('master_supplier');
					$scope.refreshSupplier();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}
		};
		$scope.refreshSupplier();
		
	}])
	.controller('SupplierDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SupplierService', function ($timeout,$rootScope,$scope,$http,$state,SupplierService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};

		$http.get(base_url+"api/"+api_key+"/suppliers/"+SupplierService.Supplier_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response.data[0]);
			$scope.postData = response.data[0];
		});
		$scope.editSupplier = function (){
			$rootScope.isLoading = true;
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/suppliers",
				data 	 : {
					supplier_id:parseInt($scope.postData.supplier_id),
					name:$scope.postData.name,
					phone_no:$scope.postData.phone_no,
					address:$scope.postData.address,
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
				$state.go('master_supplier');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}

	}])
	.controller('SupplierAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','SupplierService', function ($timeout,$rootScope,$scope,$http,$state,SupplierService) {
		$scope.postData = {};
		//$rootScope.isLoading = true;
		//load merk dropdown
		
		$scope.submitSupplier = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/suppliers",
				data 	 : {
					supplier_id:0,
					name:$scope.postData.name,
					phone_no:$scope.postData.phone_no,
					address:$scope.postData.address,
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
				$state.go('master_supplier');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])



;
