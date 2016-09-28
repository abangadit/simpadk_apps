/**
 * Master Controller
 */
var base_url = "http://localhost:3000/";
var api_key = "d19ea5b21a429e672e9bffa04114bb2f7616"; //api key sementara (belum ada login)

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