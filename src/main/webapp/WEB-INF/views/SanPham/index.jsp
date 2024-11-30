<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
    />

    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#da373d',
                    }
                }
            }
        }
    </script>
    <style>
        .swiper {
            width: 100%;
            height: 100%;
        }

        .swiper-slide {
            text-align: center;
            font-size: 18px;
            background: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .swiper-slide img {
            display: block;
            width: 70%;
            height: 70%;
            object-fit: cover;
        }

        input[type='number']::-webkit-inner-spin-button,
        input[type='number']::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        .custom-number-input input:focus {
            outline: none !important;
        }

        .custom-number-input button:focus {
            outline: none !important;
        }
    </style>
    <title>User</title>
</head>
<body>
<%@ include file="../templates/header.jsp" %>
<div class="w-[80%] mx-auto grid grid-cols-12 mt-8 gap-8">
    <div class="col-span-6">
        <div class="swiper mySwiper">
            <div class="swiper-wrapper">
                <c:forEach var="image" items="${images}">
                    <div class="swiper-slide">
                        <img src="/upload/${image.link}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="h-12 flex gap-4 h-[100px] overflow-auto">
            <c:forEach var="image" items="${images}">
                <img src="/upload/${image.link}" class="border">
            </c:forEach>
        </div>
    </div>
    <div class="col-span-6">
        <div class="breadcrumbs text-sm">
            <ul>
                <li><a>Home</a></li>
                <li><a>Documents</a></li>
                <li>Add Document</li>
            </ul>
        </div>
<%--        <h2 class="font-bold text-4xl my-4">${giayTheThao.tenGiayTheThao}</h2>--%>
<%--        <h3 class="font-semibold text-2xl text-red-500 my-2">${giayTheThao.giaBan} VND</h3>--%>
<%--        <p>Chọn kích thước</p>--%>
<%--        <div class="flex gap-4 p-4">--%>
<%--            <c:forEach var="size" items="${sizes}">--%>
<%--                <button data-size="${size.id}" onclick="handleClickSize(this)"--%>
<%--                        class="btn btn-size">${size.size}</button>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
<%--        <p>Chọn màu sắc</p>--%>
<%--        <div class="flex gap-4 p-4">--%>
<%--            <c:forEach var="color" items="${mauSacs}">--%>
<%--                <button data-color="${color.id}" onclick="handleClickColor(this)"--%>
<%--                        class="btn btn-color">${color.tenMauSac}</button>--%>
<%--            </c:forEach>--%>
<%--        </div>--%>
        <div class="product-details bg-white shadow-lg rounded-lg p-6">
            <!-- Tên sản phẩm -->
            <h2 class="text-4xl font-bold text-red-800 mb-4">${giayTheThao.tenGiayTheThao}</h2>

            <!-- Giá bán với định dạng tiền -->
            <p class="text-xl font-medium text-gray-700">Giá sản phẩm</p>
            <h3 class="font-semibold text-3xl text-red-600 my-2">
                <fmt:formatNumber value="${giayTheThao.giaBan}" type="number" groupingUsed="true" /> VND
            </h3>

            <!-- Kích thước -->
            <p class="text-lg font-medium mt-4 text-red-800">Chọn kích thước</p>
            <div class="flex flex-wrap gap-4 p-4 bg-gray-50 rounded-lg mb-6">
                <c:forEach var="size" items="${sizes}">
                    <button
                            data-size="${size.id}"
                            onclick="handleClickSize(this)"
                            class="btn btn-size border-2 border-gray-300 hover:border-blue-500 px-6 py-3 rounded-md text-gray-700 hover:bg-blue-100 transition-all duration-200">
                            ${size.size}
                    </button>
                </c:forEach>
            </div>

            <!-- Màu sắc -->
            <p class="text-lg font-medium mt-4 text-red-800">Chọn màu sắc</p>
            <div class="flex flex-wrap gap-4 p-4 bg-gray-50 rounded-lg mb-6">
                <c:forEach var="color" items="${mauSacs}">
                    <button
                            data-color="${color.id}"
                            onclick="handleClickColor(this)"
                            class="btn btn-size border-2 border-gray-300 hover:border-blue-500 px-6 py-3 rounded-md text-gray-700 hover:bg-blue-100 transition-all duration-200">
                            ${color.tenMauSac}
                    </button>
                </c:forEach>
            </div>

            <!-- Thông tin sản phẩm mô tả -->
            <div class="product-description mt-6">
                <p class="text-lg font-medium text-red-800">Mô tả sản phẩm:</p>
                <p class="text-base text-gray-600 mt-2">${giayTheThao.moTa}</p>
            </div>
        </div>


        <div class="flex py-4 border-b">
            <div class="custom-number-input h-10 w-32">
                <div class="flex flex-row h-10 w-full rounded-lg relative bg-transparent mt-1">
                    <button data-action="decrement"
                            class=" bg-gray-300 text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full w-20 rounded-l cursor-pointer outline-none">
                        <span class="m-auto text-2xl font-thin">−</span>
                    </button>
                    <input type="number"
                           class="outline-none focus:outline-none text-center w-full bg-gray-300 font-semibold text-md hover:text-black focus:text-black  md:text-basecursor-default flex items-center text-gray-700  outline-none"
                           name="custom-input-number" value="1"></input>
                    <button data-action="increment"
                            class="bg-gray-300 text-gray-600 hover:text-gray-700 hover:bg-gray-400 h-full w-20 rounded-r cursor-pointer">
                        <span class="m-auto text-2xl font-thin">+</span>
                    </button>
                </div>

            </div>
            <div class="flex flex-1 justify-end gap-4">
                <button onclick="handleThemSanPham()" id="addToCartBtn" class="btn btn-outline btn-success" disabled>Thêm vào giỏ hàng</button>
            </div>

        </div>
        <form id="addProductForm" action="/gio-hang" method="post" style="display: none;">
            <input type="hidden" name="chiTietId" id="productDetailId">
            <input type="hidden" name="soLuong" id="quantity">
            <input type="hidden" name="khachHangId" id="userId" value="85FE1849-1EA4-4FF5-8865-0B8F6A70ADFF">
        </form>
        <div class="flex justify-between my-2">
<%--            <div>--%>
<%--                <p class="text-lg font-semibold">Mã</p>--%>
<%--                <p>${giayTheThao.id}</p>--%>
<%--            </div>--%>
            <div>
                <p class="text-lg font-semibold">Thương hiệu</p>
                <p>${giayTheThao.thuongHieu.tenThuongHieu}</p>
            </div>
            <div>
                <p class="text-lg font-semibold">Số lượng hàng có sẵn</p>
                <p id="quantity-remain">0</p>
            </div>
        </div>

<%--        <div class="flex justify-between my-2">--%>
<%--            <div>--%>
<%--                <p class="text-lg font-semibold">Mã</p>--%>
<%--                <p>${giayTheThao.id}</p>--%>
<%--            </div>--%>
<%--            <div>--%>
<%--                <p class="text-lg font-semibold">Thương hiệu</p>--%>
<%--                <p>${giayTheThao.thuongHieu.tenThuongHieu}</p>--%>
<%--            </div>--%>
<%--            <div>--%>
<%--                <p class="text-lg font-semibold">Số lượng hàng có sẵn</p>--%>
<%--                <p id="quantity-remain">${giayTheThaoChiTiet.soLuong}</p> <!-- Hiển thị số lượng tồn kho -->--%>
<%--            </div>--%>
<%--        </div>--%>


    </div>
    <script>
        let selectedSize = null;
        let selectedColor = null;
        const giayTheThaoChiTiet = ${giayTheThaoChiTiet};
        let giayTheoThaoDangChon = null;

        var swiper = new Swiper(".mySwiper", {
            spaceBetween: 30,
            centeredSlides: true,
            autoplay: {
                delay: 2000,
                disableOnInteraction: false,
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
        });
        //
        // function handleThemSanPham() {
        //     const soLuong = document.querySelector('input[name="custom-input-number"]').value;
        //     const size = selectedSize;
        //     const color = selectedColor;
        //
        //     if (!size || !color || !soLuong) {
        //         alert("Vui lòng chọn đầy đủ thông tin sản phẩm.");
        //         return;
        //     }
        //
        //     const form = document.getElementById('addProductForm');
        //
        //     form.querySelector('#productDetailId').value = giayTheoThaoDangChon.id;
        //     form.querySelector('#quantity').value = soLuong;
        //     form.submit();
        // }


        function handleThemSanPham() {

            const soLuong = document.querySelector('input[name="custom-input-number"]').value;
            const size = selectedSize;
            const color = selectedColor;

            // Kiểm tra số lượng phải lớn hơn 0
            if (!soLuong || soLuong <= 0) {
                alert("Số lượng phải lớn hơn 0.");
                return;
            }

            // Kiểm tra đã chọn đầy đủ kích thước và màu sắc
            if (!size || !color) {
                alert("Vui lòng chọn đầy đủ thông tin sản phẩm (kích thước và màu sắc).");
                return;
            }

            // Kiểm tra số lượng tồn kho
            const quantityInStock = giayTheoThaoDangChon.soLuong; // Lấy số lượng còn lại trong kho

            if (soLuong > quantityInStock) {
                alert("Không đủ số lượng sản phẩm trong kho. Vui lòng chọn số lượng nhỏ hơn hoặc bằng " + quantityInStock);
                return;
            }

            // Giảm số lượng tồn kho sau khi thêm vào giỏ hàng
            giayTheoThaoDangChon.soLuong -= soLuong;

            // Cập nhật lại số lượng hiển thị trên giao diện
            const quantity = document.getElementById('quantity-remain');
            quantity.innerText = giayTheoThaoDangChon.soLuong;

            // Kiểm tra lại số lượng và bật/tắt nút thêm vào giỏ hàng
            const addToCartBtn = document.getElementById('addToCartBtn');
            if (giayTheoThaoDangChon.soLuong > 0) {
                addToCartBtn.disabled = false;
            } else {
                addToCartBtn.disabled = true;
            }

            // Sau khi xử lý xong, gửi thông tin vào form
            const form = document.getElementById('addProductForm');
            form.querySelector('#productDetailId').value = giayTheoThaoDangChon.id;
            form.querySelector('#quantity').value = soLuong;
            form.submit();
        }





        function handleClickSize(e) {
            const buttons = document.querySelectorAll('.btn-size');
            buttons.forEach(button => {
                button.classList.remove('bg-black');
                button.classList.remove('text-white');
            });
            e.classList.add('bg-black');
            e.classList.add('text-white');
            selectedSize = e.getAttribute('data-size');
            updateQuantity();
        }



        function handleClickColor(e) {
            const buttons = document.querySelectorAll('.btn-color');
            buttons.forEach(button => {
                button.classList.remove('bg-black');
                button.classList.remove('text-white');
            });
            e.classList.add('bg-black');
            e.classList.add('text-white');
            selectedColor = e.getAttribute('data-color');
            updateQuantity();
        }

        // function updateQuantity() {
        //     const quantity = document.getElementById('quantity-remain');
        //     const addToCartBtn = document.getElementById('addToCartBtn');
        //     const buyNowBtn = document.getElementById('buyNowBtn');
        //
        //     const value = giayTheThaoChiTiet.find(giayTheThaoChiTiet => giayTheThaoChiTiet.size.id == selectedSize && giayTheThaoChiTiet.mauSac.id == selectedColor);
        //     giayTheoThaoDangChon = value;
        //     if (!value) {
        //         quantity.innerText = 0;
        //         addToCartBtn.disabled = true;
        //         buyNowBtn.disabled = true;
        //         return;
        //     }
        //
        //     quantity.innerText = value.soLuong;
        //
        //     // Kiểm tra số lượng và vô hiệu hóa hoặc bật các nút
        //     if (value.soLuong > 0) {
        //         addToCartBtn.disabled = false;
        //         buyNowBtn.disabled = false;
        //     } else {
        //         addToCartBtn.disabled = true;
        //         buyNowBtn.disabled = true;
        //     }
        // }
        function updateQuantity() {
            const quantity = document.getElementById('quantity-remain');
            const addToCartBtn = document.getElementById('addToCartBtn');
            const value = giayTheThaoChiTiet.find(giayTheThaoChiTiet => giayTheThaoChiTiet.size.id == selectedSize && giayTheThaoChiTiet.mauSac.id == selectedColor);
            giayTheoThaoDangChon = value;

            if (!value) {
                quantity.innerText = 0;
                addToCartBtn.disabled = true;
                return;
            }

            quantity.innerText = value.soLuong;

            // Kiểm tra số lượng và vô hiệu hóa hoặc bật các nút
            if (value.soLuong > 0) {
                addToCartBtn.disabled = false; // Enable add to cart when stock is available
            } else {
                addToCartBtn.disabled = true; // Disable add to cart if no stock
            }
        }

        function decrement(e) {
            const btn = e.target.parentNode.parentElement.querySelector(
                'button[data-action="decrement"]'
            );
            const target = btn.nextElementSibling;
            let value = Number(target.value);
            value--;
            target.value = value;
        }

        function increment(e) {
            const btn = e.target.parentNode.parentElement.querySelector(
                'button[data-action="decrement"]'
            );
            const target = btn.nextElementSibling;
            let value = Number(target.value);
            value++;
            target.value = value;
        }

        const decrementButtons = document.querySelectorAll(
            `button[data-action="decrement"]`
        );

        const incrementButtons = document.querySelectorAll(
            `button[data-action="increment"]`
        );

        decrementButtons.forEach(btn => {
            btn.addEventListener("click", decrement);
        });

        incrementButtons.forEach(btn => {
            btn.addEventListener("click", increment);
        });
////testt
<%--        function handleThemSanPham(event) {--%>
<%--            // Ngừng hành động mặc định của form (ngừng tải lại trang)--%>
<%--            event.preventDefault();--%>

<%--            const soLuong = document.querySelector('input[name="custom-input-number"]').value;--%>
<%--            const size = selectedSize;--%>
<%--            const color = selectedColor;--%>

<%--            // Kiểm tra số lượng phải lớn hơn 0--%>
<%--            if (!soLuong || soLuong <= 0) {--%>
<%--                alert("Số lượng phải lớn hơn 0.");--%>
<%--                return;--%>
<%--            }--%>

<%--            // Kiểm tra đã chọn đầy đủ kích thước và màu sắc--%>
<%--            if (!size || !color) {--%>
<%--                alert("Vui lòng chọn đầy đủ thông tin sản phẩm (kích thước và màu sắc).");--%>
<%--                return;--%>
<%--            }--%>

<%--            // Kiểm tra số lượng tồn kho--%>
<%--            const quantityInStock = giayTheoThaoDangChon.soLuong; // Lấy số lượng còn lại trong kho--%>
<%--            if (soLuong > quantityInStock) {--%>
<%--                alert("Không đủ số lượng sản phẩm trong kho. Vui lòng chọn số lượng nhỏ hơn hoặc bằng " + quantityInStock);--%>
<%--                return;--%>
<%--            }--%>

<%--            // Giảm số lượng tồn kho sau khi thêm vào giỏ hàng--%>
<%--            giayTheoThaoDangChon.soLuong -= soLuong;--%>

<%--            // Cập nhật lại số lượng hiển thị trên giao diện--%>
<%--            const quantity = document.getElementById('quantity-remain');--%>
<%--            if (quantity) {--%>
<%--                quantity.innerText = giayTheoThaoDangChon.soLuong;--%>
<%--            }--%>

<%--            // Kiểm tra lại số lượng và bật/tắt nút thêm vào giỏ hàng--%>
<%--            const addToCartBtn = document.getElementById('addToCartBtn');--%>
<%--            if (addToCartBtn) {--%>
<%--                if (giayTheoThaoDangChon.soLuong > 0) {--%>
<%--                    addToCartBtn.disabled = false;--%>
<%--                } else {--%>
<%--                    addToCartBtn.disabled = true;--%>
<%--                }--%>
<%--            }--%>

<%--            // Cập nhật giỏ hàng: Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa--%>
<%--            const cartItemIndex = cart.findIndex(item => item.productId === giayTheoThaoDangChon.id && item.size === size && item.color === color);--%>

<%--            if (cartItemIndex !== -1) {--%>
<%--                // Nếu sản phẩm đã có trong giỏ hàng, cập nhật số lượng--%>
<%--                cart[cartItemIndex].quantity += soLuong;--%>
<%--            } else {--%>
<%--                // Nếu chưa có trong giỏ hàng, thêm mới--%>
<%--                const cartItem = {--%>
<%--                    productId: giayTheoThaoDangChon.id,--%>
<%--                    size: size,--%>
<%--                    color: color,--%>
<%--                    quantity: soLuong--%>
<%--                };--%>
<%--                cart.push(cartItem);--%>
<%--            }--%>

<%--            // Cập nhật giỏ hàng trên giao diện--%>
<%--            updateCartUI();--%>

<%--            // Gửi giỏ hàng tới server (nếu cần)--%>
<%--            sendCartToServer();--%>
<%--        }--%>

<%--        function updateCartUI() {--%>
<%--            // Cập nhật giỏ hàng trên giao diện (ví dụ: cập nhật số lượng sản phẩm trong giỏ hàng)--%>
<%--            const cartCount = cart.reduce((total, item) => total + item.quantity, 0);--%>
<%--            document.getElementById('cart-count').innerText = cartCount;--%>

<%--            // Cập nhật danh sách sản phẩm trong giỏ hàng (nếu có)--%>
<%--            const cartList = document.getElementById('cart-list');--%>
<%--            if (cartList) {--%>
<%--                cartList.innerHTML = '';  // Xóa nội dung cũ trong giỏ hàng--%>
<%--                cart.forEach(item => {--%>
<%--                    const cartItemElement = document.createElement('li');--%>
<%--                    cartItemElement.innerText = `Sản phẩm: ${item.productId}, Size: ${item.size}, Màu: ${item.color}, Số lượng: ${item.quantity}`;--%>
<%--                    cartList.appendChild(cartItemElement);--%>
<%--                });--%>
<%--            }--%>
<%--        }--%>

<%--        function sendCartToServer() {--%>
<%--            // Gửi giỏ hàng tới server (ví dụ: sử dụng AJAX)--%>
<%--            const xhr = new XMLHttpRequest();--%>
<%--            xhr.open('POST', '/cart', true);  // Địa chỉ URL có thể thay đổi tùy theo API của bạn--%>
<%--            xhr.setRequestHeader('Content-Type', 'application/json');--%>
<%--            xhr.onreadystatechange = function () {--%>
<%--                if (xhr.readyState === 4 && xhr.status === 200) {--%>
<%--                    console.log('Giỏ hàng đã được cập nhật trên server');--%>
<%--                }--%>
<%--            };--%>
<%--            xhr.send(JSON.stringify(cart));  // Gửi giỏ hàng dưới dạng JSON--%>
<%--        }--%>




    </script>
</div>
</body>
</html>
