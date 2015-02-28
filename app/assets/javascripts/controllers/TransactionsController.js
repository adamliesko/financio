var app = angular.module('financio');
app.controller('InvoicesCtrl', ['$scope', '$resource', '$location', 'ngTableParams', '$filter', 'InvoicesFactory','InvoiceLinesFactory', '$q','$timeout','$compile', function ($scope, $resource, $location, ngTableParams, $filter, InvoicesFactory,InvoiceLinesFactory,$timeout,$compile) {


    var agendaId = $location.path().split('/').pop();
    var preSelection = null;
    $scope.loading=false;

    $scope.result = 0;
    $scope.resource = { rows:[{}],header: [{sharp: '#', description: 'Description', quantity: 'Quantity',
        unit_price: 'Unit price', vat: 'VAT', cost: 'Cost'}]};


    $scope.getTotal = function(){
        var totalCost = _.reduce($scope.selectedInvoice.invoice_lines, function(memo, num){ return memo + num.invoice_line.cost; }, 0);
        var totalGain = _.reduce($scope.selectedInvoice.invoice_lines, function(memo, num){ return memo + (num.invoice_line.quantity*num.invoice_line.unit_price); }, 0);

        $scope.result = totalGain-totalCost;

    };

    $scope.changeSelection = function (item) {

        if (preSelection) {
            preSelection.$selected = false;
        }
        if (preSelection == item) {
            item.$selected = false;
            preSelection = null;
        } else {
            item.$selected = true;
            preSelection = item;
            $scope.invoice = item;
            InvoicesFactory.get({agenda_id: agendaId, id: $scope.invoice.id}).$promise.then(function (data) {
                $scope.selectedInvoice = data.invoice;
                $scope.getTotal();

            });
            $scope.invoiceDetails();

        }


    };

    $scope.getInvoices = function () {
        $scope.invoices = InvoicesFactory.query({agenda_id: agendaId});

        $scope.invoices.$promise.then(function (data) {

            $scope.invoiceTable = new ngTableParams({
                page: 1,            // show first page
                count: 10,          // count per page
                sorting: {
                    number: 'asc'     // initial sorting
                }
            }, {
                total: $scope.invoices.length, // length of data
                filterDelay: 100,
                getData: function ($defer, params) {
                    var filteredData = params.filter() ?
                        $filter('filter')(data, params.filter()) :
                        data;
                    var orderedData = params.sorting() ?
                        $filter('orderBy')(filteredData, params.orderBy()) :
                        data;
                    params.total(orderedData.length);
                    $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
                }
            });
        })
    };


    $scope.updateInvoice = function(invoice_line) {
        InvoiceLinesFactory.update({id: invoice_line.invoice_line.id},invoice_line.invoice_line);
        $scope.getTotal();
    };


    $scope.invoiceDetails = function () {
        $scope['invoiceDetailsTable'] = undefined;
        $scope.selectedInvoice = InvoicesFactory.get({agenda_id: agendaId, id: $scope.invoice.id})

        $scope.selectedInvoice.$promise.then(function (data) {


            var data = $scope.selectedInvoice.invoice_lines;

            $scope['invoiceDetailsTable'] = new ngTableParams({
                page: 1,            // show first page
                count: 10
            }, {
                total: data.length, // length of data
                getData: function ($defer, params) {
                    var filteredData = params.filter() ?
                        $filter('filter')(data, params.filter()) :
                        data;
                    var orderedData = params.sorting() ?
                        $filter('orderBy')(filteredData, params.orderBy()) :
                        data;
                    $timeout(function() {
                    params.total(orderedData.length);
                    $defer.resolve(orderedData.slice((params.page() - 1) * params.count(), params.page() * params.count()));
                    }, 500);
                }
            });
        })
        $('#invoice-details .sortable').click();

        $scope.getTotal();
    };


    $scope.getInvoices();


}]);
