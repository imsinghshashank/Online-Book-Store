package com.BookStore.Repository;

import com.BookStore.Entity.Book;
import com.BookStore.Entity.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    void deleteByBook(Book book);
}