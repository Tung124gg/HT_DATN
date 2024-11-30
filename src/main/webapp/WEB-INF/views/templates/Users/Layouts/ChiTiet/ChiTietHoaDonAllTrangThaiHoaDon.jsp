<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="frm"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết hóa đơn của all trạng thái hơn đơn</title>
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 60%;
            position: relative;
        }

        .close {
            color: #aaa;
            position: absolute;
            top: 0;
            right: 0;
            font-size: 28px;
            font-weight: bold;
            padding: 10px;
            cursor: pointer;
            z-index: 2; /* Thêm dòng này để đẩy lên trên form */
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>

</head>
<body>
<%@ include file="../../../../templates/Admin/Layouts/GiayTheThao/_HeaderGiayTheThao.jsp" %>
<div class="container" style="margin-top: 50px">

    <div class="back">

        <a href="/BanHangTaiQuay/Admin/xacNhanDonHangKhachHangAll">
            <button class="btn btn-primary">Back</button>
        </a>

    </div>

    <div class="row" style="margin-top: 20px">
        <div class="col-12" style="">

            <div class="row">
                <%--        Trạng thái đơn hàng--%>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="font-size: 14px">
                                        Trạng thái đơn hàng
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="margin-top: 17px;font-size: 17px">
                                        <c:choose>
                                            <c:when test="${trangThaiView == 0}">chờ xác nhận </c:when>
                                            <c:when test="${trangThaiView == 1}">đã nhận hàng</c:when>
                                            <c:when test="${trangThaiView == 2}">đã gửi</c:when>
                                            <c:when test="${trangThaiView == 3}">đã nhận hàng </c:when>
                                            <c:when test="${trangThaiView == 4}">đã hủy</c:when>
                                            <c:when test="${trangThaiView == 5}">không nhận hàng</c:when>
                                            <c:otherwise>Trạng thái không xác định</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <%--                                        <i class="fa fa-shopping-cart fa-2x text-gray-300"></i>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--        Trạng thái thanh toán--%>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="font-size: 14px">
                                        Trạng thái thanh toán
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="margin-top: 17px;font-size: 17px">
                                        ${trangThaiMoney == 1 ? "Đã thanh toán " : "Chưa thanh toán"}
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <%--                                        <i class="fa fa-shopping-cart fa-2x text-gray-300"></i>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--        Hình thức thanh toán--%>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="font-size: 14px">
                                        Hình thức thanh toán
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="margin-top: 17px;font-size: 17px">
                                        ${hinhThucView == 0 ? "Online" : "Tại quầy"}
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <%--                                        <i class="fa fa-shopping-cart fa-2x text-gray-300"></i>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--        Loại hình thức thanh toán--%>
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1" style="font-size: 14px">
                                        Loại hình thức thanh toán
                                    </div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800" style="margin-top: 17px;font-size: 17px">
                                        <c:choose>
                                            <c:when test="${hinhThucThanhToan == 0}">Online</c:when>
                                            <c:when test="${hinhThucThanhToan == 1}">tại quầy </c:when>
<%--                                            <c:when test="${hinhThucThanhToan == 2}">Momo</c:when>--%>
                                            <c:when test="${hinhThucThanhToan == 3}">Nhận hàng</c:when>
                                            <c:otherwise>Trạng thái không xác định</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <%--                                        <i class="fa fa-shopping-cart fa-2x text-gray-300"></i>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h3 style="color: black;text-align: center;margin-bottom: 30px">Lịch sử cập nhật trạng thái</h3>

    <table class="table table-striped;" style="border-radius: 10px 10px 10px">
        <tr>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Ngày cập nhật</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 200px">Trạng thái</td>
        </tr>
        <tr>
            <td style="font-size: 14px;color: black;font-weight: bold">${hoadonmd.ngayTao}</td>
            <td>Ngày đặt</td>
        </tr>
        <c:forEach items="${listtrangthai}" var="list" varStatus="i">
            <tr>
                <td style="font-size: 14px;color: black;font-weight: bold">${list.ngayCapNhat}</td>
                <c:choose>
                    <c:when test="${list.trangThai == 0}">
                        <td>Chờ xác nhận</td>
                    </c:when>
                    <c:when test="${list.trangThai == 1}">
                        <td>Đã xác nhận</td>
                    </c:when>
                    <c:when test="${list.trangThai == 2}">
                        <td>Đã được gửi đi</td>
                    </c:when>
                    <c:when test="${list.trangThai == 3}">
                        <td>Đã nhận được hàng</td>
                    </c:when>
                    <c:when test="${list.trangThai == 4}">
                        <td>Đã hủy</td>
                    </c:when>
                    <c:when test="${list.trangThai == 5}">
                        <td>Không nhận hàng</td>
                    </c:when>
                    <c:otherwise>
                        <td>Trạng thái không xác định</td>
                    </c:otherwise>
                </c:choose>
            </tr>
        </c:forEach>
    </table>
    <br>
    <h3 style="color: black;text-align: center;margin-bottom: 30px">Thông tin chi tiết hóa đơn</h3>

    <table class="table table-striped;" style="border-radius: 10px 10px 10px">
        <tr>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Mã hóa đơn</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 200px">Khách hàng</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 300px">Ngày thanh toán</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 170px">Tổng tiền</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 170px">Phí ship</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 300px">Thông tin nhận hàng</td>
            <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 210px;text-align: center">Ghi chú</td>
        </tr>
            <tr>
                <td style="font-size: 14px;color: black;font-weight: bold">${maHoaDonView}</td>
                <td style="font-size: 14px;color: black;font-weight: bold">${khachHangView}</td>

                <td style="font-size: 14px;color: black;font-weight: bold">
                    <c:set var="dateTimeString" value="${ngayThanhToanView}"/>
                    <fmt:parseDate value="${dateTimeString}" var="parsedDate"
                                   pattern="yyyy-MM-dd'T'HH:mm:ss"/>
                    <fmt:formatDate value="${parsedDate}" var="formattedDate"
                                    pattern="yyyy-MM-dd HH:mm:ss"/>
                    ${formattedDate}
                <td style="font-size: 14px;color: black;font-weight: bold">
                    <fmt:formatNumber type="" value="${tongTienView}" pattern="#,##0.###" /> VNĐ
                </td>
                <td style="font-size: 14px;color: black;font-weight: bold">
                    <fmt:formatNumber type="" value="${phiShipView}" pattern="#,##0.###" /> VNĐ
                </td>
                <td style="font-size: 14px;color: black;font-weight: bold">${thongTienNhanHangView}</td>
                <td style="font-size: 14px;color: black;font-weight: bold">${messView}</td>
            </tr>
    </table>

    <br>

    <h3 style="text-align: center;color: black;margin-bottom: 50px">Thông tin chi tiết sản phẩm</h3>
    <table style="width: 100%; border-collapse: collapse;">
        <thead>
        <tr>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">STT</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Tên Giày</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Size</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Màu Sắc</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Số Lượng</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Giá Bán</th>
            <th style="padding: 10px; text-align: left; color: black; font-size: 16px;">Hình Ảnh</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${hoaDonChiTiets}" var="list" varStatus="i">
            <tr>
                <td style="padding: 10px; color: black; font-size: 16px;">${i.index + 1}</td>
                <td style="padding: 10px; color: black; font-size: 16px;">${list.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}</td>
                <td style="padding: 10px; color: black; font-size: 16px;">${list.giayTheThaoChiTiet.size.size}</td>
                <td style="padding: 10px; color: black; font-size: 16px;">${list.giayTheThaoChiTiet.mauSac.tenMauSac}</td>
                <td style="padding: 10px; color: black; font-size: 16px;">${list.soLuong}</td>
                <td style="padding: 10px; color: black; font-size: 16px;">
                    <fmt:formatNumber type="number" value="${list.giayTheThaoChiTiet.giayTheThao.giaBan}" pattern="#,##0.###"/> VNĐ
                </td>
                <td style="padding: 10px; text-align: center;">
                    <img src="/upload/${list.giayTheThaoChiTiet.giayTheThao.image.get(0).link}" width="110px" style="border-radius: 10px;">
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div style="margin-bottom: 100px"></div>

</div>

</body>
</html>
