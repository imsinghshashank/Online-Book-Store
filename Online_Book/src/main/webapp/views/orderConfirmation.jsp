<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed! - Online Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* Base styles */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc; /* Lighter background */
            color: #374151;
            margin: 0;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header Navigation - Reusing enhanced styles from admin page */
        .header-nav {
            background-color: #2c3e50; /* Darker, more professional blue-grey */
            color: #ecf0f1;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .header-nav .logo {
            font-size: 1.6rem;
            font-weight: 700;
            color: #ecf0f1;
        }
        .header-nav .nav-links {
            display: flex;
            gap: 1.5rem;
        }
        .header-nav .nav-links a {
            color: #ecf0f1;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 0.8rem;
            border-radius: 6px;
            transition: background-color 0.3s ease, color 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .header-nav .nav-links a:hover {
            background-color: #34495e; /* Slightly lighter hover */
            color: #ffffff;
        }
        .header-nav .nav-links a i {
            margin-right: 0.3rem;
        }

        /* Responsive Header */
        @media (max-width: 768px) {
            .header-nav {
                flex-direction: column;
                align-items: flex-start;
                padding: 1rem;
            }
            .header-nav .nav-links {
                flex-direction: column;
                width: 100%;
                gap: 0.5rem;
                margin-top: 1rem;
            }
            .header-nav .nav-links a {
                padding: 0.75rem 1rem;
                width: 100%;
                justify-content: flex-start;
            }
            .header-nav .logo {
                margin-bottom: 0.5rem;
                text-align: center;
                width: 100%;
            }
        }
        @media (max-width: 480px) {
            .header-nav .logo { font-size: 1.4rem; }
            .header-nav { padding: 0.75rem; }
        }

        /* Confirmation Container */
        .confirmation-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px; /* Increased padding */
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); /* Slightly deeper shadow */
            text-align: center;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 1px solid #e2e8f0; /* Subtle border */
        }
        @media (max-width: 768px) {
            .confirmation-container { padding: 25px; margin: 30px auto; max-width: 95%; }
            .confirmation-icon { font-size: 4rem; margin-bottom: 15px; }
            .confirmation-container h1 { font-size: 2.2rem; }
            .confirmation-container p { font-size: 1rem; }
            .confirmation-details { padding-top: 15px; }
            .confirmation-details p { font-size: 1rem; }
            .order-summary-list { margin: 15px 0; padding-top: 10px; }
            .order-summary-item { font-size: 0.9rem; margin-bottom: 6px; }
            .total-amount { font-size: 1.3rem; margin-top: 10px; padding-top: 10px; }
            .btn-group { margin-top: 30px; gap: 10px; }
            .btn { padding: 10px 20px; font-size: 0.9rem; }
        }
        @media (max-width: 480px) {
            .confirmation-container { padding: 15px; }
            .confirmation-icon { font-size: 3rem; }
            .confirmation-container h1 { font-size: 1.8rem; }
            .confirmation-container p { font-size: 0.9rem; }
            .confirmation-details p { font-size: 0.9rem; }
            .total-amount { font-size: 1.1rem; }
            .btn { padding: 8px 15px; font-size: 0.85rem; }
        }

        .confirmation-icon {
            font-size: 5.5rem; /* Slightly larger icon */
            color: #10b981; /* Tailwind emerald-500 */
            margin-bottom: 25px;
            animation: bounceIn 0.8s ease-out; /* Subtle animation */
        }
        @keyframes bounceIn {
            0% { transform: scale(0.1); opacity: 0; }
            60% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }

        .confirmation-container h1 {
            font-size: 3.2rem; /* Larger heading */
            font-weight: 700;
            color: #1a202c; /* Darker heading color */
            margin-bottom: 15px;
            letter-spacing: -0.03em;
        }
        .confirmation-container p {
            font-size: 1.25rem; /* Slightly larger paragraph text */
            color: #4a5568; /* Darker grey */
            margin-bottom: 12px;
        }
        .confirmation-container p span { /* For Order ID */
            font-weight: 700;
            color: #1a202c;
            font-size: 1.3rem;
            letter-spacing: 0.02em;
        }

        /* Confirmation Details Section */
        .confirmation-details {
            text-align: left;
            margin-top: 40px; /* More space */
            border-top: 1px dashed #cbd5e1; /* Clearer dashed line */
            padding-top: 30px; /* More padding */
            width: 100%;
            max-width: 550px; /* Slightly wider */
        }
        .confirmation-details h2 {
            font-size: 1.8rem; /* Larger sub-heading */
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 20px;
            border-bottom: 2px solid #edf2f7; /* Underline for heading */
            padding-bottom: 10px;
        }
        .confirmation-details h3 {
            font-size: 1.5rem; /* Larger sub-sub-heading */
            font-weight: 600;
            color: #2d3748;
            margin-top: 30px; /* More space above */
            margin-bottom: 15px;
        }
        .confirmation-details p {
            font-size: 1.1rem;
            margin-bottom: 10px;
            color: #4a5568;
        }
        .confirmation-details p span {
            font-weight: 600;
            color: #1f2937;
        }

        /* Order Summary List */
        .order-summary-list {
            list-style: none;
            padding: 0;
            margin: 25px 0; /* More margin */
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0; /* Add bottom border */
            padding: 15px 0; /* More padding */
            background-color: #fcfdfe; /* Subtle background */
            border-radius: 8px; /* Slightly rounded */
        }
        .order-summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px; /* More space between items */
            padding: 5px 15px; /* Padding for list items */
            font-size: 1.05rem;
            color: #4b5563;
        }
        .order-summary-item:last-child {
            margin-bottom: 0;
        }
        .order-summary-item span:first-child {
            font-weight: 500;
            color: #374151;
        }

        /* Total Amount */
        .total-amount {
            font-size: 1.7rem; /* Larger total amount */
            font-weight: bold;
            color: #1a202c;
            margin-top: 25px; /* More margin */
            padding-top: 20px; /* More padding */
            border-top: 3px solid #2c3e50; /* Thicker, matching header color border */
            display: flex;
            justify-content: space-between;
        }

        /* Buttons */
        .btn-group {
            margin-top: 50px; /* More space below details */
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px; /* More gap between buttons */
        }
        .btn {
            background-color: #3b82f6; /* Brighter blue */
            color: white;
            padding: 14px 30px; /* More padding */
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.05rem; /* Slightly larger text */
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 10px rgba(59, 130, 246, 0.2); /* Subtle shadow for primary button */
        }
        .btn:hover {
            background-color: #2563eb; /* Darker blue on hover */
            transform: translateY(-3px); /* More pronounced lift */
            box-shadow: 0 6px 15px rgba(59, 130, 246, 0.3);
        }
        /* No btn-secondary styles needed if "View My Orders" is removed */
        .btn i {
            margin-right: 10px; /* More space for icon */
            font-size: 1.15rem; /* Larger icon */
        }

        /* Footer - Reusing enhanced styles from admin page */
        .footer {
            margin-top: auto; /* Pushes footer to the bottom */
            padding: 2rem;
            background-color: #34495e; /* Matches header for consistency */
            color: #ecf0f1;
            text-align: center;
            font-size: 0.9rem;
            box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.05);
        }
        @media (max-width: 768px) { .footer { padding: 1.5rem; } }
    </style>
