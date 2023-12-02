var app = angular.module('AppBanHang', []);
app.controller("HomeCtrl", function ($scope, $http) {
    $scope.ListProduct;
    $scope.loadProduct= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/get-by-top số lượng/6',
        }).then(function (response) {  
            debugger;
            $scope.ListProduct = response.data;  
        });
        
    };
    $scope.loadProduct();

    
    $scope.ListProduct1;
    $scope.loadProduct1= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/get-by-lh/LH003',
        }).then(function (response) {  
            debugger;
            $scope.ListProduct1 = response.data;  
        });
    };
    $scope.loadProduct1();

    $scope.ListProduct2;
    $scope.loadProduct2= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/get-by-lh/LH001',
        }).then(function (response) {  
            debugger;
            $scope.ListProduct2 = response.data;  
        });
        
    };
    $scope.loadProduct2();

    $scope.ListProduct3;
    $scope.loadProduct3= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/get-by-top mới nhất/6',
        }).then(function (response) {  
            debugger;
            $scope.ListProduct3 = response.data;  
        });
        
    };
    $scope.loadProduct3();

    $scope.ListAll;
    $scope.loadAll= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/getAllMatHang',
        }).then(function (response) {  
            debugger;
            $scope.ListAll = response.data;  
        });
        
    };
    $scope.loadAll();

    $scope.ListMin_Max;
    $scope.loadMinMax= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/getgiaBanMinMax',
        }).then(function (response) {  
            debugger;
            $scope.ListMin_Max= response.data;  
        });
        
    };
    $scope.loadMinMax();

    $scope.ListMax_Min;
    $scope.loadMaxMin= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/getgiaBanMaxMin',
        }).then(function (response) {  
            debugger;
            $scope.ListMax_Min= response.data;  
        });
        
    };
    $scope.loadMaxMin();
    
    $scope.ListGia200k;
    $scope.loadMaxMin= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/get-by-gia/200000',
        }).then(function (response) {  
            debugger;
            $scope.ListGia200k= response.data;  
        });
        
    };
    $scope.loadMaxMin();

    $scope.ListGia100k;
    $scope.loadMaxMin= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/getgiaBanduoi100k',
        }).then(function (response) {  
            debugger;
            $scope.ListGia100k= response.data;  
        });
        
    };
    $scope.loadMaxMin();

    $scope.ListGia100k_200k;
    $scope.loadMaxMin= function () {
        $http({
            method: 'GET',
            url: current_url + '/api/SanPhamSr/getgiaBan100k-200k',
        }).then(function (response) {  
            debugger;
            $scope.ListGia100k_200k= response.data;  
        });
        
    };
    $scope.loadMaxMin();

    $scope.ListAddSP;
    $scope.loadAddSP= function () {
        $http({
            method: 'GET',
            url: current_admin + '/api/SanPham/getAllMatHang',
        }).then(function (response) {  
            debugger;
            $scope.ListAddSP= response.data;  
        });
        
    };
    $scope.loadAddSP();

    
    
});

function XoaSanPham(mathang) {
    if (confirm("Bạn chắc chắn muốn xóa!")) {
        $http({
            method: 'DELETE',
            url: current_admin + '/api/SanPham/delete-sanpham/' + mathang,
        }).then(function (response) {
            debugger;
            // Yêu cầu xóa thành công, tải lại danh sách sản phẩm
            $scope.loaddelSP();
        });
    }
}