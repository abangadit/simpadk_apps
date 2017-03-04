/**
 * Master Controller
 */
var base_url = "http://localhost:3000/";
var base_url_main = "http://localhost:6699/";
//var api_key = "c89ba5b91d1ed6642892fea1431cba28731680"; //api key sementara (belum ada login)
var api_key;

angular.module('RDash')
    .controller('MasterCtrl', ['$rootScope','$scope', '$cookieStore', '$http','$timeout', MasterCtrl]);

function MasterCtrl($rootScope,$scope,$cookieStore,$http,$timeout) {
    $scope.postData = {};
    $scope.isLogin = window.localStorage['isLogin'];
    $scope.user_nama = window.localStorage['user_nama'];
    $scope.user_level = window.localStorage['user_level'];
    $scope.expired_date = window.localStorage['expired_date'];
    $scope.apikey = window.localStorage['apikey'];
    $scope.isLogin = window.localStorage['isLogin'];

    api_key = window.localStorage['apikey'];


    $rootScope.isLoading = false;
    var mobileView = 992;

    $scope.getWidth = function() {
        return window.innerWidth;
    };

    $scope.$watch($scope.getWidth, function(newValue, oldValue) {
        if (newValue >= mobileView) {
            if (angular.isDefined($cookieStore.get('toggle'))) {
                $scope.toggle = ! $cookieStore.get('toggle') ? false : true;
            } else {
                $scope.toggle = true;
            }
        } else {
            $scope.toggle = false;
        }

    });

    $scope.toggleSidebar = function() {
        $scope.toggle = !$scope.toggle;
        $cookieStore.put('toggle', $scope.toggle);
    };

    window.onresize = function() {
        $scope.$apply();
    };













    $scope.submitLogin = function (){
      $rootScope.isLoading = true;
      var link = base_url+"login";
      console.log(link);
      $http({
				method: 'POST',
				headers  : { 'Content-Type': 'application/x-www-form-urlencoded' },
        url 	 : link,
				data 	 : {
					user_nama:$scope.postData.username,
					password:$scope.postData.password,
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
          if(response.data=="Invalid user/password"){
            alert(response.data);
          }else{
            alert($scope.user_level);
            //user level 1 = administrator, 2 = penjaga toko, 3 = marketing / pemilik toko
            $scope.isLogin = true;
            window.localStorage['isLogin'] = true;
            window.localStorage['user_nama'] = $scope.postData.username;
            window.localStorage['apikey'] = response.data[0].apikey;
            window.localStorage['user_level'] = response.data[0].user_level;
            window.localStorage['expired_date'] = response.data[0].expired_date;

            $scope.user_nama = window.localStorage['user_nama'];
            $scope.user_level = window.localStorage['user_level'];
            $scope.expired_date = window.localStorage['expired_date'];
            $scope.apikey = window.localStorage['apikey'];
            $scope.isLogin = window.localStorage['isLogin'];

            $scope.isAdmin = false;
            $scope.isKasir = false;
            $scope.isMarketing = false;

            if($scope.user_level==1){
              $scope.isAdmin = true;
            }
            if($scope.user_level==2){
              $scope.isKasir = true;
            }
            if($scope.user_level==3){
              $scope.isMarketing = true;
            }


            api_key = window.localStorage['apikey'];
          }


			  }, function errorCallback(response) {
			    $timeout( function(){
	        	$rootScope.isLoading = false;
		      }, 1000);
		      alert("Terjadi Kesalahan, Ulangi ");
			  });

		};

    $scope.logout = function(){
        $scope.isLogin = false;
        localStorage.clear();
    }

}
