package com.BookStore.Controller;

import com.BookStore.Entity.Cart;
import com.BookStore.Entity.User;
import com.BookStore.Entity.Order;
import com.BookStore.Service.BookService;
import com.BookStore.Service.CartService;
import com.BookStore.Service.OrderService;
import com.BookStore.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping("/checkout")
public class CheckoutController {

    private static final Logger logger = LoggerFactory.getLogger(CheckoutController.class);

    private final CartService cartService;
    private final OrderService orderService;
    private final UserService userService;
    private final BookService bookService;

    @Autowired
    public CheckoutController(CartService cartService, OrderService orderService, UserService userService, BookService bookService) {
        this.cartService = cartService;
        this.orderService = orderService;
        this.userService = userService;
        this.bookService = bookService;
    }

    @GetMapping
    public String showCheckoutForm(Model model, Principal principal, HttpSession session, RedirectAttributes redirectAttributes) {
        logger.info("--- Entering showCheckoutForm method for /checkout GET request ---");

        Cart cart = getOrCreateCart(principal, session);

        if (cart.getCartItems().isEmpty()) {
            logger.warn("Cart is EMPTY for user {}. Redirecting to /cart.", principal != null ? principal.getName() : "anonymous");
            redirectAttributes.addFlashAttribute("message", "Your cart is empty. Please add items before checking out.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/cart";
        }
        
        cartService.calculateCartTotal(cart);

        logger.info("Cart has {} items for user {}. Cart total: ${}", cart.getCartItems().size(), principal != null ? principal.getName() : "anonymous", cart.getTotalAmount());

        model.addAttribute("cartItems", cart.getCartItems());
        model.addAttribute("cartTotal", cart.getTotalAmount());

        if (principal != null) {
            User loggedInUser = userService.findByUsername(principal.getName())
                                           .orElse(null);
            model.addAttribute("loggedInUser", loggedInUser);
        } else {
            model.addAttribute("loggedInUser", null);
        }

        logger.info("--- Successfully prepared model. Returning 'checkout' view ---");
        return "checkout";
    }

    @PostMapping("/placeOrder")
    public String placeOrder(
            @RequestParam("fullName") String fullName,
            @RequestParam("address") String shippingAddress,
            @RequestParam("city") String city,
            @RequestParam("zipCode") String zipCode,
            @RequestParam("paymentMethod") String paymentMethod,
            Principal principal,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        logger.info("--- Entering placeOrder method for /checkout/placeOrder POST request ---");
        logger.info("Received order details: Full Name='{}', Address='{}', City='{}', Zip='{}', Payment='{}'",
                    fullName, shippingAddress, city, zipCode, paymentMethod);

        User user = (User) session.getAttribute("loggedInUser");
        if (principal != null) {
            user = userService.findByUsername(principal.getName())
                               .orElse(null);
            logger.info("Placing order for user ID: {}", user != null ? user.getId() : "null");

        } else {
            logger.info("Anonymous user attempting order placement.");
        }

        Cart cart = getOrCreateCart(principal, session);

        if (cart.getCartItems().isEmpty()) {
            logger.warn("Cart is EMPTY during placeOrder for user {}. Redirecting to /cart.", principal != null ? principal.getName() : "anonymous");
            redirectAttributes.addFlashAttribute("message", "Your cart is empty. Please add items before checking out.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/cart";
        }
        logger.info("Cart has {} items for user {} for order placement.", cart.getCartItems().size(), principal != null ? principal.getName() : "anonymous");

        try {
            Order placedOrder = orderService.placeOrder(user, cart, fullName, shippingAddress, city, zipCode, paymentMethod);
            logger.info("Order successfully placed. Order ID: {}", placedOrder.getId());

            session.removeAttribute("cartId");
            logger.info("Cart cleared for user {} after successful order.", principal != null ? principal.getName() : "anonymous");

            redirectAttributes.addFlashAttribute("message", "Thank you, " + fullName + "! Your order (ID: " + placedOrder.getId() + ") has been placed successfully.");
            redirectAttributes.addFlashAttribute("messageType", "success");
            redirectAttributes.addFlashAttribute("order", placedOrder);

            return "redirect:/checkout/order/success";
        } catch (IllegalArgumentException e) {
            logger.error("Validation error during order placement for user {}: {}", principal != null ? principal.getName() : "anonymous", e.getMessage());
            redirectAttributes.addFlashAttribute("message", e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/checkout";
        } catch (Exception e) {
            logger.error("An unexpected error occurred during order placement for user {}: {}", principal != null ? principal.getName() : "anonymous", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("message", "There was an error processing your order: " + e.getMessage() + ". Please try again.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/checkout";
        }
    }

    @GetMapping("/order/success")
    public String orderConfirmation(@ModelAttribute("order") Order order, Model model) {
        logger.info("--- Entering orderConfirmation method ---");
        if (order == null || order.getId() == null) {
            logger.warn("Order object not found in flash attributes. Redirecting to home.");
            return "redirect:/";
        }
        model.addAttribute("order", order);
        logger.info("Displaying confirmation for Order ID: {}", order.getId());
        return "orderConfirmation";
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
                        logger.info("Merged session cart ID {} into user's persistent cart ID {}.", sessionCartId, finalCartForLambda.getId());
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
                logger.info("Created new persistent cart ID {} for user {}.", cart.getId(), user.getUsername());
            } else {
                session.setAttribute("cartId", cart.getId());
                logger.info("Created new session cart ID {} for anonymous user.", cart.getId());
            }
        }
        return cart;
    }
}