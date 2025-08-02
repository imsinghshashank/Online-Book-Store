<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Essential for responsiveness -->
    <title>Online Bookstore - Books</title>
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
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }
        @media (max-width: 1200px) { /* Adjust max-width for smaller screens */
            .container {
                max-width: 95%;
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
            .message {
                padding: 1rem;
                font-size: 1rem;
            }
        }
        @media (max-width: 480px) {
            h1 {
                font-size: 1.8rem;
            }
        }

        /* Book grid responsiveness */
        .book-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            padding: 20px 0;
        }
        @media (max-width: 768px) { /* On medium screens and smaller */
            .book-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); /* Smaller min-width for cards */
                gap: 20px;
            }
            .book-card {
                padding-bottom: 1rem;
            }
            .book-card img {
                height: 200px; /* Adjust image height */
            }
            .book-details {
                padding: 0 0.8rem;
            }
            .book-title {
                font-size: 1.1rem;
                margin-bottom: 0.4rem;
            }
            .book-author {
                font-size: 0.9rem;
                margin-bottom: 0.5rem;
            }
            .book-price {
                font-size: 1.3rem;
                margin-top: 0.8rem;
                margin-bottom: 1rem;
            }
            .add-to-cart-btn {
                padding: 8px 15px;
                font-size: 0.9rem;
            }
        }
        @media (max-width: 480px) { /* On extra small screens */
            .book-grid {
                grid-template-columns: 1fr; /* Single column layout */
                gap: 15px;
            }
            .book-card img {
                height: 250px; /* Can be taller in single column */
            }
            .book-card {
                margin: 10px 0; /* More spacing for stacked cards */
            }
            .no-books {
                padding: 20px;
                font-size: 1.1rem;
            }
        }

        /* General styles */
        .book-card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding-bottom: 1.5rem;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        .book-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-bottom: 1px solid #e5e7eb;
            margin-bottom: 1rem;
        }
        .book-details {
            padding: 0 1rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 100%;
        }
        .book-title {
            font-weight: 700;
            color: #1f2937;
            font-size: 1.25rem;
            margin-bottom: 0.5rem;
            line-height: 1.3;
        }
        .book-author {
            color: #6b7280;
            font-size: 1rem;
            margin-bottom: 0.75rem;
        }
        .book-isbn, .book-stock {
            color: #9ca3af;
            font-size: 0.9rem;
            margin-bottom: 0.25rem;
        }
        .book-price {
            font-weight: 800;
            color: #059669;
            font-size: 1.5rem;
            margin-top: 1rem;
            margin-bottom: 1.25rem;
        }
        .no-books {
            text-align: center;
            padding: 40px;
            color: #6b7280;
            font-size: 1.25rem;
            background-color: #fcfcfc;
            border-radius: 10px;
            border: 1px dashed #e0e7ff;
            margin-top: 25px;
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
        .add-to-cart-btn {
            background-color: #f97316;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease, transform 0.1s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }
        .add-to-cart-btn:hover {
            background-color: #ea580c;
            transform: translateY(-2px);
        }
        .add-to-cart-btn:active {
            transform: translateY(0);
        }
        .add-to-cart-btn i {
            margin-right: 0.6rem;
            font-size: 1.1rem;
        }
        .out-of-stock-btn {
            background-color: #cbd5e1;
            color: #6b7280;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: not-allowed;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
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
    <a href="/orders/history" class="text-blue-600 hover:underline">Order History</a>
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
        <h1>Our Book Collection</h1>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">
                ${message}
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty books}">
                <div class="book-grid">
                    <c:forEach var="book" items="${books}">
                        <div class="book-card">
                            <img src="${book.imageUrl}" alt="${book.title} Cover">
                            <div class="book-details">
                                <div>
                                    <h3 class="book-title">${book.title}</h3>
                                    <p class="book-author">by ${book.author}</p>
                                </div>
                                <p class="book-price">₹${book.price}</p>
                                <div>
                                    <c:if test="${sessionScope.isUserLoggedIn}">
                                        <form action="/cart/add" method="post">
                                            <input type="hidden" name="bookId" value="${book.id}" />
                                            <input type="hidden" name="quantity" value="1" />
                                            <button type="submit" class="add-to-cart-btn">
                                                <i class="fas fa-cart-plus"></i> Add to Cart
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="no-books">No books available in the collection yet. Please check back later!</p>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>