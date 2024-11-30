<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="frm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa đơn của khách hàng</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chương trình giảm giá sản phẩm</title>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous"
    />
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    />
    <style>
        .container {
            display: flex;
            flex-wrap: wrap; /* Cho phép các phần tử con xuống dòng khi không đủ không gian */
        }

        .vertical-menu {
            display: flex;
            flex-direction: row;
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

        .vertical-menu a {
            text-decoration: none;
            color: black;
            font-size: 13px;
            font-weight: bold;
            margin-left: 20px;
            padding-left: 20px;
            padding-right: 20px;
            margin: 5px;
        }

        .container > div {
            width: 100%; /* Đảm bảo rằng nội dung chiếm toàn bộ chiều rộng khi xuống dòng */
            margin-top: 16px; /* Thêm khoảng trắng giữa menu và nội dung */
            padding: 16px;
        }
        .dachon{
            color: red !important;
        }

    </style>

</head>
<body>

<%@ include file="../../../templates/Admin/Layouts/GiayTheThao/_HeaderGiayTheThao.jsp" %>

<div class="container">

    <div class="vertical-menu" style="background-color: #bac8f3; font-size: 13px !important;">
        <a class="${param.trangthai == null?'dachon':''}" href="/BanHangTaiQuay/Admin/xacNhanDonHangKhachHangAll" style="color: black">Tất cả</a>
        <a class="${param.trangthai == 0?'dachon':''}" href="?trangthai=0" style="color: black">Chờ xác nhận</a>
        <a class="${param.trangthai == 1?'dachon':''}" href="?trangthai=1" style="">Đã xác nhận</a>
        <a class="${param.trangthai == 2?'dachon':''}"  href="?trangthai=2"> Đã gửi</a>
        <a class="${param.trangthai == 3?'dachon':''}"  href="?trangthai=3"> Đã nhận hàng</a>
        <a class="${param.trangthai == 4?'dachon':''}"  href="?trangthai=4"> Đã hủy</a>
        <a class="${param.trangthai == 5?'dachon':''}"  href="?trangthai=5"> Không nhận hàng</a>
    </div>

   <br>
    <div style="overflow-x: auto;width: 100%">
            <table class="table table-striped;" style="border-radius: 10px 10px 10px">
                <tr>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Mã hóa đơn</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 200px">Khách hàng</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 260px">Ngày thanh toán</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 200px">Tổng tiền</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;text-align: center;background-color: #bac8f3;width:300px">Thông tin nhận hàng</td>
<%--                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;text-align: center;background-color: #bac8f3;width: 300px">Ghi chú</td>--%>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Hình thức</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Loại</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Trạng thái</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Functions</td>
                    <td scope="col" style="color: black;font-weight: bold;font-size: 17px;background-color: #bac8f3;width: 130px">Cập nhật trạng thái</td>

                </tr>
                <c:forEach items="${listHoaDon}" var="list">
                    <tr>

                        <td style="font-size: 14px;color: black;font-weight: bold">${list.maHoaDon}</td>
                        <td style="font-size: 14px;color: black;font-weight: bold">${list.khachHang.tenKhachHang}</td>
                        <td style="font-size: 14px;color: black;font-weight: bold">
                            <c:set var="dateTimeString" value="${list.ngayThanhToan}"/>
                            <fmt:parseDate value="${dateTimeString}" var="parsedDate"
                                           pattern="yyyy-MM-dd'T'HH:mm:ss"/>
                            <fmt:formatDate value="${parsedDate}" var="formattedDate"
                                            pattern="yyyy-MM-dd HH:mm:ss"/>
                            ${formattedDate}
                        </td>
                        <td style="font-size: 14px;color: black;font-weight: bold">
                            <fmt:formatNumber type="" value="${list.thanhTien}" pattern="#,##0.###" /> VNĐ
                        </td>
                        <td style="font-size: 14px;color: black;font-weight: bold">${list.ghiChu}</td>
<%--                        <td style="font-size: 14px; color: black; font-weight: bold">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${not empty list.mess}">${list.mess}</c:when>--%>
<%--                                <c:otherwise>N/A</c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </td>--%>
                        <td style="font-size: 14px;color: black;font-weight: bold">${list.hinhThuc == 1 ? "Tại quầy" : "Online"}</td>
                        <td style="font-size: 14px;color: black;font-weight: bold">${list.trangThaiMoney == 1 ? "Đã thanh toán" : "Chưa thanh toán"}</td>
                        <td style="font-size: 14px;color: black;font-weight: bold">
                                <c:choose>
                                    <c:when test="${list.trangThai == 0}">
                                        Chờ xác nhận
                                    </c:when>
                                    <c:when test="${list.trangThai == 1}">
                                        Đã xác nhận
                                    </c:when>
                                    <c:when test="${list.trangThai == 2}">
                                        Đã được gửi đi
                                    </c:when>
                                    <c:when test="${list.trangThai == 3}">
                                        Đã nhận được hàng
                                    </c:when>
                                    <c:when test="${list.trangThai == 4}">
                                        Đã hủy
                                    </c:when>
                                    <c:when test="${list.trangThai == 5}">
                                        Không nhận hàng
                                    </c:when>
                                    <c:otherwise>
                                        Trạng thái không xác định
                                    </c:otherwise>
                                </c:choose>
                        </td>
                         <td style="font-size: 14px;color: black;font-weight: bold">
                             <form target="_blank" method="post" action="/HoaDon/Admin/TrangThaiDonHangAllView">
                                <button type="submit" name="selectedIdHoaDon" value="${list.id}" class="btn btn-primary">Views</button>
                             </form>
                         </td>
                        <td style="">
                            <c:if test="${list.trangThai == 0 || list.trangThai == 1 || list.trangThai == 2}">
                                <form method="post" action="/BanHangTaiQuay/capnhattrangthai">
                                    <button type="submit" name="idhoadon" value="${list.id}" class="btn btn-primary">Cập nhật</button>
                                </form>
                            </c:if>
                            <c:if test="${list.trangThai == 0 || list.trangThai == 1 || list.trangThai == 2}">
                            <form method="post" action="/BanHangTaiQuay/huyDon">
                                <button name="idhoadon" value="${list.id}" class="btn btn-danger">Hủy</button>
                            </form>
                            </c:if>
                            <c:if test="${list.trangThai == 2}">
                                <form method="post" action="/BanHangTaiQuay/khongNhanHang">
                                    <button name="idhoadon" value="${list.id}" class="btn btn-danger">Không nhận hàng</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        <%@ include file="../../../templates/Admin/Layouts/GiayTheThao/_FooterGiayTheThao.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
        <script src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/js/toastr.min.js"></script>
        <c:if test="${message != null}">
            <script>
                toastr.success("${message}");
            </script>
        </c:if>
    </div>

</div>

</body>
</html>
