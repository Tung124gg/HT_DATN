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
                                    <span class="h-8 w-8 text-center p rounded-full bg-gray-300 text-white mr-2">2</span>
                                    <span class="text-gray-300">Thanh toán</span>
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
    <div class="w-[80%] mx-auto grid grid-cols-12 mt-12 gap-4">
        <div class="col-span-9">
            <h2 class="font-bold text-xl uppercase">Giỏ hàng của bạn</h2>
            <span id="total-quantity">${gioHang.size()}</span> <span>sản phẩm</span>
            <div class="overflow-x-auto">
                <table class="table">
                    <!-- head -->
                    <thead>
                    <tr>
                        <th>
                            <label>
<%--                                <input type="checkbox" class="checkbox" />--%>
                            </label>
                        </th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${gioHang}" var="item">
                        <!-- row 1 -->
                        <tr class="gio-hang">
                            <th>
                                <label>
                                    <input onchange="checkSelected(${item.giayTheThaoChiTiet.giayTheThao.giaBan},${item.soLuong} , this)" form="formtt" name="giohangchitiet" value="${item.id}" type="checkbox" class="checkbox" />
                                </label>
                            </th>
                            <td>
                                <div class="flex items-center gap-3">
                                    <div class="avatar">
                                        <div class="mask mask-squircle h-12 w-12">
                                            <img
                                                    src="/upload/${item.giayTheThaoChiTiet.giayTheThao.getAnhDau()}"
                                                    alt="Avatar Tailwind CSS Component" />
                                        </div>
                                    </div>
                                    <div>
                                        <div class="font-bold">${item.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}</div>
                                        <div class="text-sm opacity-50 flex justify-between items-center gap-4">
                                            <span>Kích thước: ${item.giayTheThaoChiTiet.size.size}</span>
                                            <span class="inline-block text-yellow-300 my-2 w-6 h-[1px] bg-yellow-300"></span>
                                            <span>Màu sắc: ${item.giayTheThaoChiTiet.mauSac.tenMauSac}</span>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                            <td>
                                <span class="column-don-gia">
                                    <fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true" maxFractionDigits="0" /> VND
                                </span>
                            </td>


                            <td>
                                <span>x</span>
                                <span class="column-so-luong">${item.soLuong}</span>
                            </td>
                            <th>
                                <button data-id = "${item.id}" onclick="handleRemoveCart(this)" class="btn btn-outline btn-error">Xóa</button>
                            </th>
                        </tr>
                        <c:set var="totalAmount" value="${totalAmount + item.donGia * item.soLuong}" />
                        <c:set var="totalQuantity" value="${totalQuantity + item.soLuong}" />
                    </c:forEach>

                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-span-3 flex flex-col gap-6">
            <h2 class="font-bold text-xl uppercase">Thêm voucher</h2>
            <h3>Dùng mã vourcher ngay</h3>
            <form id="formtt" onsubmit="return checkSoluong()" action="${pageContext.request.contextPath}/thanh-toan/32">
                <select name="voucher" class="select select-accent w-full max-w-xs" onchange="handleChangeVoucher()">
                    <option disabled selected>Chọn vourcher</option>
                    <c:forEach items="${chuongTrinhGiamGiaHoaDon}" var="voucher">
                        <option value="${voucher.id}" data-value = "${voucher.phanTramGiam}">${voucher.tenChuongTrinh}</option>
                    </c:forEach>
                </select>
            </form>
            <div class="flex justify-between">
                <p >Tạm tính</p>
                <div>
                    <span id="total-amount">0 </span> <span>VND</span>
                </div>
            </div>
            <div class="flex justify-between">
                <p >Phần trăm giảm</p>
                <div>
                    <span id="voucher-percentage">0 </span> <span>%</span>
                </div>
            </div>
            <div class="flex justify-between border-b pb-4">
                <p>Giảm giá</p>
                <p>
                    <span id="voucher-value">0</span> <span>VND</span>
                </p>
            </div>
            <div class="flex justify-between">
                <p>Tổng thanh toán</p>
                <p>
                    <span id="total-amount-after">0</span> <span>VND</span>
                    <input type="hidden" id="tongtien" value="0"/>
                </p>
            </div>
            <button form="formtt" class="btn text-white bg-orange-500 w-full">Mua hàng</button>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.2/js/toastr.min.js"></script>
