/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('productService', function () {

    })
	.controller('ProductCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService', function ($timeout,$rootScope,$scope,$http,$state,productService) {
		var page = 1;
		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/products/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			
			console.log(response);
			$scope.data_product = response.data;
		});

		$scope.detailProduct = function(id){
			productService.products_id=id;
			$scope.products_id = id;
			$state.go('detail_product');
		};
	}])
	.controller('ProductDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService', function ($timeout,$rootScope,$scope,$http,$state,productService) {
		var page = 1;
		$rootScope.isLoading = true;

		$http.get(base_url+"api/"+api_key+"/products/"+productService.products_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response);
			$scope.data_product_detail = response.data;
		});
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
			//localhost:3000/api/c89ba5b91d1ed6642892ffa94314b72e7d1686/products
			// var postObject = new Object();
			// postObject.product_id = 0;
			// postObject.merk_id = parseInt($scope.postData.merk);
			// postObject.satuan_id = parseInt($scope.postData.satuan);
			// postObject.product_nama = $scope.postData.nama;
			// postObject.remarks = $scope.postData.remarks;
			// postObject.isactive = 1;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/products", 
				data 	 : {
					product_id:0, 
					merk_id:parseInt($scope.postData.merk), 
					satuan_id:parseInt($scope.postData.satuan),
					product_nama:$scope.postData.nama,
					remarks:$scope.postData.remarks,
					stock:$scope.postData.stok,
					min_stock:$scope.postData.min_stok,
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
		        alert("Data Berhasil Ditambahakan");

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
		
	}])


;
