/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('ReportService', function () {

    })
	.controller('ReportCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$uibModal','ReportService', function ($timeout,$rootScope,$scope,$http,$state,$uibModal,$uibModalInstance,ReportService) {
		var page = 1;
    $scope.postData = {};

    //$rootScope.isLoading = true;
	$http.get(base_url+"api/"+api_key+"/suppliers/0/")
  		.then(function(response) {
  			$timeout( function(){
          		$rootScope.isLoading = false;
  	        }, 1000);

  			console.log(response);
  			$scope.data_supplier = response.data;
  		});
	$http.get(base_url+"api/"+api_key+"/customers/0/")
  		.then(function(response) {
  			$timeout( function(){
          		$rootScope.isLoading = false;
  	        }, 1000);

  			console.log(response);
  			$scope.data_customer = response.data;
  		});
		
	$scope.proceedReport = function(){
		
		if($scope.reportType=="utang"){
			$scope.reportTitle="Laporan Utang";
			$scope.reportPeriod="Periode";
			$scope.reportParameter="Supplier";
			$scope.columns=["Tanggal","Supplier","Nilai","Terbayar","Sisa","Jatuh Tempo"];
			$scope.reportUtang();
		}
		if($scope.reportType=='piutang'){
			$scope.reportTitle="Laporan Piutang";
			$scope.reportPeriod="Periode";
			$scope.reportParameter="Customer";
			$scope.columns=["Tanggal","Customer","Nilai","Terbayar","Sisa","Jatuh Tempo"];
			$scope.reportPiutang();
		}
		if($scope.reportType=='order'){
			$scope.reportTitle="Laporan Penjualan";
			$scope.reportPeriod="Periode";
			$scope.reportParameter="Customer";
			$scope.columns=["Tgl. Order","Customer","Merk","Produk","Harga Customer","Qty","Subtotal","Pembayaran","Jatuh Tempo"];
			$scope.reportOrder();
		}
		if($scope.reportType=='restock'){
			$scope.reportTitle="Laporan Restock";
			$scope.reportPeriod="Periode";
			$scope.reportParameter="Supplier";
			$scope.columns=["Tgl. Restock","Supplier","Merk","Produk","Harga Supplier","Qty","Subtotal","Pembayaran","Jatuh Tempo"];
			$scope.reportRestock();
		}
		if($scope.reportType=='stock'){
			$scope.reportTitle="Laporan Stock";
			$scope.reportPeriod="Periode";
			$scope.columns=["Tanggal Stok","Merk","Produk","Stok"];
			$scope.reportStock();
		}
		if($scope.reportType=='cashflow'){
			$scope.reportTitle="Laporan Aliran Kas";
			$scope.reportPeriod="Periode";
			$scope.columns=["Tanggal","No. Penjualan","No. Restok","Keterangan","Jumlah"];
			$scope.reportCashflow();
		}
	}
	$scope.reportUtang = function(){
		var _supplier_id=0;
		console.log($scope.supplier_id)
		if($scope.supplier_id>0){
			_supplier_id=$scope.supplier_id;
		}
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/utang",
				data 	 : {
					date_from:$scope.date_from,
					date_to:$scope.date_to,
					supplier_id:_supplier_id
         
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=3;
					
					for(var key in columnsIn){
						if(key!="supplier_id" && key!="restock_id" && key!="utang_id"){
							if(key=="totalvalue"||key=="totalpaid"||key=="totalbalance"){
								$scope.sumname.push(key);
							}else{
								$scope.colname.push(key); // here is your column name you are looking for
							}
						}
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};
		
		$scope.reportPiutang = function(){
		var _customer_id=0;
		console.log($scope.customer_id)
		if($scope.customer_id>0){
			_customer_id=$scope.customer_id;
		}
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/piutang",
				data 	 : {
					date_from:$scope.date_from,
					date_to:$scope.date_to,
					customer_id:_customer_id
         
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=3;
					
					for(var key in columnsIn){
						if(key!="customer_id" && key!="order_id" && key!="piutang_id"){
							if(key=="totalvalue"||key=="totalpaid"||key=="totalbalance"){
								$scope.sumname.push(key);
							}else{
								$scope.colname.push(key); // here is your column name you are looking for
							}
						}
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};

		$scope.reportOrder = function(){
		var _customer_id=0;
		console.log($scope.customer_id)
		if($scope.customer_id>0){
			_customer_id=$scope.customer_id;
		}
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/order",
				data 	 : {
					date_from:$scope.date_from,
					date_to:$scope.date_to,
					customer_id:_customer_id
         
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=7;
					
					for(var key in columnsIn){
						if(key!="customer_id" && key!="order_id"){
							if(key=="grand_total"){
								$scope.sumname.push(key);
							}else{
								$scope.colname.push(key); // here is your column name you are looking for
							}
						}
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};

		$scope.reportRestock = function(){
		var _supplier_id=0;
		console.log($scope.supplier_id)
		if($scope.supplier_id>0){
			_supplier_id=$scope.supplier_id;
		}
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/restock",
				data 	 : {
					date_from:$scope.date_from,
					date_to:$scope.date_to,
					supplier_id:_supplier_id
         
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=6;
					
					for(var key in columnsIn){
						if(key!="supplier_id" && key!="restock_id"){
							if(key=="grand_total"){
								$scope.sumname.push(key);
							}else{
								$scope.colname.push(key); // here is your column name you are looking for
							}
						}
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};

		$scope.reportStock = function(){
		
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/stock",
				data 	 : {},
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=6;
					
					for(var key in columnsIn){
						$scope.colname.push(key); // here is your column name you are looking for
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};

		$scope.reportCashflow = function(){
		
		$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/reports/cashflow",
				data 	 : {
					date_from:$scope.date_from,
					date_to:$scope.date_to
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
					$scope.reportData = response.data;
					var columnsIn = response.data[0]; 
					$scope.colname=[];
					$scope.sumname=[];
					$scope._colspan=4;
					
					for(var key in columnsIn){
						if(key!="value" && key!="cashflow_id" && key!="utang_id"){
							if(key=="Balance"){
								$scope.sumname.push(key);
							}else{
								$scope.colname.push(key); // here is your column name you are looking for
							}
						}
					} 
		        }, 1000);

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};
	}])


;