<script>
    function formatCurrency(amount) {
        // Định dạng số tiền theo chuẩn Việt Nam (dùng VND)
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }

    function checkSelected(giaBan, soluong, e) {
        console.log("Giá bán:", giaBan);
        console.log("Số lượng:", soluong);

        // Lấy giá trị tổng tiền hiện tại và chuyển đổi về dạng số
        let tongtien = parseFloat(document.getElementById("tongtien").value.replace(/[^0-9.-]+/g, "")) || 0;

        // Tính toán tổng tiền
        const thayDoi = parseFloat(giaBan) * parseFloat(soluong);
        if (!e.checked) {
            tongtien -= thayDoi; // Trừ giá trị nếu không được chọn
        } else {
            tongtien += thayDoi; // Cộng giá trị nếu được chọn
        }

        // Đảm bảo giữ chính xác số thập phân (2 chữ số)
        tongtien = tongtien.toFixed(2);

        // Cập nhật giá trị vào các phần tử giao diện
        document.getElementById("tongtien").value = tongtien; // Giá trị gốc
        document.getElementById("total-amount").innerHTML = formatCurrency(tongtien); // Hiển thị định dạng
        document.getElementById("total-amount-after").innerHTML = formatCurrency(tongtien); // Hiển thị định dạng

        // Gọi hàm xử lý voucher
        handleChangeVoucher();
    }

    // function formatCurrency(amount) {
    //     return new Intl.NumberFormat('vi-VN').format(amount); // Định dạng theo chuẩn Việt Nam (dấu phân cách là dấu ".")
    // }
    // function checkSelected(giaBan, soluong, e) {
    //     console.log(giaBan);
    //     console.log(soluong);
    //
    //     // Lấy giá trị tổng tiền
    //     var tongtien = document.getElementById("tongtien").value;
    //
    //     if (e.checked == false) {
    //         tongtien = Number(tongtien) - (Number(giaBan) * Number(soluong));
    //     } else {
    //         tongtien = Number(tongtien) + (Number(giaBan) * Number(soluong));
    //     }
    //
    //     // Cập nhật giá trị vào các phần tử và định dạng
    //     document.getElementById("tongtien").value = tongtien;
    //     document.getElementById("total-amount").innerHTML = formatCurrency(tongtien);  // Định dạng số tiền
    //     document.getElementById("total-amount-after").innerHTML = formatCurrency(tongtien); // Định dạng số tiền
    //
    //     handleChangeVoucher();  // Gọi lại hàm xử lý voucher
    // }
    function handleChangeVoucher() {
        const select = document.querySelector('select');
        const totalAmount = document.querySelector('#total-amount');
        const totalAmountAfter = document.querySelector('#total-amount-after');
        const voucherValue = document.querySelector('#voucher-value');
        const voucherPercentage = document.querySelector('#voucher-percentage');
        const value = select.options[select.selectedIndex].getAttribute('data-value'); // Lấy giá trị phần trăm giảm giá

        const valueVoucher = parseInt(totalAmount.textContent.replace(/\./g, '')) * value / 100;  // Xử lý số đã được format

        totalAmountAfter.innerHTML = formatCurrency(parseInt(totalAmount.textContent.replace(/\./g, '')) - valueVoucher);  // Định dạng lại
        voucherValue.innerHTML = formatCurrency(valueVoucher);  // Định dạng lại giá trị voucher
        voucherPercentage.innerHTML = value;
    }

    // function checkSelected(giaBan, soluong, e){
    //     console.log(giaBan)
    //     console.log(soluong)
    //     var tongtien = document.getElementById("tongtien").value
    //     if(e.checked == false){
    //         tongtien = Number(tongtien) - Number(giaBan) * Number(soluong)
    //     }
    //     else{
    //         tongtien = Number(tongtien) + Number(giaBan) * Number(soluong)
    //     }
    //     document.getElementById("tongtien").value = tongtien
    //     document.getElementById("total-amount").innerHTML = tongtien
    //     document.getElementById("total-amount-after").innerHTML = tongtien
    //     handleChangeVoucher();
    // }

    // function handleChangeVoucher() {
    //     const select = document.querySelector('select');
    //     const totalAmount = document.querySelector('#total-amount');
    //     const totalAmountAfter = document.querySelector('#total-amount-after');
    //     const voucherValue = document.querySelector('#voucher-value');
    //     const voucherPercentage = document.querySelector('#voucher-percentage'); // Phần tử hiển thị %
    //     const value = select.options[select.selectedIndex].getAttribute('data-value');
    //
    //     const valueVoucher = parseInt(totalAmount.textContent) * value / 100;
    //
    //     totalAmountAfter.innerHTML = parseInt(totalAmount.textContent) - valueVoucher;
    //     voucherValue.innerHTML = valueVoucher;
    //     voucherPercentage.innerHTML =value;
    //
    // }



    function handleRemoveCart(e) {
        const itemId = e.getAttribute('data-id');
        window.location.href = `http://localhost:8080/gio-hang/delete/` + itemId;
        totalAmount.innerHTML = totalAmountValue;
        size.innerHTML = parseInt(size.textContent) - 1;
        totalAmountAfter.innerHTML = totalAmountValue - parseInt(voucherValue.textContent);

    }

    function checkSoluong(){
        const checkboxes = document.querySelectorAll('input[name="giohangchitiet"]:checked');

        // Kiểm tra nếu có ít nhất một checkbox được chọn
        if (checkboxes.length > 0) {
            return true;
        } else {
            toastr.warning("Hãy chọn ít nhất 1 sản phẩm")
            return false;
        }
    }
</script>
</body>
</html>
