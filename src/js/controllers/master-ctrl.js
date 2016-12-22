/**
 * Master Controller
 */
var base_url = "http://localhost:3000/";
var base_url_main = "http://localhost:6699/";
var api_key = "c89ba5b91d1ed6642892ffa04716bc2a76118831ee"; //api key sementara (belum ada login)

angular.module('RDash')
    .controller('MasterCtrl', ['$rootScope','$scope', '$cookieStore', '$http', MasterCtrl]);

function MasterCtrl($rootScope,$scope, $cookieStore) {
    /**
     * Sidebar Toggle & Cookie Control
     */
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
}
