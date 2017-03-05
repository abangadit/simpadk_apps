/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('CustomerService', function () {

    })
	.controller('CustomerCtrl', ['$timeout','$rootScope','$scope', '$http','$state','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,CustomerService) {
		var page = 1;

		$scope.refreshCustomer = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/customers/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);

				console.log(response);
				$scope.data_customer = response.data;
				$scope.page_count=response.data[0].page_count;
				$scope.page_next=page>$scope.page_count?$scope.page_count:page+1;
				$scope.page_prev=page<=1?1:page-1;

				console.log("pagecount:",$scope.page_count);
				$scope.pages = [];
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
			$scope.refreshCustomer();

		}
		$scope.detailCustomer = function(id){
			CustomerService.customer_id=id;
			$scope.customer_id = id;
			$state.go('detail_customer');
		};

		$scope.deleteCustomer = function(id){
      console.log(base_url+"api/"+api_key+"/customers/"+id+"/0");
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/customers/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");

					$state.go('master_customer');
					$scope.refreshCustomer();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}

		};

		$scope.priceCustomer = function(id){
			CustomerService.customer_id=id;
			$scope.customer_id = id;
			$state.go('harga_customer');
		};

		$scope.refreshCustomer();



	}])
	.controller('CustomerDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,CustomerService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};

		$http.get(base_url+"api/"+api_key+"/customers/"+CustomerService.customer_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response.data[0]);
			$scope.postData = response.data[0];
		});

		$scope.editCustomer = function (){
			$rootScope.isLoading = true;
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/customers",
				data 	 : {
					customer_id:parseInt($scope.postData.customer_id),
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
				$state.go('master_customer');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])
	.controller('CustomerAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		$scope.postData = {};
		//$rootScope.isLoading = true;
		//load merk dropdown

		$scope.submitCustomer = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/customers",
				data 	 : {
					customer_id:0,
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
				$state.go('master_customer');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])
	.controller('CustomerHargaCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$window','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,$window,CustomerService) {
		var page = 1;

		$scope.back_prev = function(){
		console.log("back");
		$window.history.back();
		}

		$scope.getPrices = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/customerprices/"+CustomerService.customer_id+"/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);

				console.log(response);
				$scope.data_prices = response.data;
				$scope.page_count=response.data[0].page_count;
				console.log("pagecount:",$scope.page_count);
				// $scope.page_count=response.data[0].page_count;
				// $scope.page_next=page>$scope.page_count?$scope.page_count:page+1;
				// $scope.page_prev=page<=1?1:page-1;
        //
				// console.log("pagecount:",$scope.page_count);
				// $scope.pages = [];
				// for(i=1;i<=$scope.page_count;i++){
				// 	if(i>=page-5 && i<=page+5){
				// 		$scope.pages.push(page==i?"["+i+"]":i);
				// 	}
        //
        //
				// }
			});
		}
		$scope.setpage=function(page_no){
			console.log("gotopage",page_no);
			page=page_no;
			$scope.getPrices();

		}
		$scope.detailCustomer = function(id){
			CustomerService.customer_id=id;
			$scope.customer_id = id;
			$state.go('detail_customer');
		};

		$scope.deletePrices = function(id){
      console.log(id);
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/customerprices/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");

					$state.go('harga_customer');
					$scope.getPrices();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}

		};
		$scope.getPrices();
	}])
  .controller('CustomerHargaAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$window','CustomerService', function ($timeout,$rootScope,$scope,$http,$state,$window,CustomerService) {
		var page = 1;

		$scope.getProduct = function(){
			$rootScope.isLoading = true;
      $http.get(base_url+"api/"+api_key+"/products/0/"+page)
  		.then(function(response) {
  			$timeout( function(){
  				$rootScope.isLoading = false;
  			}, 1000);

  			console.log(response);
  			$scope.data_product = response.data;
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

    $scope.submitCustomerPrices = function (){
			$rootScope.isLoading = true;
      console.log(CustomerService.customer_id+" "+$scope.postData.product+" "+$scope.postData.price+" "+api_key);
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/customerprices",
				data 	 : {
          customer_price_id:0,
					customer_id:CustomerService.customer_id,
					product_id:$scope.postData.product,
					price:$scope.postData.price,
					key:api_key
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
				$state.go('master_customer');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}


		$scope.getProduct();
	}])


;