</head>
<body>
    <header class="header-nav">
        <div class="logo">Online Bookstore</div>
        <nav class="nav-links">
            <a href="/"><i class="fas fa-home"></i>Home</a>
            <a href="/books/list"><i class="fas fa-book"></i>Books</a>
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

    <div class="confirmation-container">
        <i class="fas fa-check-circle confirmation-icon"></i>
        <h1>Order Confirmed!</h1>
        <p>Thank you for your purchase. Your order has been successfully placed.</p>
        <p>Your Order ID is: <span>#<c:out value="${order.id}"/></span></p>

        <div class="confirmation-details">
            <h2>Order Details</h2>
            <p>Order Date: <span><fmt:formatDate value="${order.legacyOrderDate}" pattern="MMM dd,yyyy hh:mm a"/></span></p>
            <p>Payment Method: <span><c:out value="${order.paymentMethod}"/></span></p>
            <p>Shipping Address: <span><c:out value="${order.shippingAddress}"/>, <c:out value="${order.city}"/> - <c:out value="${order.zipCode}"/></span></p>

            <h3>Items Ordered:</h3>
            <ul class="order-summary-list">
                <c:forEach var="item" items="${order.orderItems}">
                    <li class="order-summary-item">
                        <span><c:out value="${item.book.title}"/> x <c:out value="${item.quantity}"/></span>
                        <span><fmt:formatNumber value="${item.priceAtPurchase * item.quantity}" type="currency" currencySymbol="$" /></span>
                    </li>
                </c:forEach>
            </ul>
            <div class="total-amount">
                <span>Order Total:</span>
                <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$" /></span>
            </div>
        </div>

        <div class="btn-group">
            <a href="/books/list" class="btn"><i class="fas fa-book"></i>Continue Shopping</a>
            <%-- Removed the "View My Orders" button --%>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>