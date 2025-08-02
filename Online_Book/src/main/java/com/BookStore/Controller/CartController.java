package com.BookStore.Controller;

import com.BookStore.Entity.Book;
import com.BookStore.Entity.Cart;
import com.BookStore.Entity.User;
import com.BookStore.Service.BookService;
import com.BookStore.Service.CartService;
import com.BookStore.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
public class CartController {

    private final CartService cartService;
    private final BookService bookService;
    private final UserService userService;

    @Autowired
    public CartController(CartService cartService, BookService bookService, UserService userService) {
        this.cartService = cartService;
        this.bookService = bookService;
        this.userService = userService;
    }

    @GetMapping("/cart")
    public String viewCart(Model model, Principal principal, HttpSession session) {
        Cart cart = getOrCreateCart(principal, session);
        cartService.calculateCartTotal(cart);
        model.addAttribute("cartItems", cart.getCartItems());
        model.addAttribute("cartTotal", cart.getTotalAmount());
        return "cart";
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("bookId") Long bookId,
                            @RequestParam(value = "quantity", defaultValue = "1") int quantity,
                            Principal principal, HttpSession session,
                            RedirectAttributes redirectAttributes) {
        try {
            if (quantity <= 0) {
                redirectAttributes.addFlashAttribute("message", "Quantity must be at least 1.");
                redirectAttributes.addFlashAttribute("messageType", "error");
                return "redirect:/books/list";
            }

            Book book = bookService.getBookById(bookId)
                    .orElseThrow(() -> new IllegalArgumentException("Book not found with ID: " + bookId));

            Cart cart = getOrCreateCart(principal, session);
            cartService.addBookToCart(cart, book, quantity);

            redirectAttributes.addFlashAttribute("message", book.getTitle() + " added to cart successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "An unexpected error occurred: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/books/list";
    }

    /**
     * Updates the quantity of a specific item in the cart.
     * The JSP sends the bookId and new quantity.
     */
    @PostMapping("/cart/update")
    public String updateCartItemQuantity(@RequestParam("bookId") Long bookId,
                                         @RequestParam("quantity") int quantity,
                                         Principal principal, HttpSession session,
                                         RedirectAttributes redirectAttributes) {
        try {
            Cart cart = getOrCreateCart(principal, session);
            // The service method now correctly expects the bookId
            cartService.updateCartItemQuantity(cart, bookId, quantity);
            redirectAttributes.addFlashAttribute("message", "Cart updated successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error updating cart: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/cart";
    }

    /**
     * Removes a specific item from the cart.
     * The JSP sends the bookId to be removed.
     */
    @PostMapping("/cart/remove")
    public String removeCartItem(@RequestParam("bookId") Long bookId,
                                 Principal principal, HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        try {
            Cart cart = getOrCreateCart(principal, session);
            // The service method now correctly expects the bookId
            cartService.removeBookFromCart(cart, bookId);
            redirectAttributes.addFlashAttribute("message", "Item removed from cart!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error removing item from cart: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/cart";
    }

    @GetMapping("/cart/clear")
    public String clearCart(Principal principal, HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            Cart cart = getOrCreateCart(principal, session);
            cartService.clearCart(cart);

            redirectAttributes.addFlashAttribute("message", "Your cart has been cleared successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "An error occurred while clearing the cart: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }

        return "redirect:/cart";
    }

    private Cart getOrCreateCart(Principal principal, HttpSession session) {
        Cart cart = null;

        if (principal != null) {
            User user = userService.findByUsername(principal.getName())
                    .orElseThrow(() -> new RuntimeException("Logged-in user not found in DB!"));
            cart = cartService.getCartByUser(user);

            final Cart finalCartForLambda = cart;

            Long sessionCartId = (Long) session.getAttribute("cartId");
            if (sessionCartId != null) {
                cartService.getCartById(sessionCartId).ifPresent(sessionCart -> {
                    if (!sessionCart.getId().equals(finalCartForLambda.getId())) {
                        cartService.mergeCarts(finalCartForLambda, sessionCart);
                    }
                    session.removeAttribute("cartId");
                });
            }
        } else {
            Long cartId = (Long) session.getAttribute("cartId");
            if (cartId != null) {
                cart = cartService.getCartById(cartId).orElse(null);
            }
        }

        if (cart == null) {
            cart = cartService.createCart();
            if (principal != null) {
                User user = userService.findByUsername(principal.getName())
                        .orElseThrow(() -> new RuntimeException("Logged-in user not found in DB!"));
                cart.setUser(user);
                cart = cartService.saveCart(cart);
            } else {
                session.setAttribute("cartId", cart.getId());
            }
        }
        return cart;
    }
}