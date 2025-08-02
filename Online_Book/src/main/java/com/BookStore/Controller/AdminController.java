package com.BookStore.Controller;

import com.BookStore.Entity.Book;
import com.BookStore.Entity.Order;
import com.BookStore.Service.BookService;
import com.BookStore.Service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
    private final BookService bookService;
    private final OrderService orderService;

    public AdminController(BookService bookService, OrderService orderService) {
        this.bookService = bookService;
        this.orderService = orderService;
    }

    // --- Admin Dashboard & Book Management ---

    @GetMapping
    public String adminDashboard(Model model) {
        List<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        return "adminDashboard";
    }

    @GetMapping("/books")
    public String manageBooks(Model model) {
        List<Book> books = bookService.getAllBooks();
        model.addAttribute("books", books);
        return "adminDashboard";
    }

    @PostMapping("/addBook")
    public String addBook(@RequestParam String title,
                          @RequestParam String author,
                          @RequestParam BigDecimal price,
                          @RequestParam String imageUrl,
                          @RequestParam int stock,
                          RedirectAttributes redirectAttributes) {
        try {
            Book newBook = new Book(title, author, price, imageUrl, stock);
            bookService.saveBook(newBook);
            redirectAttributes.addFlashAttribute("message", "Book added successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error adding book: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/admin";
    }

    @GetMapping("/edit/{id}")
    public String editBookForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Book> bookOptional = bookService.getBookById(id);
        if (bookOptional.isPresent()) {
            model.addAttribute("book", bookOptional.get());
            return "editBook";
        } else {
            redirectAttributes.addFlashAttribute("message", "Book not found!");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/admin";
        }
    }

    @PostMapping("/updateBook")
    public String updateBook(@RequestParam Long id,
            @RequestParam String title,
            @RequestParam String author,
            @RequestParam BigDecimal price,
            @RequestParam String imageUrl,
            @RequestParam int stock,
            RedirectAttributes redirectAttributes) {
        try {
            Optional<Book> bookOptional = bookService.getBookById(id);
            if (bookOptional.isPresent()) {
                Book book = bookOptional.get();
                book.setTitle(title);
                book.setAuthor(author);
                book.setPrice(price);
                book.setImageUrl(imageUrl);
                book.setStock(stock);
                bookService.saveBook(book);
                redirectAttributes.addFlashAttribute("message", "Book updated successfully!");
                redirectAttributes.addFlashAttribute("messageType", "success");
            } else {
                redirectAttributes.addFlashAttribute("message", "Book not found!");
                redirectAttributes.addFlashAttribute("messageType", "error");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error updating book: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/admin";
    }

    @PostMapping("/delete") 
    public String deleteBook(@RequestParam Long id, RedirectAttributes redirectAttributes) { // Changed from @PathVariable to @RequestParam
        try {
            bookService.deleteBook(id);
            redirectAttributes.addFlashAttribute("message", "Book deleted successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error deleting book: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/admin"; 
    }

    // --- Order Management ---

    @GetMapping("/orders")
    public String listAllOrders(Model model) {
        List<Order> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "adminOrders";
    }

    @GetMapping("/orders/{id}")
    public String viewOrderDetails(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Order> orderOptional = orderService.getOrderById(id);
        if (orderOptional.isPresent()) {
            model.addAttribute("order", orderOptional.get());
            return "adminOrderDetails";
        } else {
            redirectAttributes.addFlashAttribute("message", "Order not found!");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/admin/orders";
        }
    }

    @PostMapping("/orders/updateStatus")
    public String updateOrderStatus(@RequestParam("orderId") Long orderId,
                                    @RequestParam("newStatus") String newStatus,
                                    RedirectAttributes redirectAttributes) {
        try {
            orderService.updateOrderStatus(orderId, newStatus);
            redirectAttributes.addFlashAttribute("message", "Order status updated successfully!");
            redirectAttributes.addFlashAttribute("messageType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Error updating order status: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        return "redirect:/admin/orders/" + orderId;
    }
}