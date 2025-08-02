package com.BookStore.Repository; 

import com.BookStore.Entity.CartItem;
import com.BookStore.Entity.Cart;     
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository 
public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    List<CartItem> findByCart(Cart cart);
    void deleteByCart(Cart cart);
}