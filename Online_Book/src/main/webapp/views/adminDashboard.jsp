<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Bookstore - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6; /* Light gray background */
            color: #374151; /* Dark gray text */
            margin: 0;
            line-height: 1.6;
            display: flex; /* Use flexbox for sticky footer */
            flex-direction: column; /* Arrange items vertically */
            min-height: 100vh; /* Ensure body takes full viewport height */
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
            margin-bottom: 0; /* Reset margin for responsive layout */
        }
        .header-nav .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap; /* Allow nav links to wrap */
            margin-top: 0; /* Reset margin for responsive layout */
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

        /* Main container responsiveness */
        .container {
            max-width: 1024px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            flex-grow: 1; /* Allow container to grow and push footer down */
        }
        @media (max-width: 1024px) { /* Adjust max-width for smaller screens */
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
                font-size: 2.2rem; /* Adjust heading size */
                margin-bottom: 20px;
            }
            h2 {
                font-size: 1.8rem;
                margin-bottom: 20px;
            }
            .card {
                padding: 1.5rem;
            }
            .submit-button {
                padding: 12px 24px;
                font-size: 1rem;
            }
            .message {
                padding: 1rem;
                font-size: 1rem;
            }
        }
        @media (max-width: 480px) {
            h1 {
                font-size: 1.8rem;
            }
            h2 {
                font-size: 1.5rem;
            }
            .card {
                padding: 1rem;
            }
            .form-group label {
                font-size: 0.95rem;
            }
            .form-group input {
                padding: 0.75rem;
                font-size: 0.9rem;
            }
        }

        /* Table responsiveness */
        .book-list-section {
            padding-top: 20px;
        }
        .table-responsive-wrapper { /* New wrapper for horizontal scroll */
            overflow-x: auto;
            -webkit-overflow-scrolling: touch; /* Smooth scrolling on iOS */
            border-radius: 10px; /* Match table border-radius */
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); /* Match table shadow */
            margin-top: 25px; /* Spacing above table */
        }
        .book-list-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            min-width: 700px; /* Ensure table has minimum width for scrolling on small screens */
        }
        .book-list-table th, .book-list-table td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        .book-list-table th {
            background-color: #f9fafb;
            font-weight: 700;
            color: #4b5563;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.025em;
        }
        .book-list-table tbody tr:last-child td {
            border-bottom: none;
        }
        .book-list-table tr:hover {
            background-color: #eef2f6;
        }
        .book-list-table .actions a {
            margin-right: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.2s ease-in-out;
            white-space: nowrap; /* Prevent breaking of action links */
        }
        .book-list-table .actions a.edit-link {
            color: #3b82f6;
        }
        .book-list-table .actions a.edit-link:hover {
            color: #1e40af;
        }
        .book-list-table .actions .delete-form button { /* Styling for the delete button inside the form */
            color: #ef4444;
            background-color: transparent;
            border: none;
            padding: 0;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none; /* remove default button underline */
            transition: color 0.2s ease-in-out;
            display: inline-flex; /* align icon and text */
            align-items: center;
        }
        .book-list-table .actions .delete-form button:hover {
            color: #b91c1c;
            text-decoration: underline; /* add underline on hover */
        }
        .book-list-table .actions .delete-form button i {
            margin-right: 0.5rem;
        }
        .book-list-table img {
            width: 60px;
            height: auto;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .no-books-admin {
            text-align: center;
            padding: 30px;
            color: #6b7280;
            font-size: 1.25rem;
            background-color: #fcfcfc;
            border-radius: 10px;
            border: 1px dashed #e0e7ff;
            margin-top: 25px;
        }

        /* General styles */
        h1 {
            color: #1f2937;
            font-size: 2.8rem;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 700;
        }
        h2 {
            font-size: 2.2rem;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
            color: #1f2937;
        }
        .card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            padding: 2.5rem;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 1.25rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.6rem;
            font-weight: 600;
            color: #4b5563;
            font-size: 1.05rem;
        }
        .form-group input[type="text"],
        .form-group input[type="number"] {
            width: 100%;
            padding: 0.9rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 1.05rem;
            box-sizing: border-box;
            transition: all 0.2s ease-in-out;
        }
        .form-group input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.2);
        }
        .submit-button {
            background-color: #2563eb;
            color: white;
            padding: 14px 30px;
            border-radius: 10px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease, transform 0.1s ease;
            font-size: 1.1rem;
            width: auto;
            display: block;
            margin: 2rem auto 0 auto;
        }
        .submit-button:hover {
            background-color: #1e40af;
            transform: translateY(-2px);
        }
        .submit-button:active {
            transform: translateY(0);
        }
        .message {
            padding: 1.25rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            font-weight: 600;
            text-align: center;
            font-size: 1.1rem;
        }
        .message.success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #34d399;
        }
        .message.error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #f87171;
        }
        .footer {
            background-color: #1f2937;
            color: #9ca3af;
            text-align: center;
            padding: 1.5rem 0;
            margin-top: auto; /* Push footer to the bottom */
            width: 100%;
            font-size: 0.95rem;
        }

        /* Dashboard Quick Links Styles */
        .dashboard-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
            text-align: center;
        }
        .dashboard-links .link-card {
            background-color: #e0f2fe; /* Light blue */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            text-decoration: none;
            color: #1e3a8a; /* Darker blue text */
            font-weight: 600;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .dashboard-links .link-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.12);
        }
        .dashboard-links .link-card i {
            font-size: 3.5rem;
            margin-bottom: 15px;
            color: #2563eb; /* Blue icon */
        }
        .dashboard-links .link-card span {
            font-size: 1.5rem;
        }
        @media (max-width: 768px) {
            .dashboard-links {
                grid-template-columns: 1fr; /* Stack links on small screens */
            }
            .dashboard-links .link-card i {
                font-size: 3rem;
            }
            .dashboard-links .link-card span {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <header class="header-nav">
        <div class="logo">Online Bookstore</div>
        <nav class="nav-links">
            <%-- Admin Navigation Links (always visible when Admin is logged in) --%>
            <c:if test="${sessionScope.isAdminLoggedIn}">
                <a href="/admin"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                <%-- Removed: <a href="/admin/books"><i class="fas fa-book"></i>Manage Books</a> --%>
                <%-- Removed: <a href="/admin/orders"><i class="fas fa-shipping-fast"></i>Manage Orders</a> --%>
                <a href="/admin/logout"><i class="fas fa-user-shield"></i>Logout (Admin)</a>
            </c:if>

            <%-- User/General Navigation Links (visible only if NOT an admin) --%>
            <c:if test="${!sessionScope.isAdminLoggedIn}">
                <a href="/"><i class="fas fa-home"></i>Home</a>
                <a href="/books/list"><i class="fas fa-book"></i>Books</a>
                <c:if test="${sessionScope.isUserLoggedIn}">
                    <a href="/cart"><i class="fas fa-shopping-cart"></i>Cart</a>
                    <a href="/myorders"><i class="fas fa-history"></i>My Orders</a>
                </c:if>
                <c:choose>
                    <c:when test="${sessionScope.isUserLoggedIn}">
                        <a href="/logout"><i class="fas fa-sign-out-alt"></i>Logout (<c:out value="${sessionScope.loggedInUser.username}"/>)</a>
                    </c:when>
                    <c:otherwise>
                        <a href="/login"><i class="fas fa-sign-in-alt"></i>Login</a>
                        <a href="/signup"><i class="fas fa-user-plus"></i>Sign Up</a>
                        <a href="/admin/login"><i class="fas fa-user-shield"></i>Admin Login</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </nav>
    </header>

    <div class="container">
        <h1>Admin Dashboard</h1>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">
                ${message}
            </div>
        </c:if>

        <div class="dashboard-links">
            <a href="<c:url value='/admin/books'/>" class="link-card">
                <i class="fas fa-book-open"></i>
                <span>Manage Books</span>
            </a>
            <a href="<c:url value='/admin/orders'/>" class="link-card">
                <i class="fas fa-list-alt"></i>
                <span>Manage Orders</span>
            </a>
            <%-- Add more quick links here as your admin features grow --%>
        </div>


        <div class="card">
            <h2>Add New Book</h2>
            <form action="<c:url value='/admin/addBook'/>" method="post">
                <%-- IMPORTANT: CSRF Token for Spring Security --%>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="form-group">
                    <label for="title">Title:</label>
                    <input name="title" id="title" type="text" required="true" placeholder="Enter book title" />
                </div>
                <div class="form-group">
                    <label for="author">Author:</label>
                    <input name="author" id="author" type="text" required="true" placeholder="Enter author's name" />
                </div>
                <div class="form-group">
                    <label for="price">Price (₹):</label>
                    <input name="price" id="price" type="number" step="0.01" required="true" placeholder="e.g., 29.99" />
                </div>
                <div class="form-group">
                    <label for="imageUrl">Image URL:</label>
                    <input name="imageUrl" id="imageUrl" type="text" placeholder="e.g., http://example.com/book-cover.jpg" />
                </div>
                <div class="form-group">
                    <label for="stock">Stock:</label>
                    <input name="stock" id="stock" type="number" required="true" min="0" value="0" placeholder="e.g., 100" />
                </div>
                <button type="submit" class="submit-button">
                    <i class="fas fa-plus-circle"></i> Add Book
                </button>
            </form>
        </div>

        <div class="card book-list-section">
            <h2>Existing Books</h2>
            <c:choose>
                <c:when test="${not empty books}">
                    <div class="table-responsive-wrapper">
                        <table class="book-list-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Author</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="book" items="${books}">
                                    <tr>
                                        <td>${book.id}</td>
                                    <td><img src="${book.imageUrl}" alt="${book.title} Cover" class="book-cover-thumbnail"></td>
                                        <td>${book.title}</td>
                                        <td>${book.author}</td>
                                        <td>₹${book.price}</td>
                                        <td>${book.stock}</td>
                                        <td class="actions">
                                            <a href="<c:url value='/admin/edit/${book.id}'/>" class="edit-link"><i class="fas fa-edit"></i> Edit</a>
                                            <%-- UPDATED DELETE LINK TO BE A FORM --%>
                                            <form action="<c:url value='/admin/delete'/>" method="post" class="inline-block" onsubmit="return confirm('Are you sure you want to delete \'${book.title}\'?');">
                                                <input type="hidden" name="id" value="${book.id}"/>
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="delete-form-button"><i class="fas fa-trash-alt"></i> Delete</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="no-books-admin">No books in the database yet. Add one using the form above!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>