<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <title>User</title>
</head>
<body>
<%@ include file="../templates/header.jsp" %>
<div class="my-8">
    <div class="border-b">
        <div class="w-[80%] mx-auto">
            <div class="grid grid-cols-2 pb-4">
                <div class="text-2xl font-bold">Trạng thái đơn hàng</div>
                <div>
                    <div class="breadcrumbs text-sm">
                        <ul class="text-lg font-semibold">
                            <li class="text-yellow-300">
                                <a>
                                    <span class="h-8 w-8 text-center p rounded-full bg-yellow-500 text-white mr-2">1</span>
                                    Giỏ hàng
                                </a>
                            </li>
                            <li>
                                <a>
                                    <span class="h-8 w-8 text-center p rounded-full bg-yellow-500 text-white mr-2">2</span>
                                    <span class="text-yellow-500">Thanh toán</span>
                                </a>
                            </li>
                            <li>
                      <span class="inline-flex items-center gap-2">
                        <span class="h-8 w-8 text-center p rounded-full bg-gray-300 text-white mr-2">3</span>
                        <span class="text-gray-300">Đặt hàng thành công</span>
                      </span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="w-[80%] mx-auto grid grid-cols-2 mt-12 gap-8">
<%--        <div class="">--%>
<%--            <h2 class="font-bold text-xl uppercase">Thông báo</h2>--%>
<%--            <h3>Kiểm tra các mặt hàng một lần nữa trước khi thanh toán</h3>--%>
<%--            <div>--%>
<%--                <c:forEach items="${gioHangChiTiets}" var="item">--%>
<%--                    <div class="grid grid-cols-3 gap-2 py-4 border-b-2 border-dashed">--%>
<%--                        <img class="w-20 h-20" src="/upload/${item.giayTheThaoChiTiet.giayTheThao.getAnhDau()}">--%>
<%--                        <div class="col-span-2">--%>
<%--                            <p>Tên Sản Phẩm </p>--%>
<%--                            <p>${item.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}</p>--%>
<%--                            <p>Thương hiệu</p>--%>
<%--                            <p class="py-2">${item.giayTheThaoChiTiet.giayTheThao.thuongHieu.tenThuongHieu}</p>--%>
<%--                            <div class="flex justify-between" style="color: red">--%>
<%--                                <div class="text-xl">--%>
<%--                                    <fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true" /> VND--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>--%>

    <div class="bg-gray-50 shadow-lg rounded-lg p-8">
        <!-- Tiêu đề thông báo -->
        <h2 class="text-2xl font-extrabold uppercase text-gray-800 mb-6 border-b-2 border-gray-300 pb-2">
            Thông báo
        </h2>
        <h3 class="text-gray-600 text-lg mb-6">
            Vui lòng kiểm tra các mặt hàng trước khi thanh toán.
        </h3>

        <!-- Danh sách sản phẩm -->
        <div class="space-y-6">
            <c:forEach items="${gioHangChiTiets}" var="item">
                <!-- Mỗi sản phẩm -->
                <div class="grid grid-cols-12 gap-4 p-4 border rounded-lg bg-white shadow-sm hover:shadow-md transition-shadow">
                    <!-- Hình ảnh sản phẩm -->
                    <div class="col-span-3">
                        <img
                                class="w-full h-24 object-cover rounded-md border border-gray-200"
                                src="/upload/${item.giayTheThaoChiTiet.giayTheThao.getAnhDau()}"
                                alt="${item.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}">
                    </div>

                    <!-- Thông tin sản phẩm -->
                    <div class="col-span-9">
                        <!-- Tên sản phẩm -->
                        <p class="text-lg font-semibold text-gray-800 mb-1">
                                ${item.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}
                        </p>

                        <!-- Thương hiệu -->
                        <p class="text-sm text-gray-600 mb-3">
                            Thương hiệu:
                            <span class="font-medium text-gray-700">
                                    ${item.giayTheThaoChiTiet.giayTheThao.thuongHieu.tenThuongHieu}
                            </span>
                        </p>

                        <!-- Giá sản phẩm -->
                        <div class="flex justify-between items-center">
                            <span class="text-gray-500 text-sm">Giá:</span>
                            <span class="text-xl font-bold text-red-500">
                            <fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true" /> VND
                        </span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>



    <form action="/checkout" method="post" class=" flex flex-col gap-6">
            <c:if test="${voucher != null}">
                <h3>Khuyến mại giảm giá ${voucher.phanTramGiam} %</h3>
            </c:if>
            <h2 class="font-bold text-xl uppercase">Chi tiết thanh toán</h2>
            <h3>Thông tin nhận hàng</h3>
            <div class="grid grid-cols-2 gap-4">
                <div class="flex flex-col gap-8">
                    <select name="tinh" onchange="loadDistrict()" id="tinh" class="select select-bordered w-full max-w-xs">
                    </select>
                    <select name="huyen" onchange="loadWard()" id="huyen" class="select select-bordered w-full max-w-xs">
                    </select>
                    <select name="xa" id="xa" class="select select-bordered w-full max-w-xs">
                    </select>
                </div>
                <div class="flex flex-col gap-8">
                    <input name="tenduong" placeholder="Tên đường, số nhà"  class="input input-bordered w-full max-w-xs">
                    <textarea name="note" rows="6" placeholder="Ghi chú" class="input input-bordered w-full max-w-xs"></textarea>
                </div>
            </div>
            <p>Chon phuong thuc thanh toan</p>
            <div>
                <div class="flex mb-4">
                    <input id="radio-1" type="radio" value="cod" name="paytype" class="radio mr-4" checked="checked" />
                    <label for="radio-1">Thanh toan khi nhan hang</label>
                </div>
                <div class="flex ">
                    <input id="radio-2" type="radio" value="vnpay" name="paytype" class="radio  mr-4" />
                    <label for="radio-2">Thanh toán qua VNPAY</label>
                </div>
            </div>
            <button class="btn btn-wide">Thanh toan</button>
        </form>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/js/toastr.min.js"></script>
