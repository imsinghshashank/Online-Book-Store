<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Bookstore - Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6; /* Light gray background */
            color: #374151; /* Dark gray text */
            margin: 0;
            line-height: 1.6;
        }
        .header-nav {
            background-color: #1f2937; /* Darker header background */
            padding: 1.25rem 2.5rem; /* Increased padding */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* More pronounced shadow */
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .header-nav .logo {
            font-size: 2rem; /* Larger logo text */
            font-weight: bold;
            color: #ffffff;
            letter-spacing: 0.05em;
            margin-bottom: 0;
        }
        .header-nav .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            margin-top: 0;
        }
        .header-nav .nav-links a {
            color: #d1d5db;
            margin-left: 2rem;
            text-decoration: none;
            transition: all 0.2s ease-in-out;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            border-radius: 0.375rem;
        }
        .header-nav .nav-links a:hover {
            color: #ffffff;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .header-nav .nav-links a i {
            margin-right: 0.6rem;
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .header-nav {
                flex-direction: column;
                align-items: flex-start;
                padding: 1rem;
            }
            .header-nav .logo {
                margin-bottom: 1rem;
                font-size: 1.7rem;
            }
            .header-nav .nav-links {
                width: 100%;
                justify-content: center;
                margin-top: 0.5rem;
            }
            .header-nav .nav-links a {
                margin: 0.5rem 0.75rem;
                font-size: 0.9rem;
            }
        }
        @media (max-width: 480px) {
            .header-nav .nav-links a {
                margin: 0.4rem 0.5rem;
                padding: 0.4rem 0.6rem;
                font-size: 0.85rem;
            }
        }

        /* Main content container */
        .container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        @media (max-width: 1200px) {
            .container {
                max-width: 95%;
                margin: 30px auto;
                padding: 20px;
            }
        }
        
        .order-card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            padding: 2rem;
            transition: box-shadow 0.2s ease-in-out;
            border: 1px solid #e5e7eb;
        }
        .order-card:hover {
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        .order-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }
        .order-item-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .order-item-list li {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 0.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .order-item-list li:last-child {
            margin-bottom: 0;
        }
        .info-label {
            font-weight: 500;
            color: #6b7280;
        }
        .info-value {
            font-weight: 600;
            color: #1f2937;
        }
        .order-total {
            font-size: 1.8rem;
            font-weight: 800;
            color: #059669;
        }
        .status-badge {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        .status-processing {
            background-color: #fef3c7;
            color: #92400e;
        }
        .status-shipped {
            background-color: #d1fae5;
            color: #065f46;
        }
        .no-orders-msg {
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-size: 1.25rem;
            background-color: #fcfcfc;
            border-radius: 10px;
            border: 1px dashed #d1d5db;
        }
        .footer {
            background-color: #1f2937;
            color: #9ca3af;
            text-align: center;
            padding: 1.5rem 0;
            margin-top: 50px;
            width: 100%;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>
    <header class="header-nav">
        <div class="logo">Online Bookstore</div>
        <nav class="nav-links">
            <a href="/"><i class="fas fa-home"></i>Home</a>
            <a href="/books/list"><i class="fas fa-book"></i>Books</a>
            <c:if test="${sessionScope.isUserLoggedIn}">
                 <a href="/orders/history"><i class="fas fa-history"></i>Order History</a>
            </c:if>
            <c:if test="${sessionScope.isUserLoggedIn}">
                <a href="/cart"><i class="fas fa-shopping-cart"></i>Cart</a>
            </c:if>
            <c:choose>
                <c:when test="${sessionScope.isUserLoggedIn}">
                    <a href="/logout"><i class="fas fa-sign-out-alt"></i>Logout (<c:out value="${sessionScope.loggedInUser.username}"/>)</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${!sessionScope.isAdminLoggedIn}">
                        <a href="/login"><i class="fas fa-sign-in-alt"></i>Login</a>
                        <a href="/signup"><i class="fas fa-user-plus"></i>Sign Up</a>
                    </c:if>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${sessionScope.isAdminLoggedIn}">
                    <a href="/admin/logout"><i class="fas fa-user-shield"></i>Logout (Admin)</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${!sessionScope.isUserLoggedIn}">
                        <a href="/admin/login"><i class="fas fa-user-shield"></i>Admin</a>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <div class="container">
        <h1 class="text-3xl font-bold mb-8 text-center">Your Order History</h1>

        <c:if test="${empty orders}">
            <p class="no-orders-msg">You haven't placed any orders yet. <a href="/books/list" class="text-blue-600 hover:underline font-bold">Start shopping now!</a></p>
        </c:if>

        <div class="space-y-8">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="flex justify-between items-start mb-6 pb-4 border-b border-gray-200">
                        <div>
                            <p class="info-label">Order Date</p>
                            <p class="text-lg info-value">
                                <fmt:formatDate value="${order.legacyOrderDate}" pattern="dd MMM yyyy HH:mm a" />
                            </p>
                        </div>
                        <div class="text-right">
                            <p class="info-label">Order Total</p>
                            <p class="order-total">₹${order.totalAmount}</p>
                        </div>
                    </div>

                    <div class="order-summary mb-6">
                        <div>
                            <p class="info-label">Status</p>
                            <span class="status-badge 
                                <c:choose>
                                    <c:when test="${order.status == 'Shipped'}">status-shipped</c:when>
                                    <c:when test="${order.status == 'Processing'}">status-processing</c:when>
                                    <c:otherwise>bg-gray-200 text-gray-700</c:otherwise>
                                </c:choose>">
                                ${order.status}
                            </span>
                        </div>
                        <div>
                            <p class="info-label">Payment Method</p>
                            <p class="info-value">${order.paymentMethod}</p>
                        </div>
                        <div class="col-span-full">
                            <p class="info-label">Shipping To</p>
                            <p class="info-value">
                                ${order.fullName}, ${order.shippingAddress}, ${order.city}, ${order.zipCode}
                            </p>
                        </div>
                    </div>

                    <div>
                        <h3 class="text-lg font-bold text-gray-700 mb-4">Items in this order</h3>
                        <ul class="order-item-list">
                            <c:forEach var="item" items="${order.orderItems}">
                                <li>
                                    <div class="flex items-center">
                                        <i class="fas fa-book text-xl text-gray-400 mr-4"></i>
                                        <div>
                                            <p class="font-medium text-gray-900">${item.book.title}</p>
                                            <p class="text-sm text-gray-500">${item.quantity} x ₹${item.priceAtPurchase}</p>
                                        </div>
                                    </div>
                                    <p class="font-semibold text-gray-800">
                                        ₹<fmt:formatNumber value="${item.quantity * item.priceAtPurchase}" pattern="0.00" />
                                    </p>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>