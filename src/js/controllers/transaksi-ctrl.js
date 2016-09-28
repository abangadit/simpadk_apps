/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('TransaksiService', function () {

    })
	.controller('TransaksiCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$uibModal','TransaksiService', function ($timeout,$rootScope,$scope,$http,$state,$uibModal,$log,MerkService) {
		$scope.sample_item = ['1','2','3','4','5','6','7','8','9','10'];
		var page = 1;
		$scope.cart = [];
		$scope.items = ['item1', 'item2', 'item3'];
		$scope.animationsEnabled = true;


		$rootScope.isLoading = true;
		$http.get(base_url+"api/"+api_key+"/products/0/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			
			console.log(response);
			$scope.data_product = response.data;
		});

		$scope.order_popup = function(size,id,name){
			var modalInstance = $uibModal.open({
		        templateUrl: 'templates/myModalContent.html',
		        size: size,
		        resolve: {
		            items: function () {
		                return $scope.items;
		            }
		        }
		    });

		    modalInstance.result.then(function (selectedItem) {
		        $scope.selected = selectedItem;
		    }, function () {
		        $log.info('Modal dismissed at: ' + new Date());
		    });
		}

		$scope.order = function(id,name){
			//alert(id);
			var lanjut = true;
			if($scope.cart.length>0){
				for(var i in $scope.cart){
					//if(lanjut===true){
					console.log($scope.cart[i].id +"==="+ id);
				    if($scope.cart[i].id === id){
			         	console.log("found "+id);
			         	$scope.cart[i].qty += 1; 
			         }else{
			         	console.log("belum ada bro");
			         	$scope.cart.push({
							id  : id,
							name: name,
							qty : 1
						});
			         }
					//}
				}
				console.log("lanjut "+lanjut);
			}else{
				$scope.cart.push({
					id  : id,
					name: name,
					qty : 1
				});
			}
			console.log($scope.cart);
		};
	}])
	.controller('ModalInstanceCtrl', ['$timeout','$rootScope','$scope', '$http','$state','$uibModal','TransaksiService', function ($timeout,$rootScope,$scope,$http,$state,$uibModal,$log,MerkService) {
		$scope.ok = function () {
			console.log("ok");
		    $uibModal.close();
		  };

		  $scope.cancel = function () {
			console.log("cancel");
		    $uibModal.dismiss('cancel');
		  };
	}])
;