<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Online Bookstore - Home</title>
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

        /* Hero Section */
        .hero-section {
            position: relative;
            text-align: center;
            padding: 100px 20px;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.6)), url('https://source.unsplash.com/1600x900/?books,library') no-repeat center center / cover;
            color: white;
            margin-bottom: 50px;
            overflow: hidden;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.4);
            z-index: 1;
        }
        .hero-section > * {
            position: relative;
            z-index: 2;
        }
        .hero-section h1 {
            font-size: 4.5rem;
            font-weight: bold;
            margin-bottom: 20px;
            line-height: 1.1;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
        }
        .hero-section p {
            font-size: 1.8rem;
            margin-bottom: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.4);
        }
        .hero-button {
            background-color: #2563eb;
            color: white;
            padding: 18px 40px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            transition: background-color 0.3s ease, transform 0.2s ease;
            font-size: 1.25rem;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }
        .hero-button:hover {
            background-color: #1e40af;
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
        .hero-button:active {
            transform: translateY(0);
        }
        .hero-button i {
            margin-left: 1rem;
            font-size: 1.3rem;
        }

        /* Responsive adjustments for hero section */
        @media (max-width: 1024px) {
            .hero-section {
                padding: 80px 20px;
            }
            .hero-section h1 {
                font-size: 3.5rem;
            }
            .hero-section p {
                font-size: 1.5rem;
            }
            .hero-button {
                padding: 15px 30px;
                font-size: 1.1rem;
            }
        }
        @media (max-width: 768px) {
            .hero-section {
                padding: 60px 15px;
                margin-bottom: 30px;
            }
            .hero-section h1 {
                font-size: 2.8rem;
            }
            .hero-section p {
                font-size: 1.2rem;
            }
            .hero-button {
                padding: 12px 25px;
                font-size: 1rem;
            }
        }
        @media (max-width: 480px) {
            .hero-section {
                padding: 40px 10px;
            }
            .hero-section h1 {
                font-size: 2rem;
            }
            .hero-section p {
                font-size: 1rem;
            }
            .hero-button {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
            .hero-button i {
                margin-left: 0.8rem;
                font-size: 1rem;
            }
        }

        /* Features Section */
        .features-section {
            max-width: 1200px;
            margin: 0 auto 60px auto;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            text-align: center;
            padding: 0 20px;
        }
        .feature-card {
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
            margin: 20px;
            flex: 1 1 calc(33.33% - 40px); /* Adjust calculation for new margin */
            min-width: 280px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.15);
        }
        .feature-card i {
            font-size: 3.5rem;
            color: #2563eb;
            margin-bottom: 25px;
        }
        .feature-card h3 {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 15px;
            color: #1f2937;
        }
        .feature-card p {
            font-size: 1.1rem;
            color: #4b5563;
        }

        /* Responsive adjustments for feature cards */
        @media (max-width: 1024px) {
            .feature-card {
                flex: 1 1 calc(50% - 40px); /* Two columns on medium screens */
                margin: 15px;
                padding: 30px;
            }
            .features-section {
                gap: 0; /* Reset gap to use card margins */
            }
            .feature-card h3 {
                font-size: 1.7rem;
            }
            .feature-card p {
                font-size: 1rem;
            }
            .feature-card i {
                font-size: 3rem;
                margin-bottom: 20px;
            }
        }
        @media (max-width: 768px) {
            .feature-card {
                flex: 1 1 90%; /* Single column on small screens */
                margin: 10px auto; /* Center single column */
                padding: 25px;
            }
            .features-section {
                margin-bottom: 40px;
                padding: 0 10px;
            }
        }
        @media (max-width: 480px) {
            .feature-card {
                padding: 20px;
                margin: 10px auto;
            }
            .feature-card i {
                font-size: 2.5rem;
                margin-bottom: 15px;
            }
            .feature-card h3 {
                font-size: 1.5rem;
            }
            .feature-card p {
                font-size: 0.9rem;
            }
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

    <main>
        <c:if test="${not empty message}">
            <div id="flashMessage" class="flash-message ${messageType}">
                ${message}
            </div>
        </c:if>

        <section class="hero-section">
            <h1>
                Welcome to Our Online Bookstore!<br>
                Your Next Great Read Awaits.
            </h1>
            <p>
                Dive into a world of captivating stories, insightful knowledge,
                and endless adventures.
            </p>
            <a href="/books/list" class="hero-button">
                Browse Our Collection <i class="fas fa-arrow-right"></i>
            </a>
        </section>

        <section class="features-section">
            <div class="feature-card">
                <i class="fas fa-search"></i>
                <h3>Vast Selection</h3>
                <p>Explore thousands of titles across all genres, from bestsellers to hidden gems.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-shipping-fast"></i>
                <h3>Fast Delivery</h3>
                <p>Get your favorite books delivered right to your doorstep with our speedy service.</p>
            </div>
            <div class="feature-card">
                <i class="fa-solid fa-indian-rupee-sign"></i>
                <h3>Great Prices</h3>
                <p>Enjoy competitive pricing, exclusive deals, and fantastic value on every purchase.</p>
            </div>
        </section>
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
                    // Optional: remove element from DOM after transition completes
                    flashMessage.addEventListener('transitionend', () => {
                        flashMessage.remove();
                    }, { once: true }); // Use { once: true } to ensure listener runs only once
                }, 5000); // 5000 milliseconds = 5 seconds
            }
        });
    </script>
</body>
</html>