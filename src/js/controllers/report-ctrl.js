/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('ReportService', function () {

    })
	.controller('ReportCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$uibModal','ReportService', function ($timeout,$rootScope,$scope,$http,$state,$uibModal,$uibModalInstance,ReportService) {
		var page = 1;
		$scope.today=new Date().toISOString().slice(0, 10);
    $scope.postData = {};
	$scope.customer_id="0";
	$scope.supplier_id="0";
	$scope.reportType="stock";
	$scope.date_from = $scope.today;
	$scope.date_to = $scope.today;
	
	$scope.print = function(){
      var printContents = document.getElementById("print_report").innerHTML;
      var popupWin = window.open('', '_blank', 'width=500,height=500');
      popupWin.document.open();
      popupWin.document.write('<html><head><link rel="stylesheet" type="text/css" href="style.css" />');
      popupWin.document.write('<style>table{width:100%;}td,th{border:1px solid #000;text-align:center;padding:4px;}</style>');
      popupWin.document.write('</head><body onload="window.print()">' + printContents + '</body></html>');
      popupWin.document.close();
    }
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
			$scope.reportPeriod="Periode " + $scope.date_from + " hingga " + $scope.date_to;
			$scope.reportParameter="Supplier";
			$scope.columns=["Tanggal","Supplier","Nilai","Terbayar","Sisa","Jatuh Tempo"];
			$scope.reportUtang();
		}
		if($scope.reportType=='piutang'){
			$scope.reportTitle="Laporan Piutang";
			$scope.reportPeriod="Periode " + $scope.date_from + " hingga " + $scope.date_to;
			$scope.reportParameter="Customer";
			$scope.columns=["Tanggal","Customer","Nilai","Terbayar","Sisa","Jatuh Tempo"];
			$scope.reportPiutang();
		}
		if($scope.reportType=='order'){
			$scope.reportTitle="Laporan Penjualan";
			$scope.reportPeriod="Periode " + $scope.date_from + " hingga " + $scope.date_to;
			$scope.reportParameter="Customer";
			$scope.columns=["Tgl. Order","No. Penjualan","Customer","Merk","Produk","Harga Customer","Qty","Subtotal","Pembayaran","Jatuh Tempo"];
			$scope.reportOrder();
		}
		if($scope.reportType=='restock'){
			$scope.reportTitle="Laporan Restock";
			$scope.reportPeriod="Periode " + $scope.date_from + " hingga " + $scope.date_to;
			$scope.reportParameter="Supplier";
			$scope.columns=["Tgl. Restock","No. Restock","Supplier","Merk","Produk","Harga Supplier","Qty","Subtotal","Pembayaran","Jatuh Tempo"];
			$scope.reportRestock();
		}
		if($scope.reportType=='stock'){
			$scope.reportTitle="Laporan Stock";
			$scope.reportPeriod="";
			$scope.columns=["Tanggal Stok","Merk","Produk","Stok"];
			$scope.reportStock();
		}
		if($scope.reportType=='cashflow'){
			$scope.reportTitle="Laporan Aliran Kas";
			$scope.reportPeriod="Periode hingga "+ $scope.date_to;
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
					$scope._colspan=2;
					
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
					$scope._colspan=2;
					
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
					$scope._colspan=6;
					
					for(var key in columnsIn){
						if(key!="customer_id"){
							if(key=="totalgrand_total"||key=="totalquantity"){
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
						if(key!="supplier_id"){
							if(key=="totalgrand_total"||key=="totalquantity"){
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
