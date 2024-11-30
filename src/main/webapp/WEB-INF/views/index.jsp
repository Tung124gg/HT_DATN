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
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
    <title>User</title>
</head>

<body>
<%@ include file="./templates/header.jsp" %>
<div class="w-[80%] mx-auto min-h-screen">
    <div>
        <div class="flex gap-2">
            <div class="w-[70%]">
                <div class="swiper mySwiper">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="https://img.pikbest.com/origin/09/30/65/27hpIkbEsTzdI.jpg!sw800"/>
                        </div>
                        <div class="swiper-slide">
                            <img src="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-banner-template-design-389dc7a74f096738d1d425314404a2cd_screen.jpg?ts=1605613724"/>
                        </div>
                        <div class="swiper-slide">
                            <img src="https://img.freepik.com/premium-vector/fashion-banner-sale-with-text-effect_92715-89.jpg"/>
                        </div>
                        <div class="swiper-slide">
                            <img src="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-banner-template-design-f7863ed31571a109d072a7dae4778ca1_screen.jpg?ts=1605627076"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-[30%] bg-white flex flex-col gap-2">
                <div class="flex-1 bg-red-300">
                    <img src="https://img.pikbest.com/origin/09/30/65/27hpIkbEsTzdI.jpg!sw800"/>
                </div>
                <div class="flex-1 bg-red-300">
                    <img src="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-banner-template-design-f7863ed31571a109d072a7dae4778ca1_screen.jpg?ts=1605627076"/>
                </div>
                <div class="flex-1 bg-red-300">
                    <img src="https://img.freepik.com/premium-vector/fashion-banner-sale-with-text-effect_92715-89.jpg"/>
                </div>
            </div>
        </div>
        <div class="my-4 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <%--            <%--%>
            <%--                // Mảng các lợi ích--%>
            <%--                String[][] benefits = {--%>
            <%--                        { "https://example.com/images/high_quality.svg",--%>
            <%--                                "Chất lượng cao cấp",--%>
            <%--                                "Giày được làm từ chất liệu cao cấp, đảm bảo độ bền và sự thoải mái tối đa khi sử dụng." },--%>
            <%--                        { "https://example.com/images/easy_payment.svg", "Thanh toán linh hoạt",--%>
            <%--                                "Nhiều phương thức thanh toán đa dạng: ATM, thẻ Visa, và các ví điện tử như Momo, VnPay, ZaloPay." },--%>
            <%--                        { "https://example.com/images/free_shipping.svg",--%>
            <%--                                "Miễn phí vận chuyển",--%>
            <%--                                "Miễn phí vận chuyển toàn quốc cho đơn hàng từ 500.000đ trở lên." },--%>
            <%--                        { "https://example.com/images/return_policy.svg", "Chính sách đổi trả",--%>
            <%--                                "Hỗ trợ đổi trả trong vòng 30 ngày nếu có lỗi từ nhà sản xuất." },--%>
            <%--                        { "https://example.com/images/many_styles.svg",--%>
            <%--                                "Nhiều kiểu dáng đa dạng",--%>
            <%--                                "Từ giày thể thao, giày tây, đến giày thời trang phù hợp với mọi phong cách." },--%>
            <%--                        { "https://example.com/images/customer_service.svg", "Dịch vụ khách hàng tận tâm",--%>
            <%--                                "Hỗ trợ tư vấn 24/7, sẵn sàng giải đáp mọi thắc mắc của khách hàng." }--%>
            <%--                };--%>

            <%--                // Duyệt qua mảng benefits và hiển thị từng mục--%>
            <%--                for (int i = 0; i < benefits.length; i++) {--%>
            <%--                    String img = benefits[i][0];--%>
            <%--                    String title = benefits[i][1];--%>
            <%--                    String description = benefits[i][2];--%>
            <%--            %>--%>
            <%--            <div class="flex flex-col w-[calc(33.33% - 37.33px)] items-center">--%>
            <%--                <img src="<%= img %>" alt="<%= title %>" class="w-60 h-60 mb-9"/>--%>
            <%--                <h5 class="text-xl font-semibold mb-2"><%= title %>--%>
            <%--                </h5>--%>
            <%--                <p class="text-gray-600"><%= description %>--%>
            <%--                </p>--%>
            <%--            </div>--%>
            <%--            <%--%>
            <%--                }--%>
            <%--            %>--%>
        </div>
    </div>
</div>
<c:if test="${search != null}">
    <div class="bg-gray-200 my-8 py-4 ">
        <div class="w-[80%] mx-auto">
            <h2 class="text-center font-bold text-xl py-8">Tìm kiếm theo từ khóa "${search}"</h2>
            <div class="grid grid-cols-3 gap-4 ">
                <c:forEach items="${giayTheThaoSearch}" var="product">
                    <a href="${pageContext.request.contextPath}/san-pham/${product.id}"
                       class="card bg-base-100 shadow-xl col-span-1 gap-4 h-[400px]">
                        <figure>
                            <img
                                    src="/upload/${product.getAnhDau()} "
                                    alt="Shoes"/>
                        </figure>
                        <div class="card-body">
                            <h2 class="card-title">
                                    ${product.tenGiayTheThao}
                                <div class="badge badge-secondary">NEW</div>
                            </h2>
                            <p> ${product.moTa}</p>
                            <div class="flex justify-between">
                                <div class="text-xl">${product.giaBan} VND</div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
</c:if>
<div class="bg-gray-200 my-8 py-4 ">
    <div class="w-[80%] mx-auto">
        <h2 class="text-center font-bold text-xl py-8">Danh sách sản phẩm mới</h2>
        <div class="grid grid-cols-3 gap-4 ">
            <c:forEach items="${giayTheThaoMoi}" var="product">
                <a href="${pageContext.request.contextPath}/san-pham/${product.id}"
                   class="card bg-base-100 shadow-xl col-span-1 gap-4 h-[400px]">
                    <figure>
                        <img
                                src="/upload/${product.getAnhDau()} "
                                        alt="Shoes"/>
                    </figure>
                    <div class="card-body">
                        <h2 class="card-title">
                                ${product.tenGiayTheThao}
                            <div class="badge badge-secondary">NEW</div>
                        </h2>
                        <p> ${product.moTa}</p>
                        <div class="flex justify-between" style="color: red">
                            <div class="text-xl">
                                <fmt:formatNumber value="${product.giaBan}" type="number" groupingUsed="true" /> VND
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<div class="bg-gray-200 my-8 py-4 ">
    <div class="w-[80%] mx-auto">
        <h2 class="text-center font-bold text-xl py-8">Danh sách sản phẩm bán chạy</h2>
        <div class="grid grid-cols-3 gap-4">
            <c:forEach items="${giayTheThaoMoi}" var="product">
                <a href="${pageContext.request.contextPath}/san-pham/${product.id}"
                   class="card bg-base-100 shadow-xl col-span-1 gap-4 h-[400px]">
                    <figure >
                        <img
                                src="/upload/${product.getAnhDau()}"
                                        alt="Shoes"/>
                    </figure>
                    <div class="card-body">
                        <h2 class="card-title">
                                ${product.tenGiayTheThao}
                            <div class="badge badge-secondary">NEW</div>
                        </h2>
                        <p> ${product.moTa}</p>
                        <div class="flex justify-between" style="color: red">
                            <div class="text-xl">
                                <fmt:formatNumber value="${product.giaBan}" type="number" groupingUsed="true" /> VND
                            </div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
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
</script>
<%@ include file="./templates/footer.jsp" %>

</body>
</html>
