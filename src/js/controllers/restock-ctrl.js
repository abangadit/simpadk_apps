/**
 * Alerts Controller
 */

 angular.module('RDash').service('productService', function () {})
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
  	.controller('RestockCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal) {
      var page = 1;
  		$scope.sample_item = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20'];
  		$scope.items = ['item1', 'item2', 'item3'];
  		$scope.animationsEnabled = true;
      $rootScope.nama_customer = "";
      $rootScope.alamat_customer = " - ";
      $rootScope.telp_customer = " - ";
      $scope.cart = cartService.getForm();
      $scope.supplier_id = 0;
      $scope.total = 0;
      $rootScope.supplier_id = 0;
      $scope.postData = {};
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
      $rootScope.emptyCart = function(){
        console.log("kosongkan");
        cartService.clearForm();
        $scope.cart = cartService.getForm();
        $scope.total = 0;
      }
      //delete cart item
      $scope.deleteItem = function(index){
        console.log("deleteItem");
        cartService.deleteForm(index);


        $scope.cart = cartService.getForm();
        $scope.total = 0;
        for (var i = 0; i < $scope.cart.length; i++) {
          $scope.total += $scope.cart[i].price;
        }
      }
      //tampilkan popup order
  		$scope.order_popup = function(size,id,name,price){
        if($rootScope.supplier_id>0){
  			productService.product_id=id;
    		productService.product_name=name;
    		productService.product_price=price;

        //alert(name+" "+productService.product_price);
        open_popup(size);
        }else{
          alert("Pilih Supplier terlebih dahulu");
        }
  		}
      $scope.hapus_customer = function (){
        $rootScope.nama_customer = "";
        $rootScope.alamat_customer = " - ";
        $rootScope.telp_customer = " - ";
        $rootScope.supplier_id = 0;
      }
      //tampilkan popup pilih customer
      $scope.pilih_customer = function (){
        $rootScope.modalInstance = $uibModal.open({
            templateUrl: 'templates/myModalSupplier.html',
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
        if(typeof $scope.postData.isdebt === "undefined"){
          $scope.postData.isdebt = 0;
        }

        if(typeof $scope.postData.date === "undefined"){
          $scope.postData.date = "0000-00-00";
        }

        if(typeof $rootScope.supplier_id === "undefined"){
          alert("pilih supplier terlebih dahulu !");
        }else{
          $rootScope.isLoading = true;
          $scope.order_count = 0;
          var date = new Date();
          var day = date.getDate();
          var monthIndex = date.getMonth();
          var year = date.getFullYear();

    			$http({
    				method: 'POST',
    				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
    				url 	 : base_url+"api/"+api_key+"/restocks",
    				data 	 : {
    					restock_id:0,
    					restock_date:year+"-"+(monthIndex+1)+"-"+day,
    					user_id:$scope.user_id,
    					supplier_id:$rootScope.supplier_id,
    					total:$scope.total,
    					discount:0,
    					grand_total:$scope.total,
              due_date:$scope.postData.isdebt?$scope.postData.date:"0000-00-00",
              isdebt:$scope.postData.isdebt?1:0,
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
                productService.restock_id = response.data[0].insert_id;
    		        console.log(response.data[0]+" "+response.data[0].insert_id);
                insert_order_item(response.data[0].insert_id);

    			  }, function errorCallback(response) {
    			    $timeout( function(){
    	        		$rootScope.isLoading = false;
    		        }, 1000);
    		        alert("Terjadi Kesalahan, Ulangi ");
    			  });
        }

      }
      function insert_order_item(order_id){
        console.log("insert order item after order created , order_id:"+order_id);
        for (var i = 0; i < $scope.cart.length; i++) {
          console.log("cart",$scope.cart)
    			$http({
    				method: 'POST',
    				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
    				url 	 : base_url+"api/"+api_key+"/restockitems",
    				data 	 : {
    					restockitem_id:0,
    					restock_id:order_id,
    					product_id:$scope.cart[i].id,
    					price:$scope.cart[i].price/$scope.cart[i].qty,
    					quantity:$scope.cart[i].qty,
    					subtotal:$scope.cart[i].price,
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
            alert("Stock Berhasil Ditambahkan");
            //open_popup_transaksi('lg');
            $rootScope.emptyCart();
            $rootScope.isLoading = true;
            $http.get(base_url+"api/"+api_key+"/products/0/"+page)
            .then(function(response) {
              $timeout( function(){
                    $rootScope.isLoading = false;
                  }, 1000);

              console.log(response);
              $scope.data_product = response.data;
            });
          }, 1000);
        }

      }
      function open_popup_transaksi (size){
        $rootScope.modalInstance = $uibModal.open({
  	        templateUrl: 'templates/modal_print.html',
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
  	}])
  	.controller('RestockPrintCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal,$log,$uibModalInstance) {
      $scope.order_id = productService.order_id;
      $scope.order_id = 29;
      //alert($scope.order_id);
      $rootScope.isLoading = true;
  		$http.get(base_url+"api/"+api_key+"/orders/"+$scope.order_id)
  		.then(function(response) {
        console.log(response.data);
        for(var x=0;x<response.data.length;x++){
          //console.log($scope.data_customer[x].address);
          $rootScope.nama_customer = response.data[x].name;
          $rootScope.alamat_customer = response.data[x].address;
          $rootScope.telp_customer = response.data[x].phone_no;
        }

        $http.get(base_url+"api/"+api_key+"/orderitems/"+$scope.order_id)
    		.then(function(response) {
    			$scope.data_order_item = response.data;
          $timeout( function(){
        		$rootScope.isLoading = false;
          }, 1000);
    		});
  			$scope.data_order = response.data;
  		});

      $scope.print = function(){
        var printContents = document.getElementById("print_nota").innerHTML;
        var popupWin = window.open('', '_blank', 'width=300,height=300');
        popupWin.document.open();
        popupWin.document.write('<html><head><link rel="stylesheet" type="text/css" href="style.css" /></head><body onload="window.print()">' + printContents + '</body></html>');
        popupWin.document.close();
      }

  	}])
  	.controller('ModalSupplierCtrl', ['$timeout','$rootScope','$scope', '$http','$state','productService','cartService','$uibModal', function ($timeout,$rootScope,$scope,$http,$state,productService,cartService,$uibModal,$log,$uibModalInstance) {
      $rootScope.isLoading = true;
  		$http.get(base_url+"api/"+api_key+"/suppliers/0/")
  		.then(function(response) {
  			$timeout( function(){
          		$rootScope.isLoading = false;
  	        }, 1000);

  			console.log(response);
  			$scope.data_customer = response.data;
  		});

      $rootScope.nama_customer = "";
      $rootScope.alamat_customer = "";
      $rootScope.telp_customer = "";

      $scope.submit_customer = function(){
        var dropdown_customer = $scope.postData.dropdown_customer;
        //alert(dropdown_customer);

        $rootScope.isLoading = true;
        console.log(base_url+"api/"+api_key+"/suppliers/"+dropdown_customer);
    		$http.get(base_url+"api/"+api_key+"/suppliers/"+dropdown_customer)
    		.then(function(response) {
    			$timeout( function(){
            		$rootScope.isLoading = false;
    	        }, 500);

    			console.log(response);
          for(var x=0;x<response.data.length;x++){
            //console.log($scope.data_customer[x].address);
            $rootScope.supplier_id = response.data[x].supplier_id;
            $rootScope.nama_customer = response.data[x].name;
            $rootScope.alamat_customer = response.data[x].address;
            $rootScope.telp_customer = response.data[x].phone_no;
            $rootScope.emptyCart();
          }
    		});
      }

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
