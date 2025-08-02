package com.BookStore.Controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "password"; 


    @GetMapping("/admin/login")
    public String showAdminLoginForm(Model model, HttpSession session) {
        if (session.getAttribute("isAdminLoggedIn") != null && (Boolean)session.getAttribute("isAdminLoggedIn")) {
            return "redirect:/admin";
        }
        return "adminLogin"; 
    }


    @PostMapping("/admin/login")
    public String processAdminLogin(@RequestParam String username,
                                    @RequestParam String password,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {

        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("isAdminLoggedIn", true); 
            redirectAttributes.addFlashAttribute("message", "Welcome, Admin!");
            redirectAttributes.addFlashAttribute("messageType", "success");
            return "redirect:/admin"; 
        } else {
            redirectAttributes.addFlashAttribute("message", "Invalid username or password.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/admin/login"; 
        }
    }


    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("message", "You have been logged out.");
        redirectAttributes.addFlashAttribute("messageType", "success");
        return "redirect:/admin/login"; 
    }
}