var app = angular.module('financio');

app.factory('TransactionsFactory', ['$resource', function ($resource) {
    return $resource('/accounts/:account_id/account_transactions/:id', {
        id: '@id',
        date_from: '@dateFrom',
        date_to: '@dateTo'
    }, {
        query: {method: 'GET', isArray: true}
    })
}]);

