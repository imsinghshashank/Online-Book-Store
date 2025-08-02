package com.BookStore.Service;

import com.BookStore.Entity.*;
import com.BookStore.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

// Add a logger (Spring Boot uses SLF4J by default, common to use Lombok's @Slf4j or direct LoggerFactory)
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderService.class); // Added this line

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final BookRepository bookRepository;

    @Autowired
    public OrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository,
                        CartRepository cartRepository, CartItemRepository cartItemRepository,
                        BookRepository bookRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.bookRepository = bookRepository;
    }

    @Transactional
    public Order placeOrder(User user, Cart cart, String fullName, String shippingAddress, String city, String zipCode, String paymentMethod) throws Exception {
        if (cart == null || cart.getCartItems().isEmpty()) {
            throw new IllegalArgumentException("Cannot place an order with an empty cart.");
        }

       

        Order order = new Order();
        order.setUser(user); 
        order.setOrderDate(LocalDateTime.now());
        order.setFullName(fullName);
        order.setShippingAddress(shippingAddress);
        order.setCity(city);
        order.setZipCode(zipCode);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("PENDING");

        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartItem cartItem : cart.getCartItems()) {
            Book book = cartItem.getBook();
            int quantity = cartItem.getQuantity();

            if (book.getStock() < quantity) {
                throw new Exception("Not enough stock for book: " + book.getTitle() + ". Available: " + book.getStock() + ", Requested: " + quantity);
            }
            book.setStock(book.getStock() - quantity);
            bookRepository.save(book);

            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setBook(book);
            orderItem.setQuantity(quantity);
            orderItem.setPriceAtPurchase(book.getPrice());

            order.addOrderItem(orderItem);
            totalAmount = totalAmount.add(book.getPrice().multiply(BigDecimal.valueOf(quantity)));
        }

        order.setTotalAmount(totalAmount);
        Order savedOrder = orderRepository.save(order); 
        cartItemRepository.deleteByCart(cart);
        cart.getCartItems().clear(); 
        cart.setTotalAmount(BigDecimal.ZERO); 
        cartRepository.save(cart); 

        return savedOrder;
    }

    @Transactional(readOnly = true)
    public List<Order> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        logger.info("Fetched {} orders from the database.", orders.size()); 
        return orders;
    }

    @Transactional(readOnly = true)
    public Optional<Order> getOrderById(Long id) {
        return orderRepository.findById(id);
    }

    @Transactional
    public Order updateOrderStatus(Long orderId, String newStatus) throws Exception {
        Optional<Order> optionalOrder = orderRepository.findById(orderId);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus(newStatus);
            return orderRepository.save(order);
        } else {
            throw new Exception("Order not found with ID: " + orderId);
        }
    }

    @Transactional(readOnly = true)
    public List<Order> getOrdersByUser(User user) {
        List<Order> orders = orderRepository.findByUser(user);
        System.out.println("Found orders for user: " + orders.size());
        return orders;
    }
    
}