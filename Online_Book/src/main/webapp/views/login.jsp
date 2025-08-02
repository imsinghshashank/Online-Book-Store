<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Essential for responsiveness -->
    <title>User Login - Online Bookstore</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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
            flex-wrap: wrap; /* Allow navigation items to wrap on smaller screens */
        }
        .header-nav .logo {
            font-size: 2rem;
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

        /* Login container responsiveness */
        .login-container {
            max-width: 400px;
            margin: auto;
            padding: 24px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center; /* Center text inside container */
        }
        @media (max-width: 768px) {
            .login-container {
                max-width: 85%; /* Adjust max-width for smaller screens */
                padding: 20px;
            }
            h1 {
                font-size: 2.2rem;
                margin-bottom: 20px;
            }
        }
        @media (max-width: 480px) {
            .login-container {
                max-width: 90%;
                padding: 15px;
            }
            h1 {
                font-size: 1.8rem;
            }
            .form-group label {
                font-size: 0.95rem;
            }
            .form-group input {
                padding: 0.75rem;
                font-size: 0.9rem;
            }
            .submit-button {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
        }

        /* General styles */
        h1 {
            color: #1f2937;
            font-size: 2.5rem;
            margin-bottom: 24px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 1rem;
            width: 100%;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #4b5563;
        }
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        .form-group input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.25);
        }
        .submit-button {
            background-color: #2563eb;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }
        .submit-button:hover {
            background-color: #1e40af;
        }
        .message {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-weight: 600;
            text-align: center;
            width: 100%;
        }
        .message.success {
            background-color: #d1fae5;
            color: #065f46;
        }
        .message.error {
            background-color: #fee2e2;
            color: #991b1b;
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

    <div class="login-container">
        <h1>User Login</h1>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">
                ${message}
            </div>
        </c:if>

        <c:if test="${!sessionScope.isAdminLoggedIn && !sessionScope.isUserLoggedIn}">
            <form action="/login" method="post" class="w-full max-w-sm">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="submit-button">Log In</button>
            </form>
            <p class="mt-4 text-center">Don't have an account? <a href="/signup" class="text-blue-600 hover:underline">Sign Up</a></p>
        </c:if>
        <c:if test="${sessionScope.isUserLoggedIn}">
            <p class="text-center text-lg text-gray-700">You are already logged in as <c:out value="${sessionScope.loggedInUser.username}"/>. Please log out to access other login options.</p>
             <p class="mt-4 text-center">
                <a href="/logout" class="text-blue-600 hover:underline">Logout (<c:out value="${sessionScope.loggedInUser.username}"/>)</a>
            </p>
        </c:if>
        <c:if test="${sessionScope.isAdminLoggedIn && !sessionScope.isUserLoggedIn}">
            <p class="text-center text-lg text-gray-700">You are logged in as an administrator. Please log out of your admin session to access user functionalities.</p>
             <p class="mt-4 text-center">
                <a href="/admin/logout" class="text-blue-600 hover:underline">Logout Admin</a>
            </p>
        </c:if>
    </div>

    <footer class="footer">
        <p>&copy; 2025 Online Bookstore. All rights reserved.</p>
    </footer>
</body>
</html>