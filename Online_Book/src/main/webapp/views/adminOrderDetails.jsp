<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Online Bookstore Admin</title>
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

        /* Header Navigation - Consistent across admin pages */
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

        /* Main Container */
        .container {
            max-width: 1000px; /* Slightly wider container */
            margin: 50px auto;
            padding: 40px; /* Increased padding */
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); /* Deeper shadow */
            flex-grow: 1;
            border: 1px solid #e2e8f0; /* Subtle border */
        }
        @media (max-width: 900px) { .container { max-width: 95%; margin: 30px auto; padding: 25px; } }
        @media (max-width: 768px) { .container { padding: 20px; } h1 { font-size: 2.2rem; margin-bottom: 20px; } }
        @media (max-width: 480px) { h1 { font-size: 1.8rem; } }

        /* Page Title */
        h1 {
            font-size: 2.8rem; /* Larger heading */
            font-weight: 700;
            color: #1a202c; /* Darker heading color */
            margin-bottom: 30px; /* More space */
            text-align: center;
            letter-spacing: -0.03em;
        }

        /* Message Styles */
        .message {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 8px;
            font-weight: 500;
            text-align: center;
            border: 1px solid transparent;
        }
        .message.success {
            background-color: #e0f2f7; /* Tailwind light blue */
            color: #0e7490; /* Tailwind blue-700 */
            border-color: #a7d9e7;
        }
        .message.error {
            background-color: #fee2e2; /* Tailwind red-100 */
            color: #ef4444; /* Tailwind red-500 */
            border-color: #fca5a5;
        }

        /* Order Details Section */
        .order-details-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* Responsive columns */
            gap: 25px; /* More gap */
            margin-bottom: 40px; /* More space below */
        }
        .order-details-card {
            background-color: #fcfdfe; /* Lighter background */
            border: 1px solid #e2e8f0; /* Subtle border */
            border-radius: 12px; /* Slightly more rounded */
            padding: 25px; /* Increased padding */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); /* Subtle shadow */
            transition: transform 0.2s ease;
        }
        .order-details-card:hover {
            transform: translateY(-3px); /* Lift on hover */
        }
        .order-details-card h2 {
            font-size: 1.9rem; /* Larger sub-heading */
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 20px; /* More space */
            padding-bottom: 10px;
            border-bottom: 2px solid #edf2f7; /* Underline */
        }
        .detail-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0; /* More padding */
            border-bottom: 1px dashed #cbd5e1; /* Clearer dashed line */
            font-size: 1.05rem; /* Slightly smaller text for details */
        }
        .detail-item:last-child {
            border-bottom: none;
        }
        .detail-item span:first-child {
            font-weight: 500; /* Lighter weight for label */
            color: #4a5568; /* Darker grey */
        }
        .detail-item span:last-child { /* Value text */
            font-weight: 600;
            color: #2d3748;
        }

        /* Status Badge Styling */
        .status-badge {
            padding: 5px 12px;
            border-radius: 9999px; /* Fully rounded pill shape */
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: white; /* Default text color for badges */
        }
        .status-badge.PENDING { background-color: #f97316; /* Orange */ }
        .status-badge.PROCESSING { background-color: #3b82f6; /* Blue */ }
        .status-badge.SHIPPED { background-color: #8b5cf6; /* Purple */ }
        .status-badge.DELIVERED { background-color: #10b981; /* Emerald */ }
        .status-badge.CANCELLED { background-color: #ef4444; /* Red */ }

        /* Items Table */
        .items-table {
            width: 100%;
            border-collapse: separate; /* Use separate to control border-radius on cells */
            border-spacing: 0; /* Remove default spacing */
            margin-top: 30px; /* More space */
            border-radius: 12px; /* Rounded corners for the whole table */
            overflow: hidden; /* Ensures content respects border-radius */
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); /* Subtle shadow */
            background-color: #ffffff;
        }
        .items-table th, .items-table td {
            padding: 15px; /* More padding */
            text-align: left;
            border-bottom: 1px solid #edf2f7; /* Lighter border */
        }
        .items-table th {
            background-color: #e2e8f0; /* Lighter grey header */
            font-weight: 600;
            color: #2d3748; /* Darker text */
            text-transform: uppercase;
            font-size: 0.95rem; /* Slightly larger header text */
            letter-spacing: 0.02em;
        }
        .items-table tbody tr:last-child td {
            border-bottom: none; /* No border for the last row */
        }
        .items-table tbody tr:hover {
            background-color: #f7fafc; /* Very subtle hover */
        }

        /* Overall Total Section */
        .total-section {
            text-align: right;
            padding: 25px 0; /* More padding */
            font-size: 1.8rem; /* Larger font */
            font-weight: bold;
            color: #1a202c; /* Darker color */
            border-top: 3px solid #2c3e50; /* Thicker, matching header color border */
            margin-top: 25px; /* More margin */
        }

        /* Status Update Section */
        .status-update-section {
            background-color: #f0fdf4; /* Light green background */
            border: 1px solid #a7f3d0; /* Green border */
            border-radius: 12px; /* Rounded corners */
            padding: 30px; /* More padding */
            margin-top: 40px; /* More space */
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .status-update-section h2 {
            font-size: 1.7rem; /* Larger heading */
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 25px; /* More space */
        }
        .status-update-form {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px; /* More gap */
            align-items: center;
        }
        .status-update-section select {
            width: 100%;
            max-width: 350px; /* Wider select */
            padding: 12px 15px; /* More padding */
            border: 1px solid #a0aec0; /* Darker border */
            border-radius: 8px; /* Rounded corners */
            font-size: 1.05rem; /* Larger font */
            color: #2d3748;
            background-color: white;
            appearance: none; /* Remove default arrow */
            background-image: url('data:image/svg+xml;utf8,<svg fill="%232D3748" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>'); /* Custom arrow */
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .status-update-section select:focus {
            outline: none;
            border-color: #3b82f6; /* Blue focus border */
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }
        .status-update-section button {
            background-color: #0d9488; /* Teal color */
            color: white;
            padding: 14px 28px; /* More padding */
            border-radius: 8px;
            font-weight: 700;
            font-size: 1.05rem; /* Larger font */
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 10px rgba(13, 148, 136, 0.2); /* Subtle shadow */
        }
        .status-update-section button:hover {
            background-color: #0f766e; /* Darker teal on hover */
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(13, 148, 136, 0.3);
        }

        /* Back to All Orders Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 30px;
            color: #3b82f6; /* Blue link color */
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease, transform 0.2s ease;
        }
        .back-link:hover {
            color: #2563eb; /* Darker blue on hover */
            text-decoration: underline;
            transform: translateX(-5px); /* Slide left on hover */
        }

        /* Responsive adjustments for status update form */
        @media (max-width: 768px) {
            .status-update-form { flex-direction: column; }
            .status-update-section select { max-width: 100%; margin-right: 0; margin-bottom: 15px; }
            .status-update-section button { width: 100%; }
        }

        /* Footer - Consistent across admin pages */
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
        <div class="logo">Online Bookstore - Admin</div>
        <nav class="nav-links">
            <a href="/admin"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
            <a href="/admin/books"><i class="fas fa-book"></i>Manage Books</a>
            <a href="/admin/orders"><i class="fas fa-shipping-fast"></i>Manage Orders</a>
            <c:choose>
                <c:when test="${sessionScope.isAdminLoggedIn}">
                    <a href="/admin/logout"><i class="fas fa-user-shield"></i>Logout (Admin)</a>
                </c:when>
                <c:otherwise>
                    <a href="/admin/login"><i class="fas fa-user-shield"></i>Admin Login</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </header>

    <div class="container">
        <h1>Order Details #<c:out value="${order.id}"/></h1>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty order}">
                <div class="order-details-section">
                    <div class="order-details-card">
                        <h2>Order Information</h2>
                        <div class="detail-item">
                            <span>Order Date:</span>
                            <span><fmt:formatDate value="${order.legacyOrderDate}" pattern="MMM dd,yyyy hh:mm a"/></span>
                        </div>
                        <div class="detail-item">
                            <span>Customer:</span>
                            <span><c:out value="${order.user != null ? order.user.username : 'Guest'}"/></span>
                        </div>
                        <div class="detail-item">
                            <span>Current Status:</span>
                            <span class="status-badge ${order.status}">${order.status}</span>
                        </div>
                        <div class="detail-item">
                            <span>Payment Method:</span>
                            <span><c:out value="${order.paymentMethod}"/></span>
                        </div>
                        <div class="detail-item">
                            <span>Total Amount:</span>
                            <span><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₹" /></span>
                        </div>
                    </div>

                    <div class="order-details-card">
                        <h2>Shipping Information</h2>
                        <div class="detail-item">
                            <span>Full Name:</span>
                            <span><c:out value="${order.fullName}"/></span>
                        </div>
                        <div class="detail-item">
                            <span>Address:</span>
                            <span><c:out value="${order.shippingAddress}"/></span>
                        </div>
                        <div class="detail-item">
                            <span>City:</span>
                            <span><c:out value="${order.city}"/></span>
                        </div>
                        <div class="detail-item">
                            <span>Zip Code:</span>
                            <span><c:out value="${order.zipCode}"/></span>
                        </div>
                    </div>
                </div>

                <h2>Items in Order</h2>
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Book Title</th>
                            <th>Author</th>
                            <th>Qty</th>
                            <th>Price per unit</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.orderItems}">
                            <tr>
                                <td><c:out value="${item.book.title}"/></td>
                                <td><c:out value="${item.book.author}"/></td>
                                <td><c:out value="${item.quantity}"/></td>
                                <td><fmt:formatNumber value="${item.priceAtPurchase}" type="currency" currencySymbol="$" /></td>
                                <td><fmt:formatNumber value="${item.priceAtPurchase * item.quantity}" type="currency" currencySymbol="₹" /></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="total-section">
                    Overall Order Total: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₹" />
                </div>

                <div class="status-update-section">
                    <h2>Update Order Status</h2>
                    <form action="/admin/orders/updateStatus" method="post" class="status-update-form">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="orderId" value="${order.id}"/>
                        <select name="newStatus" required>
                            <option value="">Select New Status</option>
                            <option value="PENDING" <c:if test="${order.status == 'PENDING'}">selected</c:if>>Pending</option>
                            <option value="PROCESSING" <c:if test="${order.status == 'PROCESSING'}">selected</c:if>>Processing</option>
                            <option value="SHIPPED" <c:if test="${order.status == 'SHIPPED'}">selected</c:if>>Shipped</option>
                            <option value="DELIVERED" <c:if test="${order.status == 'DELIVERED'}">selected</c:if>>Delivered</option>
                            <option value="CANCELLED" <c:if test="${order.status == 'CANCELLED'}">selected</c:if>>Cancelled</option>
                        </select>
                        <button type="submit">Update Status</button>
                    </form>
                </div>

                <p class="mt-4 text-center">
                    <a href="/admin/orders" class="back-link"><i class="fas fa-arrow-left"></i> Back to All Orders</a>
                </p>

            </c:when>
            <c:otherwise>
                <p class="text-center text-red-500 text-lg">Order not found.</p>
                <p class="mt-4 text-center">
                    <a href="/admin/orders" class="back-link"><i class="fas fa-arrow-left"></i> Back to All Orders</a>
                </p>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>