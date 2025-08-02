<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart - Online Bookstore</title>
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
            flex-wrap: wrap; /* Allow navigation items to wrap on smaller screens */
        }
        .header-nav .logo {
            font-size: 2rem; /* Larger logo text */
            font-weight: bold;
            color: #ffffff;
            letter-spacing: 0.05em;
            margin-bottom: 0; /* No margin-bottom by default */
        }
        .header-nav .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap; /* Allow nav links to wrap */
            margin-top: 0; /* No margin-top by default */
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

        /* Responsive adjustments for header */
        @media (max-width: 768px) { /* On medium screens and smaller */
            .header-nav {
                flex-direction: column; /* Stack logo and nav links */
                align-items: flex-start; /* Align items to the start */
                padding: 1rem;
            }
            .header-nav .logo {
                margin-bottom: 1rem; /* Add space below logo when stacked */
                font-size: 1.7rem;
            }
            .header-nav .nav-links {
                width: 100%; /* Take full width */
                justify-content: center; /* Center links */
                margin-top: 0.5rem; /* Add space above links */
            }
            .header-nav .nav-links a {
                margin: 0.5rem 0.75rem; /* Adjust margin for wrapped links */
                font-size: 0.9rem;
            }
        }
        @media (max-width: 480px) { /* On extra small screens */
            .header-nav .nav-links a {
                margin: 0.4rem 0.5rem;
                padding: 0.4rem 0.6rem;
                font-size: 0.85rem;
            }
        }

        /* NEW: Flash Message Styles */
        .flash-message {
            position: fixed; /* Make it pop over content */
            top: 20px;
            left: 50%;
            transform: translateX(-50%); /* Center it */
            z-index: 1000; /* Ensure it's on top of everything else */
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: bold;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            opacity: 0; /* Start hidden */
            transition: opacity 0.5s ease-in-out; /* Smooth fade effect */
        }
        .flash-message.show {
            opacity: 1; /* Show it */
        }
        .flash-message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .flash-message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        /* NEW: Shopping Cart Specific Styles */
        .cart-container {
            max-width: 1200px;
            margin: 40px auto;
            background: white;
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .cart-table-wrapper {
            overflow-x: auto;
        }

        .cart-table {
            min-width: 700px; /* Ensure table doesn't get too small on mobile */
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }

        .cart-table thead th {
            background-color: #f9fafb;
            color: #4b5563;
            font-weight: 600;
            text-align: left;
            padding: 1rem;
            border-bottom: 2px solid #e5e7eb;
        }

        .cart-table tbody tr {
            border-bottom: 1px solid #e5e7eb;
            transition: background-color 0.2s ease;
        }

        .cart-table tbody tr:hover {
            background-color: #f3f4f6;
        }

        .cart-table tbody td {
            padding: 1rem;
            vertical-align: middle;
        }

        .cart-table .quantity-input {
            width: 80px;
            padding: 0.5rem;
            text-align: center;
            border: 1px solid #d1d5db;
            border-radius: 6px;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.2s ease, transform 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
        }
        .btn-primary:hover { background-color: #1e40af; transform: translateY(-1px); }

        .btn-danger {
            background-color: #ef4444;
            color: white;
        }
        .btn-danger:hover { background-color: #dc2626; transform: translateY(-1px); }

        .btn-success {
            background-color: #10b981;
            color: white;
        }
        .btn-success:hover { background-color: #059669; transform: translateY(-1px); }

        .cart-summary {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
            margin-top: 2rem;
            align-items: flex-end;
        }

        .cart-summary .total-price {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1f2937;
        }

        .cart-summary .actions {
            display: flex;
            gap: 1rem;
        }

        .empty-cart-message {
            text-align: center;
            padding: 4rem 0;
            color: #6b7280;
        }

        .empty-cart-message p {
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .navigation-links {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }
        .navigation-links a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }
        .navigation-links a:hover {
            text-decoration: underline;
        }

        /* Footer */
        .footer {
            background-color: #1f2937;
            color: #9ca3af;
            text-align: center;
            padding: 1.5rem 0;
            margin-top: 60px;
            width: 100%;
            font-size: 0.95rem;
        }
        @media (max-width: 768px) {
            .footer {
                padding: 1rem 0;
                font-size: 0.85rem;
                margin-top: 40px;
            }
        }
    </style>
</head>
<body>
    <header class="header-nav">
        <div class="logo">Online Bookstore</div>
        <nav class="nav-links">
            <a href="/"><i class="fas fa-home"></i>Home</a>
            <a href="/books/list"><i class="fas fa-book"></i>Books</a>
            <c:if test="${sessionScope.loggedInUser != null}">
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

    <main class="cart-container">
        <h1 class="text-4xl font-bold text-center mb-8">Your Shopping Cart</h1>

        <c:if test="${not empty message}">
            <div id="flashMessage" class="flash-message ${messageType}">
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart-message">
                    <p>Your cart is currently empty.</p>
                    <p class="mt-4"><a href="<c:url value='/'/>" class="btn btn-primary">Start Shopping</a></p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-table-wrapper">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th class="text-right">Price</th>
                                <th class="text-center">Quantity</th>
                                <th class="text-right">Subtotal</th>
                                <th class="text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${cartItems}">
                                <tr>
                                    <td>${item.book.title}</td>
                                    <td>${item.book.author}</td>
                                    <td class="text-right"><fmt:formatNumber value="${item.book.price}" type="currency" currencySymbol="₹" /></td>
                                    <td class="text-center">
                                        <form action="<c:url value='/cart/update'/>" method="post" class="flex items-center justify-center">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input" onchange="this.form.submit()">
                                        </form>
                                    </td>
                                    <td class="text-right"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₹" /></td>
                                    <td class="text-center">
                                        <form action="<c:url value='/cart/remove'/>" method="post" style="display:inline-block;">
                                            <input type="hidden" name="bookId" value="${item.book.id}">
                                            <button type="submit" class="btn btn-danger btn-sm"><i class="fas fa-trash-alt"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="cart-summary">
                    <div class="total-price">
                        Cart Total: <fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₹" />
                    </div>
                    <div class="actions">
                        <a href="<c:url value='/cart/clear'/>" class="btn btn-danger"><i class="fas fa-trash-restore-alt mr-2"></i>Clear Cart</a>
                        <a href="<c:url value='/checkout'/>" class="btn btn-success"><i class="fas fa-credit-card mr-2"></i>Proceed to Checkout</a>
                    </div>
                </div>
                
                <div class="navigation-links mt-8">
                    <a href="<c:url value='/'/>" class="text-blue-600 hover:underline">Continue Shopping</a>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const flashMessage = document.getElementById('flashMessage');
            if (flashMessage) {
                // Show the message
                flashMessage.classList.add('show');
                // Hide and remove after 5 seconds
                setTimeout(() => {
                    flashMessage.classList.remove('show');
                    flashMessage.addEventListener('transitionend', () => {
                        flashMessage.remove();
                    }, { once: true });
                }, 5000);
            }
        });
    </script>
</body>
</html>