'use strict';

/**
 * Route configuration for the RDash module.
 */
angular.module('RDash').config(['$stateProvider', '$urlRouterProvider',
    function($stateProvider, $urlRouterProvider) {

        // For unmatched routes
        $urlRouterProvider.otherwise('/');

        // Application routes
        $stateProvider
            .state('index', {
                url: '/',
                templateUrl: 'templates/dashboard.html'
            })
            .state('tables', {
                url: '/tables',
                templateUrl: 'templates/tables.html'
            })

            //TRANSAKSI
            .state('transaksi', {
                url: '/transaksi',
                templateUrl: 'templates/transaksi.html'
            })
            .state('transaksi_print', {
                url: '/transaksi_print',
                templateUrl: 'templates/modal_print.html'
            })

            //RESTOCK
            .state('restock', {
                url: '/restock',
                templateUrl: 'templates/restock.html'
            })

            //KAS
            .state('kas_masuk', {
                url: '/kas_masuk',
                templateUrl: 'templates/kas_masuk.html'
            })
            .state('kas_keluar', {
                url: '/kas_keluar',
                templateUrl: 'templates/kas_keluar.html'
            })


            //PRODUCT//
            .state('master_product', {
                url: '/master_product',
                templateUrl: 'templates/master_product.html'
            })
            .state('detail_product', {
                url: '/detail_product',
                templateUrl: 'templates/detail_product.html'
            })
            .state('add_product', {
                url: '/add_product',
                templateUrl: 'templates/add_product.html'
            })

            //MERK
            .state('master_merk', {
                url: '/master_merk',
                templateUrl: 'templates/master_merk.html'
            })
            .state('detail_merk', {
                url: '/detail_merk',
                templateUrl: 'templates/detail_merk.html'
            })
            .state('add_merk', {
                url: '/add_merk',
                templateUrl: 'templates/add_merk.html'
            })

            //CUSTOMER
            .state('master_customer', {
                url: '/master_customer',
                templateUrl: 'templates/master_customer.html'
            })
            .state('detail_customer', {
                url: '/detail_customer',
                templateUrl: 'templates/detail_customer.html'
            })
            .state('harga_customer', {
                url: '/harga_customer',
                templateUrl: 'templates/harga_customer.html'
            })
            .state('add_harga_customer', {
                url: '/add_harga_customer',
                templateUrl: 'templates/add_harga_customer.html'
            })
            .state('detail_harga_customer', {
                url: '/detail_harga_customer',
                templateUrl: 'templates/detail_harga_customer.html' 
            })
            .state('add_customer', {
                url: '/add_customer',
                templateUrl: 'templates/add_customer.html'
            })
            .state('add_customerprices', {
                url: '/add_customerprices',
                templateUrl: 'templates/add_customerprices.html'
            })


            //SATUAN
            .state('master_satuan', {
                url: '/master_satuan',
                templateUrl: 'templates/master_satuan.html'
            })
            .state('detail_satuan', {
                url: '/detail_satuan',
                templateUrl: 'templates/detail_satuan.html'
            })
            .state('add_satuan', {
                url: '/add_satuan',
                templateUrl: 'templates/add_satuan.html'
            })
            //USER
            .state('master_user', {
                url: '/master_user',
                templateUrl: 'templates/master_user.html'
            })
            .state('detail_user', {
                url: '/detail_user',
                templateUrl: 'templates/detail_user.html'
            })
            .state('add_user', {
                url: '/add_user',
                templateUrl: 'templates/add_user.html'
            })
            //SUPPLIER
            .state('master_supplier', {
                url: '/master_supplier',
                templateUrl: 'templates/master_supplier.html'
            })
            .state('detail_supplier', {
                url: '/detail_supplier',
                templateUrl: 'templates/detail_supplier.html'
            })
            .state('add_supplier', {
                url: '/add_supplier',
                templateUrl: 'templates/add_supplier.html'
            })

            //LAPORAN
            .state('laporan', {
                url: '/laporan',
                templateUrl: 'templates/laporan.html'
            })
            ;
    }
]);
