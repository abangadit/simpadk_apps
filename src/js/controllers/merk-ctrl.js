/**
 * Alerts Controller
 */

angular
    .module('RDash')
    .service('MerkService', function () {

    })
	.controller('MerkCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		var page = 1;
		$scope.refreshBrand = function(){
			$rootScope.isLoading = true;
			$http.get(base_url+"api/"+api_key+"/brands/0/"+page)
			.then(function(response) {
				$timeout( function(){
					$rootScope.isLoading = false;
				}, 1000);
				
				console.log(response);
				$scope.data_merk = response.data;
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
		$scope.setpage=function(page_no){
			console.log("gotopage",page_no);
			page=page_no;
			$scope.refreshBrand();
			
		}
		$scope.detailMerk = function(id){
			MerkService.merks_id=id;
			$scope.merks_id = id;
			$state.go('detail_merk');
		};

		$scope.deleteMerk = function(id){
			var r = confirm("Anda yakin ingin menghapus data ini?");
			var del = false;
			if (r == true) {
				del=true;
			}
			if(del){
				$http({
					method: 'DELETE',
					headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
					url 	 : base_url+"api/"+api_key+"/brands/"+id+"/0"
				}).then(function successCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Data berhasil dihapus.");
					
					$state.go('master_merk');
					$scope.refreshBrand();
					}, function errorCallback(response) {
					$timeout( function(){
						$rootScope.isLoading = false;
					}, 1000);
					alert("Terjadi Kesalahan, Ulangi ");
				});
			}
			
		};

		$scope.refreshBrand();
	}])
	.controller('MerkDetailCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		var page = 1;
		$rootScope.isLoading = true;
		$scope.postData = {};
		
		$http.get(base_url+"api/"+api_key+"/brands/"+MerkService.merks_id+"/"+page)
		.then(function(response) {
			$timeout( function(){
        		$rootScope.isLoading = false;
	        }, 1000);
			console.log(response.data[0]);
			$scope.postData = response.data[0];
		});

		$scope.editMerk = function (){
			$rootScope.isLoading = true;
			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/brands",
				data 	 : {
					merk_id:parseInt($scope.postData.merk_id),
					merk_nama:$scope.postData.merk_nama,
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
				$state.go('master_merk');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])
	.controller('MerkAddCtrl', ['$timeout','$rootScope','$scope', '$http','$state','MerkService', function ($timeout,$rootScope,$scope,$http,$state,MerkService) {
		$scope.postData = {};
		//$rootScope.isLoading = true;
		//load merk dropdown
		
		$scope.submitMerk = function (){
			$rootScope.isLoading = true;

			$http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
				url 	 : base_url+"api/"+api_key+"/brands",
				data 	 : {
					merk_id:0,
					merk_nama:$scope.postData.merk_nama,
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
				$state.go('master_merk');

			  }, function errorCallback(response) {
			    $timeout( function(){
	        		$rootScope.isLoading = false;
		        }, 1000);
		        alert("Terjadi Kesalahan, Ulangi ");
			  });
		}
	}])


;
