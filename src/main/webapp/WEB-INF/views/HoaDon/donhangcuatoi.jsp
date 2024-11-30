<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <title>User</title>
</head>
<body>
<%@ include file="../templates/header.jsp" %>
<div class="mt-8">
    <div class="border-b">
        <div class="w-[80%] mx-auto">
            <div class="grid grid-cols-2 pb-4">
                <div class="text-2xl font-bold">Đơn hàng của tôi</div>
            </div>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Giảm giá</th>
                        <th>Trạng thái </th>
<%--                        <th>Loại thanh toán</th>--%>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listHoaDon}" var="hd">
                        <tr>
                            <td>${hd.maHoaDon}</td>
                            <td>${hd.ngayTao}</td>q
                            <td class="moneyFm">${hd.thanhTien}</td>
                            <td>${hd.chuongTrinhGiamGiaHoaDon == null ? '0':hd.chuongTrinhGiamGiaHoaDon.phanTramGiam}%</td>
<%--                            <td>${hd.hinhThuc == 0 ? 'thanh toán khi nhân hàng' : 'Thanh toán VNPAY'}</td>--%>
                               <td> ${hd.trangThaiMoney == 0 ? 'thanh toán khi nhân hàng' : 'Thanh toán VNPAY'}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/js/toastr.min.js"></script>
<c:if test="${dathangthanhcong != null}">
    <script>
        toastr.success("Đặt hàng thành công")
    </script>
</c:if>
</body>
<script>
    var moneyFm = document.getElementsByClassName("moneyFm");
    for(var i=0; i< moneyFm.length; i++){
        moneyFm[i].innerHTML = formatmoney(moneyFm[i].textContent)
    }
    function formatmoney(money) {
        const VND = new Intl.NumberFormat('vi-VN', {
            style: 'currency',
            currency: 'VND',
        });
        return VND.format(money);
    }
</script>
</html>