<c:if test="${error != null}">
    <script>
        toastr.error("${error}")
    </script>
</c:if>
<c:if test="${warning != null}">
    <script>
        toastr.error("${warning}")
    </script>
</c:if>
<script>
    window.onload = function (){
        loadProvince();
    }
    async function loadProvince(){
        var respon = await fetch('http://localhost:8080/api/shipping/public/province', {});
        var provinces = await respon.json();
        var main = '';
        for(var i=0; i< provinces.data.length; i++){
            main += '<option value="'+provinces.data[i].ProvinceID+'?'+provinces.data[i].ProvinceName+'">' + provinces.data[i].ProvinceName + '</option>'
        }
        document.getElementById("tinh").innerHTML = main;
        loadDistrict();
    }

    async function loadDistrict(){
        var provinceId = document.getElementById("tinh").value.split("?")[0]
        var respon = await fetch('http://localhost:8080/api/shipping/public/district?provinceId='+provinceId, {});
        var districts = await respon.json();
        var main = '';
        for(var i=0; i< districts.data.length; i++){
            main += '<option value="'+districts.data[i].DistrictID+'?'+districts.data[i].DistrictName+'">' + districts.data[i].DistrictName + '</option>'
        }
        document.getElementById("huyen").innerHTML = main;
        loadWard();
    }

    async function loadWard(){
        var districtId = document.getElementById("huyen").value.split("?")[0]
        var respon = await fetch('http://localhost:8080/api/shipping/public/wards?districtId='+districtId, {});
        var wards = await respon.json();
        var main = '';
        for(var i=0; i< wards.data.length; i++){
            main += '<option value="'+wards.data[i].WardName+'">' + wards.data[i].WardName + '</option>'
        }
        document.getElementById("xa").innerHTML = main;
    }
</script>
</body>
</html>
