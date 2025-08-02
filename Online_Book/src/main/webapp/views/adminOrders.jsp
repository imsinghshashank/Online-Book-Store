<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders - Online Bookstore Admin</title>
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

        /* Header Navigation */
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
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); /* Slightly deeper shadow */
            flex-grow: 1;
            border: 1px solid #e2e8f0; /* Subtle border */
        }
        @media (max-width: 1200px) { .container { max-width: 95%; margin: 30px auto; padding: 20px; } }
        @media (max-width: 768px) { .container { padding: 15px; } h1 { font-size: 2.2rem; margin-bottom: 20px; } }
        @media (max-width: 480px) { h1 { font-size: 1.8rem; } }

        h1 {
            font-size: 2.8rem; /* Larger heading */
            font-weight: 700;
            color: #1a202c; /* Darker heading color */
            margin-bottom: 28px;
            text-align: center;
            letter-spacing: -0.02em;
        }

        /* Message Alerts */
        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .message i {
            font-size: 1.2rem;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: separate; /* Use separate to allow border-radius on cells/rows */
            border-spacing: 0;
            margin-top: 25px;
            background-color: #fff;
            border-radius: 12px; /* Slightly more rounded */
            overflow: hidden; /* Ensures rounded corners */
            box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* More prominent shadow */
            border: 1px solid #e2e8f0; /* Subtle table border */
        }
        th, td {
            padding: 16px 20px; /* More padding */
            text-align: left;
            border-bottom: 1px solid #ebf4f5; /* Lighter border */
        }
        th {
            background-color: #f0f4f8; /* Lighter header background */
            font-weight: 600;
            color: #4a5568; /* Slightly darker grey */
            text-transform: uppercase;
            font-size: 0.95rem; /* Slightly larger font */
            letter-spacing: 0.05em;
        }
        tr:last-child td {
            border-bottom: none;
        }
        tbody tr:hover {
            background-color: #f8fcfd; /* Very subtle hover */
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04); /* Subtle shadow on hover */
            transform: translateY(-2px); /* Slight lift effect */
            transition: all 0.2s ease-in-out;
        }

        /* Action Links */
        .action-links a {
            color: #3b82f6; /* Blue for links */
            text-decoration: none;
            font-weight: 500;
            margin-right: 18px; /* More space */
            transition: color 0.2s ease, text-decoration 0.2s ease;
        }
        .action-links a:hover {
            color: #1d4ed8; /* Darker blue on hover */
            text-decoration: underline;
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex; /* Use flex for vertical alignment if needed */
            align-items: center;
            padding: 7px 12px; /* More padding */
            border-radius: 9999px; /* Pill shape */
            font-size: 0.8rem; /* Slightly smaller for compactness */
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .status-badge.PENDING { background-color: #fef3c7; color: #b45309; } /* Amber */
        .status-badge.PROCESSING { background-color: #bfdbfe; color: #1e40af; } /* Blue */
        .status-badge.SHIPPED { background-color: #d1fae5; color: #065f46; } /* Emerald */
        .status-badge.DELIVERED { background-color: #dcfce7; color: #166534; } /* Green */
        .status-badge.CANCELLED { background-color: #fee2e2; color: #991b1b; } /* Red */

        /* No Orders Message */
        .no-orders {
            text-align: center;
            padding: 50px; /* More padding */
            color: #6b7280;
            font-size: 1.35rem; /* Slightly larger */
            background-color: #fcfdfe;
            border-radius: 12px;
            border: 2px dashed #cbd5e1; /* More visible dashed border */
            margin-top: 30px;
            font-weight: 500;
        }

        /* Footer */
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
            <%-- Removed: <a href="/admin/books"><i class="fas fa-book"></i>Manage Books</a> --%>
            <%-- Removed: <a href="/admin/orders"><i class="fas fa-shipping-fast"></i>Manage Orders</a> --%>
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
        <h1>Manage Customer Orders</h1>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">
                <i class="fas <c:if test="${messageType == 'success'}">fa-check-circle</c:if><c:if test="${messageType == 'error'}">fa-exclamation-circle</c:if>"></i>
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty orders}">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Order Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>#<c:out value="${order.id}"/></td>
                                <td><c:out value="${order.user != null ? order.user.username : 'Guest'}"/></td> <%-- Handle guest orders if applicable --%>
                                <td><fmt:formatDate value="${order.legacyOrderDate}" pattern="MMM dd,yyyy HH:mm"/></td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₹"/></td>
                                <td>
                                    <span class="status-badge ${order.status}">${order.status}</span>
                                </td>
                                <td class="action-links">
                                    <a href="/admin/orders/${order.id}">View Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="no-orders">
                    <i class="fas fa-box-open mr-2"></i> No customer orders found at the moment.
                </p>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>