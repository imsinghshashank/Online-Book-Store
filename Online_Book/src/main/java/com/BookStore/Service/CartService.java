package com.BookStore.Service;

import com.BookStore.Entity.Book;
import com.BookStore.Entity.Cart;
import com.BookStore.Entity.CartItem;
import com.BookStore.Entity.User;
import com.BookStore.Repository.BookRepository;
import com.BookStore.Repository.CartItemRepository;
import com.BookStore.Repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final BookRepository bookRepository;

    @Autowired
    public CartService(CartRepository cartRepository, CartItemRepository cartItemRepository, BookRepository bookRepository) {
        this.cartRepository = cartRepository;
        this.cartItemRepository = cartItemRepository;
        this.bookRepository = bookRepository;
    }

    @Transactional
    public Cart createCart() {
        Cart cart = new Cart();
        if (cart.getCartItems() == null) {
            cart.setCartItems(new java.util.ArrayList<>());
        }
        return cartRepository.save(cart);
    }

    @Transactional
    public Cart getCartByUser(User user) {
        Optional<Cart> optionalCart = cartRepository.findByUser(user);
        return optionalCart.orElseGet(() -> {
            Cart newCart = new Cart();
            newCart.setUser(user);
            if (newCart.getCartItems() == null) {
                newCart.setCartItems(new java.util.ArrayList<>());
            }
            return cartRepository.save(newCart);
        });
    }

    @Transactional(readOnly = true)
    public Optional<Cart> getCartById(Long id) {
        return cartRepository.findById(id);
    }

    @Transactional
    public Cart saveCart(Cart cart) {
        return cartRepository.save(cart);
    }

    @Transactional
    public Cart addBookToCart(Cart cart, Book book, int quantity) {
        if (cart.getCartItems() == null) {
            cart.setCartItems(new java.util.ArrayList<>());
        }

        Optional<CartItem> existingItemOptional = cart.getCartItems().stream()
                .filter(item -> item.getBook().getId().equals(book.getId()))
                .findFirst();

        int currentQuantityInCart = existingItemOptional.map(CartItem::getQuantity).orElse(0);
        int totalRequestedQuantity = currentQuantityInCart + quantity;

        if (book.getStock() < totalRequestedQuantity) {
            throw new IllegalArgumentException("Not enough stock for " + book.getTitle() + ". Available: " + book.getStock() + ", Current in cart: " + currentQuantityInCart + ", Requested: " + quantity);
        }

        if (existingItemOptional.isPresent()) {
            CartItem existingItem = existingItemOptional.get();
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            cartItemRepository.save(existingItem);
        } else {
            CartItem newItem = new CartItem(cart, book, quantity);
            cart.addCartItem(newItem);
            cartItemRepository.save(newItem);
        }
        calculateCartTotal(cart);
        return cart;
    }

    /**
     * Updates the quantity of a CartItem using the bookId.
     * This method is a corrected version to align with the controller's parameter.
     */
    @Transactional
    public void updateCartItemQuantity(Cart cart, Long bookId, int newQuantity) {
        Optional<CartItem> optionalCartItem = cart.getCartItems().stream()
                .filter(item -> item.getBook().getId().equals(bookId))
                .findFirst();

        if (optionalCartItem.isPresent()) {
            CartItem cartItem = optionalCartItem.get();

            if (newQuantity <= 0) {
                removeBookFromCart(cart, bookId);
                return;
            }

            Book book = cartItem.getBook();
            if (book.getStock() < newQuantity) {
                throw new IllegalArgumentException("Not enough stock for " + book.getTitle() + ". Available: " + book.getStock());
            }

            cartItem.setQuantity(newQuantity);
            cartItemRepository.save(cartItem);
            calculateCartTotal(cart);
        } else {
            throw new IllegalArgumentException("Cart item for book not found in this cart.");
        }
    }

    /**
     * Removes a CartItem from the cart using the bookId.
     * This method is a corrected version to align with the controller's parameter.
     */
    @Transactional
    public void removeBookFromCart(Cart cart, Long bookId) {
        Optional<CartItem> optionalCartItem = cart.getCartItems().stream()
                .filter(item -> item.getBook().getId().equals(bookId))
                .findFirst();

        if (optionalCartItem.isPresent()) {
            CartItem cartItem = optionalCartItem.get();
            cart.removeCartItem(cartItem);
            cartItemRepository.delete(cartItem);
            calculateCartTotal(cart);
        } else {
            throw new IllegalArgumentException("Cart item for book not found in this cart.");
        }
    }

    @Transactional
    public void clearCart(Cart cart) {
        cartItemRepository.deleteByCart(cart);
        if (cart.getCartItems() != null) {
            cart.getCartItems().clear();
        }

        cart.setTotalAmount(BigDecimal.ZERO);
        cartRepository.save(cart);
    }

    @Transactional
    public void calculateCartTotal(Cart cart) {
        BigDecimal total = BigDecimal.ZERO;
        List<CartItem> freshItems = cartItemRepository.findByCart(cart);

        if (cart.getCartItems() != null) {
            cart.getCartItems().clear();
            cart.getCartItems().addAll(freshItems);
        } else {
            cart.setCartItems(freshItems);
        }

        for (CartItem item : cart.getCartItems()) {
            item.updateSubtotal();
            total = total.add(item.getSubtotal());
        }

        cart.setTotalAmount(total);
        cartRepository.save(cart);
    }

    @Transactional
    public void mergeCarts(Cart targetCart, Cart sourceCart) {
        if (targetCart == null || sourceCart == null || targetCart.getId().equals(sourceCart.getId())) {
            return;
        }

        if (targetCart.getCartItems() == null) {
            targetCart.setCartItems(new java.util.ArrayList<>());
        }
        if (sourceCart.getCartItems() == null) {
            sourceCart.setCartItems(new java.util.ArrayList<>());
        }

        for (CartItem sourceItem : new java.util.ArrayList<>(sourceCart.getCartItems())) {
            Book book = sourceItem.getBook();
            int quantityToAdd = sourceItem.getQuantity();

            Optional<CartItem> existingTargetItemOptional = targetCart.getCartItems().stream()
                    .filter(item -> item.getBook().getId().equals(book.getId()))
                    .findFirst();

            if (existingTargetItemOptional.isPresent()) {
                CartItem existingTargetItem = existingTargetItemOptional.get();
                if (book.getStock() >= (existingTargetItem.getQuantity() + quantityToAdd)) {
                    existingTargetItem.setQuantity(existingTargetItem.getQuantity() + quantityToAdd);
                    cartItemRepository.save(existingTargetItem);
                } else {
                    System.err.println("Not enough stock to merge book " + book.getTitle() + " from source cart to target cart. Merged only available stock.");
                }
            } else {
                CartItem newTargetItem = new CartItem(targetCart, book, quantityToAdd);
                targetCart.addCartItem(newTargetItem);
                cartItemRepository.save(newTargetItem);
            }
        }

        clearCart(sourceCart);
        cartRepository.delete(sourceCart);

        calculateCartTotal(targetCart);
    }
}