/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('productService', function () {

    })
	.controller('ProductCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService', function ($timeout,$rootScope,$scope,$http,$state,productService) {
		var page = 1;
		$scope.refreshProduct = function(){
			$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/products/0/"+page)
		.then(function(response) {
			$timeout( function(){
				$rootScope.isLoading = false;
			}, 1000);

			console.log(response);
			$scope.data_product = response.data;
		});

		}
		$scope.detailProduct = function(id){
			productService.products_id=id;
			$scope.products_id = id;
			$state.go('detail_product');
		};

		$scope.deleteProduct = function(id){
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/products/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");
					
					$state.go('master_product');
					$scope.refreshProduct();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}
			
		};
		$scope.refreshProduct();
		

	}])

	.controller('ProductDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService', function ($timeout,$rootScope,$scope,$http,$state,productService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};
			
		$http.get(base_url+"api/"+api_key+"/products/"+productService.products_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log("get product",response);
			$scope.postData = response.data[0];
		});

		$http.get(base_url+"api/"+api_key+"/brands/")
		.then(function(response) {
			console.log(response);
			$scope.data_merk = response.data;

			//load satuan dropdown
			$http.get(base_url+"api/"+api_key+"/units/")
			.then(function(response) {
				$timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
				console.log(response);
				$scope.data_satuan = response.data;
			});
		});

		$scope.editProduct = function (){
			$rootScope.isLoading = true;
			console.log("edit...")
			console.log("data posted",$scope.postData)
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/products",
				data 	 : {
					product_id:$scope.postData.product_id,
					merk_id:parseInt($scope.postData.merk_id),
					satuan_id:parseInt($scope.postData.satuan_id),
					product_nama:$scope.postData.product_nama,
					default_price:$scope.postData.default_price,
					remarks:$scope.postData.remarks,
					stock:$scope.postData.stock,
					min_stock:$scope.postData.min_stock,
					supplier_price:$scope.postData.supplier_price,
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
				$state.go('master_product');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])
	.controller('ProductAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService', function ($timeout,$rootScope,$scope,$http,$state,productService) {
		$scope.postData = {};
		$rootScope.isLoading = true;
		//load merk dropdown
		$http.get(base_url+"api/"+api_key+"/brands/")
		.then(function(response) {
			console.log(response);
			$scope.data_merk = response.data;

			//load satuan dropdown
			$http.get(base_url+"api/"+api_key+"/units/")
			.then(function(response) {
				$timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
				console.log(response);
				$scope.data_satuan = response.data;
			});
		});


		$scope.submitProduct = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/products",
				data 	 : {
					product_id:0,
					merk_id:parseInt($scope.postData.merk),
					satuan_id:parseInt($scope.postData.satuan),
					product_nama:$scope.postData.nama,
					default_price:$scope.postData.default_price,
					remarks:$scope.postData.remarks,
					stock:$scope.postData.stok,
					min_stock:$scope.postData.min_stok,
					supplier_price:$scope.postData.supplier_price,
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
				$state.go('master_product');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}

	}])


;
