var app = angular.module('financio');
app.controller('TransactionsCtrl', ['$scope', '$resource', '$location', '$timeout', 'ngTableParams', '$filter', 'TransactionsFactory', function ($scope, $resource, $location, $timeout, ngTableParams, $filter, TransactionsFactory) {

    $scope.parent = {dateFrom: '', dateTo: ''};

    $scope.init = function (id) {
        $scope.accountId = id;
        $scope.getTransactions();
    };

    $scope.loadData = function () {
        $scope.getTransactions();

    };

    $scope.loading = false;

    $scope.getTransactions = function () {
        $scope.transactions = TransactionsFactory.query({
            account_id: $scope.accountId,
            date_from: $scope.parent.dateFrom,
            date_to: $scope.parent.dateTo
        });

        $scope.transactions.$promise.then(function (data) {
            $scope.transactionsTable = new ngTableParams({
                page: 1,            // show first page
                count: 10,          // count per page
                sorting: {
                    number: 'id'     // initial sorting
                }
            }, {
                total: data.length, // length of data
                filterDelay: 100,
                getData: function ($defer, params) {
                    var filteredData = params.filter() ?
                        $filter('filter')(data, params.filter()) :
                        data;
                    var orderedData = params.sorting() ?
                        $filter('orderBy')(filteredData, params.orderBy()) :
                        data;
                    $timeout(function () {
                        params.total(orderedData.length);
                        $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
                    }, 50);
                }
            });
        })
        $('.sortable').click();
        $scope.transactionsTable.reload();
    };


}]);
