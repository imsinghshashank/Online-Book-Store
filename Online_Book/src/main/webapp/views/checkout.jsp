<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Online Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Your existing CSS styles go here. Make sure they are correctly overriding or complementing Tailwind. */
        /* For brevity, I'm omitting the large style block here, but it should be present in your file. */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
            color: #374151;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            line-height: 1.6;
        }
        .header-nav {
            background-color: #1f2937;
            padding: 1.25rem 2.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }
        .header-nav .logo {
            font-size: 2rem;
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

        .container {
            max-width: 960px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        @media (max-width: 960px) {
            .container {
                max-width: 90%;
                margin: 30px auto;
                padding: 20px;
            }
        }
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            h1 {
                font-size: 2.2rem;
                margin-bottom: 20px;
            }
        }
        @media (max-width: 480px) {
            h1 {
                font-size: 1.8rem;
            }
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }
        @media (max-width: 768px) {
            .checkout-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            .shipping-details-section, .order-summary-section {
                padding: 1.5rem;
            }
            .shipping-details-section h2, .order-summary-section h2 {
                font-size: 1.6rem;
                margin-bottom: 1rem;
            }
            .form-group label {
                font-size: 0.95rem;
            }
            .form-group input, .form-group textarea {
                padding: 0.75rem;
                font-size: 0.9rem;
            }
            .place-order-btn {
                padding: 12px 24px;
                font-size: 1rem;
            }
            .order-summary-item {
                font-size: 0.95rem;
            }
            .order-summary-total {
                font-size: 1.25rem;
            }
        }
        @media (max-width: 480px) {
            .shipping-details-section, .order-summary-section {
                padding: 1rem;
            }
            .shipping-details-section h2, .order-summary-section h2 {
                font-size: 1.4rem;
            }
            .order-summary-item {
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 8px;
                padding-bottom: 8px;
            }
            .order-summary-item span:first-child {
                margin-bottom: 5px;
            }
        }

        h1 {
            color: #1f2937;
            font-size: 2.5rem;
            margin-bottom: 24px;
            text-align: center;
        }
        .shipping-details-section, .order-summary-section {
            padding: 20px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            background-color: #f9fafb;
        }
        .shipping-details-section h2, .order-summary-section h2 {
            font-size: 1.8rem;
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #4b5563;
        }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="number"], /* Added for zipCode */
        .form-group select, /* Added for paymentMethod */
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus { /* Added select */
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
        }
        .place-order-btn {
            background-color: #10b981;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 1.5rem;
        }
        .place-order-btn:hover {
            background-color: #059669;
        }
        .order-summary-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .order-summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #e5e7eb;
        }
        .order-summary-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        .order-summary-item span:first-child {
            font-weight: 500;
            color: #4b5563;
        }
        .order-summary-total {
            display: flex;
            justify-content: space-between;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 2px solid #374151;
            font-size: 1.5rem;
            font-weight: bold;
            color: #1f2937;
        }
        .footer {
            background-color: #1f2937;
            color: #9ca3af;
            text-align: center;
            padding: 1rem 0;
            margin-top: auto;
            width: 100%;
        }
        @media (max-width: 768px) {
            .footer {
                padding: 1rem 0;
                font-size: 0.85rem;
                margin-top: 30px;
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
        <h1>Checkout</h1>

        <%-- Display messages from RedirectAttributes --%>
        <c:if test="${not empty message}">
            <div class="<c:choose><c:when test='${messageType == "success"}'>bg-green-100 text-green-800</c:when><c:otherwise>bg-red-100 text-red-800</c:otherwise></c:choose> p-3 rounded-lg text-center mb-4">
                ${message}
            </div>
        </c:if>

        <div class="checkout-grid">
            <section class="shipping-details-section">
                <h2>Shipping Details</h2>
                <form action="/checkout/placeOrder" method="post">
                    <div class="form-group">
                        <label for="fullName">Full Name:</label>
                        <input type="text" id="fullName" name="fullName" required
                            <c:if test="${not empty user.username}">
                                value="${user.username}"
                            </c:if>
                        >
                    </div>
                    <%-- Removed email as it's not expected by placeOrder controller method --%>
                    <%-- If you need email, add it to the controller's @RequestParam --%>

                    <div class="form-group">
                        <label for="address">Shipping Address:</label>
                        <textarea id="address" name="address" rows="4" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="city">City:</label>
                        <input type="text" id="city" name="city" required>
                    </div>

                    <div class="form-group">
                        <label for="zipCode">Zip Code:</label>
                        <input type="text" id="zipCode" name="zipCode" pattern="[0-9]{5,}" title="Zip Code must be at least 5 digits" required>
                        <%-- Changed type to text and added pattern for better flexibility with zip codes --%>
                    </div>

                    <div class="form-group">
                        <label for="paymentMethod">Payment Method:</label>
                        <select id="paymentMethod" name="paymentMethod" required class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <option value="">Select a payment method</option>
                            <option value="COD">Cash on Delivery (COD)</option>
                            <option value="Card">Credit/Debit Card (Simulated)</option>
                            <option value="PayPal">PayPal (Simulated)</option>
                        </select>
                    </div>

                    <button type="submit" class="place-order-btn">
                        <i class="fas fa-truck"></i> Place Order
                    </button>
                </form>
            </section>

            <section class="order-summary-section">
                <h2>Order Summary</h2>
                <ul class="order-summary-list">
                    <c:forEach var="item" items="${cartItems}">
                        <li class="order-summary-item">
                            <%-- Display quantity and title --%>
                            <span>${item.book.title} x ${item.quantity}</span>
                            <%-- Format subtotal as currency --%>
                            <span><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₹" /></span>
                        </li>
                    </c:forEach>
                </ul>
                <div class="order-summary-total">
                    <span>Total:</span>
                    <%-- Format cartTotal as currency --%>
                    <span><fmt:formatNumber value="${cartTotal}" type="currency" currencySymbol="₹" /></span>
                </div>
                <p class="text-sm text-gray-500 mt-4 text-center">
                    Note: This is a simulated checkout. No real payment will be processed.
                </p>
            </section>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>