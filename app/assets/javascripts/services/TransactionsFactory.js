var app = angular.module('financio');

app.factory('TransactionsFactory', ['$resource',function ($resource) {
    return $resource('account_transactions/:id', {id:'@id'}, {
        query: { method: 'GET', isArray: true  }
    })
}]);

