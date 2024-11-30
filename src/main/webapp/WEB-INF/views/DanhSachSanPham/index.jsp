<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.14/dist/full.min.css" rel="stylesheet" type="text/css" />
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
    <title>User</title>
</head>
<body>
    <%@ include file="../templates/header.jsp" %>
    <h2 class="font-bold text-3xl text-center my-8">${thuongHieu}</h2>
    <div class="w-[80%] mx-auto grid grid-cols-12 gap-4">
        <div class="col-span-3">
            <p class="pb-4 font-bold text-lg">Bo loc</p>
            <div class="flex flex-col gap-4 border p-4 rounded">
                <div class="collapse collapse-arrow rounded-none">
                    <input type="radio" name="my-accordion-2 rounded-none" checked = "checked" />
                    <div class="collapse-title text-xl font-medium bg-base-200">Size</div>
                    <div class="collapse-content">
                        <div class="grid grid-cols-2 gap-2 py-2">
                            <c:forEach var="size" items="${sizes}">
                                <button onclick="handleChooseSize(this)" class="p-2 bg-base-200 text-center rounded-lg border">${size.size}</button>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="collapse collapse-arrow rounded-none">
                    <input type="radio" name="my-accordion-2 rounded-none" />
                    <div class="collapse-title text-xl font-medium bg-base-200">Thương hiệu</div>
                    <div class="collapse-content">
                        <div class="grid grid-cols-1 gap-2 py-2">
                            <c:forEach var="brand" items="${thuongHieus}">
                                <label class="label cursor-pointer justify-start " onclick="handleChooseBrand(this)">
                                    <input type="checkbox" class="checkbox mr-2" />
                                    <span class="label-text
                                    ">${brand.tenThuongHieu}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="collapse collapse-arrow rounded-none">
                    <input type="radio" name="my-accordion-2 rounded-none" />
                    <div class="collapse-title text-xl font-medium bg-base-200">Màu sắc</div>
                    <div class="collapse-content">
                        <div class="grid grid-cols-1 gap-2 py-2">
                            <c:forEach var="color" items="${mauSacs}">

                                <label class="label cursor-pointer justify-start " onclick="handleChooseColor(this)">
                                    <input type="checkbox" class="checkbox mr-2" />
                                    <span class="label-text
                                    ">${color.tenMauSac}</span>
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-span-9">
            <div class="breadcrumbs text-sm pt-0 pb-6">
                <ul class="font-bold">
                    <li><a href="${pageContext.request.contextPath}/">Trang chu</a></li>
                    <li>${thuongHieu}</li>
                </ul>
            </div>
            <div class="grid grid-cols-3 gap-4" id="product-list">
                <c:forEach var="product" items="${danhSachGiayTheThao}">
                    <a href="${pageContext.request.contextPath}/san-pham/${product.id}" class="card bg-base-100 shadow-xl">
                        <figure>
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
                            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
<script>
    const selectedSizes = new Set();
    const selectedBrands = new Set();
    const selectedColors = new Set();

    function handleChooseSize(element) {
        const size = element.textContent.trim();
        if (selectedSizes.has(size)) {
            selectedSizes.delete(size);
            element.classList.remove('border-green-500');
        } else {
            selectedSizes.add(size);
            element.classList.add('border-green-500');
        }
        updateProductList();
    }

    function handleChooseBrand(element) {
        const brand = element.querySelector('.label-text').textContent.trim();
        if (selectedBrands.has(brand)) {
            selectedBrands.delete(brand);
            element.querySelector('.checkbox').checked = false;
        } else {
            selectedBrands.add(brand);
            element.querySelector('.checkbox').checked = true;
        }
        updateProductList();
    }

    function handleChooseColor(element) {
        const color = element.querySelector('.label-text').textContent.trim();
        if (selectedColors.has(color)) {
            selectedColors.delete(color);
            element.querySelector('.checkbox').checked = false;
        } else {
            selectedColors.add(color);
            element.querySelector('.checkbox').checked = true;
        }
        updateProductList();
    }

    async function updateProductList() {
        const sizes = Array.from(selectedSizes).join(',');
        const brands = Array.from(selectedBrands).join(',');
        const colors = Array.from(selectedColors).join(',');

        try {
            const response = await fetch(`http://localhost:8080/api/theloai/all`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ sizes, brands, colors })
            });
            const products = await response.json();

            renderProductList(products);
        } catch (error) {
            console.error('Error fetching filtered products:', error);
        }
    }

    function renderProductList(products) {
        const productContainer = document.querySelector('#product-list');
        productContainer.innerHTML = '';
        products.forEach(product => {
            productContainer.innerHTML += `
                <a href="` + product.link  + `" class="card bg-base-100 shadow-xl">
                    <figure>
                        <img src="` +product.image +`" alt="` +product.name +`" />
                    </figure>
                    <div class="card-body">
                        <h2 class="card-title">` +product.name +`</h2>
                        <p>` +product.description +`</p>
                        <div class="text-xl">` +product.price +`</div>
                    </div>
                </a>
            `;
        });
    }
</script>
</body>
</html>
