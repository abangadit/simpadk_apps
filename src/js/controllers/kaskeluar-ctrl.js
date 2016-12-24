/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('KasKeluarCtrl', function () {

    })
	.controller('KasKeluarCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$uibModal','KasKeluarCtrl', function ($timeout,$rootScope,$scope,$http,$state,$uibModal,$uibModalInstance,KasKeluarCtrl) {
		var page = 1;
    $scope.postData = {};

    $rootScope.isLoading = true;

    $scope.getData = function(){
      console.log(base_url+"api/"+api_key+"/utang/0/"+page);
      $http({
        method: 'GET',
        headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
        url 	 : base_url+"api/"+api_key+"/utang/0/"+page,
        data 	 : {
          customer_id:0,
          date_from:"0000-00-00",
          date_to:"2030-01-01",
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
          console.log(response.data);
          $scope.data_orders = response.data;

        }, function errorCallback(response) {
          $timeout( function(){
              $rootScope.isLoading = false;
            }, 1000);
            alert("Terjadi Kesalahan, Ulangi ");
        });
    }
    
    $scope.getData();
    

    $scope.bayarPiutang = function(order_id,customer_id){
      console.log("bayar piutang "+order_id);
      $rootScope.order_id = order_id;
      $rootScope.customer_id = customer_id;

      $rootScope.modalInstance = $uibModal.open({
          templateUrl: 'templates/modalBayarPiutang.html',
          size: "md",
      });
    }

    $scope.closeModal = function(){
      $rootScope.modalInstance.dismiss();
    };

		$scope.submitKasMasuk = function(){
      $rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/cashflows/bayarpiutang",
				data 	 : {
					bayar_date:$scope.postData.date,
					order_id:$rootScope.order_id,
					value_bayar:$scope.postData.jumlah_bayar,
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
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		      alert("Data Berhasil Ditambahkan");
				  $scope.getData();
          $rootScope.modalInstance.dismiss();

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		};

	}])


;
