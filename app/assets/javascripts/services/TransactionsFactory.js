var app = angular.module('financio');

app.factory('TransactionsFactory', ['$resource',function ($resource) {
    return $resource('accounts/:account_id/account_transactions/:id', {id:'@id',account_id:'@account_id'}, {
        query: { method: 'GET', isArray: true  }
    })
}]);

