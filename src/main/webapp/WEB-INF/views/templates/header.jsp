<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="fixed z-10 top-0 right-0 left-0 border-b bg-white">
    <div class="w-[80%] mx-auto ">
        <div class="navbar bg-base-100">
            <div class="flex-1 gap-12">
                <a href="${pageContext.request.contextPath}/" class=" text-xl">
                    <img src="https://marketingai.mediacdn.vn/thumb_w/480//wp-content/uploads/2018/06/Sb-min-2-370x370.jpg" class="w-16 h-16" />
                </a>
                <form action="/" class="input input-bordered flex items-center gap-2">
                    <input name="search" type="text" class="grow" placeholder="Search" />
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 16 16"
                            fill="currentColor"
                            class="h-4 w-4 opacity-70">
                        <path
                                fill-rule="evenodd"
                                d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
                                clip-rule="evenodd" />
                    </svg>
                </form>
            </div>

            <div class="flex-none">
                <div class="drawer drawer-end">
                    <input id="my-drawer-4" type="checkbox" class="drawer-toggle" />
                    <div class="drawer-content">
                        <!-- Page content here -->
                        <label for="my-drawer-4" class="drawer-button"><svg
                                xmlns="http://www.w3.org/2000/svg"
                                class="h-5 w-5"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor">
                            <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    stroke-width="2"
                                    d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z" />
                        </svg></label>
                    </div>
                    <div class="drawer-side z-10">
                        <label for="my-drawer-4" aria-label="close sidebar" class="drawer-overlay"></label>
                        <div class="menu bg-white text-base-content min-h-full w-96 p-4">
                            <!-- Sidebar content here -->
                            <div class="font-semibold text-2xl border-b-2 pb-4">Gio hang</div>
                            <div class="mb-4">
                                <c:forEach var="gioHang" items="${gioHang}">
                                    <div data-id="${gioHang.id}" class="grid grid-cols-3 gap-2 py-4 border-b-2 border-dashed cart-item">
                                        <img class="w-20 h-20" src="/upload/${gioHang.giayTheThaoChiTiet.giayTheThao.getAnhDau()}">
                                        <div class="col-span-2" >
                                            <p>${gioHang.giayTheThaoChiTiet.giayTheThao.tenGiayTheThao}</p>
                                            <p class="py-2">${gioHang.donGia} VND</p>
                                            <div class="flex justify-between">
                                                <div class="flex">
                                                    <input type="number" class="custom-number-input w-8 text-center" value="${gioHang.soLuong}">
                                                </div>
                                                <button onclick="handleDeleteCart(this)" class="btn btn-sm">Xoa</button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="grid grid-cols-2 my-4 gap-4 px-2">
                                <a href="${pageContext.request.contextPath}/gio-hang" class="btn">Xem giỏ hàng</a>
                                <button onclick="updateCart()" class="hover:text-white btn btn-outline hover:bg-[#00a96e] hover:border-[#00a96e] px-3">Cập nhật</button>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="dropdown dropdown-end ml-4">
                    <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar">
                        <div class="w-10 rounded-full">
                            <img
                                    alt="Tailwind CSS Navbar component"
                                    src="https://img.daisyui.com/images/stock/photo-1534528741775-53994a69daeb.webp" />
                        </div>
                    </div>
                    <ul
                            tabindex="0"
                            class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow">
                        <li>
                            <a class="justify-between">
                                Profile
                                <span class="badge">New</span>
                            </a>
                        </li>
                        <li><a>Settings</a></li>
                        <li><a href="${pageContext.request.contextPath}/UserLog/logout">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</header>
<div class="mt-[80px]">
    <div class="flex py-4 bg-[#f6f8fa]">
        <div class="w-[80%] mx-auto ">
            <div class="dropdown dropdown-hover">
                <div onclick="handleShowAll()" tabindex="0" class="m-1 hover:text-pink-300 cursor-pointer">Tất cả sản phẩm</div>
            </div>
            <div class="dropdown dropdown-hover">
                <div tabindex="0" class="hover:text-pink-300 cursor-pointer m-1">Thương hiệu</div>
                <ul tabindex="0" class="dropdown-content menu bg-base-100 rounded-box z-10 w-52 p-2 shadow">
                    <c:forEach var="nhanHang" items="${thuongHieus}">
                        <li><a href="${pageContext.request.contextPath}/hanghoa/${nhanHang.id}">${nhanHang.tenThuongHieu}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    function handleDeleteCart(button) {
        const cartItem = button.closest('.cart-item');
        const id = cartItem.dataset.id;
        fetch('http://localhost:8080/api/gio-hang/xoa-gio-hang', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ id }),
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);  // Success message
                    cartItem.remove();
                } else {
                }
            })
        alert("Xóa thành công!, load lại trang để cập nhật")
        window.location.reload();

    }

    function handleShowAll() {
        window.location.href = "${pageContext.request.contextPath}/hanghoa/all";
    }
    function updateQuantityHeader(button, isIncrement) {
        const quantityInput = button.parentElement.querySelector('input[type="number"]');
        let currentQuantity = parseInt(quantityInput.value);
        if (isIncrement) {
            quantityInput.value = currentQuantity + 1;
        } else if (currentQuantity > 1) {
            quantityInput.value = currentQuantity - 1;
        }
    }

    function updateCart() {
        const items = [];
        document.querySelectorAll('.cart-item').forEach(item => {
            const id = item.dataset.id;  // Add data-id attribute to each cart item container in JSP
            const quantity = item.querySelector('input[type="number"]').value;
            items.push({ id, quantity });
        });

        fetch('http://localhost:8080/api/gio-hang/cap-nhat-gio-hang', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(items),
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);  // Success message
                    window.location.reload();
                } else {
                }
            })
        alert("Cập nhật thành công")
    }
</script>
