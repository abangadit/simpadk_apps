/**
 * Alerts Controller
 */

 angular
     .module('RDash')
     .service('productService', function () {

     })
     .service('cartService', function () {
       return {
               form: [],
               getForm: function() {
                   return this.form;
               },
               updateForm: function(item) {
                   this.form.push(item);
               },
               clearForm: function() {
                   this.form = [];
               }
           }
     })
  	.controller('TransaksiCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal) {
      var page = 1;
  		$scope.sample_item = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
  		$scope.items = ['item1', 'item2', 'item3'];
  		$scope.animationsEnabled = true;
      $scope.nama_customer = "Pelanggan Biasa";
      $scope.alamat_customer = " - ";
      $scope.telp_customer = " - ";
      $scope.cart = cartService.getForm();
      $scope.customer_id = 0;
      $scope.total = 0;
      //$scope.cart = $scope.sample_item;





      //get products katalog
  		$rootScope.isLoading = true;
  		$http.get(base_url+"api/"+api_key+"/products/0/"+page)
  		.then(function(response) {
  			$timeout( function(){
          		$rootScope.isLoading = false;
  	        }, 1000);

  			console.log(response);
  			$scope.data_product = response.data;
  		});

      //kosongkan cart
      $scope.emptyCart = function(){
        console.log("kosongkan");
        cartService.clearForm();
        $scope.cart = cartService.getForm();
        $scope.total = 0;
      }

      //tampilkan popup order
  		$scope.order_popup = function(size,id,name,price){
  			productService.product_id=id;
    		productService.product_name=name;
    		productService.product_price=price;

        //alert(name+" "+productService.product_price);
        open_popup(size);
  		}

      //tampilkan popup pilih customer
      $scope.pilih_customer = function (){
        $rootScope.modalInstance = $uibModal.open({
            templateUrl: 'templates/myModalCustomer.html',
            size: "md",
        });
      }

      function open_popup (size){
        $rootScope.modalInstance = $uibModal.open({
  	        templateUrl: 'templates/myModalContent.html',
  	        size: size,
  	        resolve: {
  	            items: function () {
  	                return $scope.items;
  	            }
  	        }
  	    });

  	    $rootScope.modalInstance.result.then(function (selectedItem) {
  	        $scope.selected = selectedItem;

            $scope.total += selectedItem;
  	    }, function () {
  	        //$log.info('Modal dismissed at: ' + new Date());
  	    });
      }

      //proses checkout
  		$scope.checkout = function(){
        $rootScope.isLoading = true;
        $scope.order_count = 0;
  			$http({
  				method: 'POST',
  				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
  				url 	 : base_url+"api/"+api_key+"/orders",
  				data 	 : {
  					order_id:0,
  					order_date:new Date(),
  					user_id:1,
  					customer_id:$scope.customer_id,
  					total:$scope.total,
  					discount:0,
  					grand_total:$scope.total,
  					delivery_date:"",
  					isdelivered:0,
  					remarks:"",
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
  			      // $timeout( function(){
  	        	// 	$rootScope.isLoading = false;
  		        // }, 1000);
  		        // alert("Pesanan Berhasil Dibuat");
  		        console.log(response.data[0].insert_id);
              insert_order_item(response.data[0].insert_id);

  			  }, function errorCallback(response) {
  			    $timeout( function(){
  	        		$rootScope.isLoading = false;
  		        }, 1000);
  		        alert("Terjadi Kesalahan, Ulangi ");
  			  });


  		};

      function insert_order_item(order_id){
        console.log("insert order item after order created , order_id:"+order_id);
        for (var i = 0; i < $scope.cart.length; i++) {
    			$http({
    				method: 'POST',
    				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
    				url 	 : base_url+"api/"+api_key+"/orderitems",
    				data 	 : {
    					orderitem_id:0,
    					order_id:order_id,
    					customer_id:0,
    					customer_price_id:0,
    					product_id:$scope.cart[i].id,
    					customer_price:$scope.cart[i].price,
    					quantity:$scope.cart[i].qty,
    					subtotal:$scope.cart[i].price*$scope.cart[i].qty,
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
    			      $scope.order_count += 1;
                order_done();
    			  }, function errorCallback(response) {
    		        alert("Terjadi Kesalahan, Ulangi ");
    			  });
        }
      }
      function order_done(){
        if($scope.order_count==$scope.cart.length){
          $timeout( function(){
            $rootScope.isLoading = false;
          }, 1000);
        }

      }


  	}])
  	.controller('ModalCustomerCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal,$log,$uibModalInstance) {
      $rootScope.isLoading = true;
  		$http.get(base_url+"api/"+api_key+"/customers/0/")
  		.then(function(response) {
  			$timeout( function(){
          		$rootScope.isLoading = false;
  	        }, 1000);

  			console.log(response);
  			$scope.data_customer = response.data;
  		});

  	}])
  	.controller('ModalInstanceCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal,$log,$uibModalInstance) {
      $scope.productPrice = productService.product_price;
      $scope.productName = productService.product_name;
      $scope.productID= productService.product_id;
  		$scope.postData = {};

  		$scope.ok = function () {
        if($scope.postData.qty==0 || typeof $scope.postData.qty === "undefined") {
          alert("Quantitiy Tidak Boleh Kosong ! ");
        }else{
          productService.total = $scope.productPrice;
          cartService.updateForm(angular.copy({
            id  : $scope.productID,
            name: $scope.productName,
            qty : $scope.postData.qty,
            price : $scope.productPrice * $scope.postData.qty
          }));
          $rootScope.modalInstance.close($scope.productPrice * $scope.postData.qty);
        }

		  };


  	}])
;
