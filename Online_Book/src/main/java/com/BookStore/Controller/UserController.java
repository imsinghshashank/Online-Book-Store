package com.BookStore.Controller;

import com.BookStore.Entity.User;
import com.BookStore.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String showLoginForm(HttpSession session) {
        if (session.getAttribute("isUserLoggedIn") != null && (Boolean) session.getAttribute("isUserLoggedIn")) {
            return "redirect:/";
        }
        return "login"; 
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        Optional<User> userOptional = userService.findByUsername(username);

        if (userOptional.isPresent()) {
            User user = userOptional.get();

            if (user.getPassword().equals(password)) { 
                session.setAttribute("isUserLoggedIn", true);
                session.setAttribute("loggedInUser", user); 
                redirectAttributes.addFlashAttribute("message", "Welcome, " + username + "!");
                redirectAttributes.addFlashAttribute("messageType", "success");
                return "redirect:/"; 
            }
        }
        redirectAttributes.addFlashAttribute("message", "Invalid username or password.");
        redirectAttributes.addFlashAttribute("messageType", "error");
        return "redirect:/login"; 
    }

    @GetMapping("/signup")
    public String showSignupForm(Model model, HttpSession session) {
        if (session.getAttribute("isUserLoggedIn") != null && (Boolean) session.getAttribute("isUserLoggedIn")) {
            return "redirect:/";
        }
        model.addAttribute("user", new User());
        return "signup";
    }

    @PostMapping("/signup")
    public String processSignup(@ModelAttribute("user") User user, RedirectAttributes redirectAttributes) {
        if (userService.findByUsername(user.getUsername()).isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Registration failed. Username '" + user.getUsername() + "' is already taken.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/signup";
        }
        if (user.getEmail() != null && userService.findByEmail(user.getEmail()).isPresent()) {
            redirectAttributes.addFlashAttribute("message", "Registration failed. Email '" + user.getEmail() + "' is already registered.");
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/signup";
        }

        try {
            user.setRole("ROLE_USER");
            User registeredUser = userService.saveUser(user);
            redirectAttributes.addFlashAttribute("message", "Registration successful! Please log in.");
            redirectAttributes.addFlashAttribute("messageType", "success");
            return "redirect:/login"; 
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Registration failed due to an error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
            return "redirect:/signup"; 
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate(); 
        redirectAttributes.addFlashAttribute("message", "You have been logged out.");
        redirectAttributes.addFlashAttribute("messageType", "success");
        return "redirect:/";
    }
}