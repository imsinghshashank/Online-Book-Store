package com.BookStore.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller 
public class HomeController {

    @GetMapping("/") 
    public ModelAndView showHomePage(ModelAndView modelAndView) {
        modelAndView.setViewName("home"); 
        return modelAndView;             
    }

    @GetMapping("/welcome") 
    public ModelAndView welcome(ModelAndView modelAndView) {
        modelAndView.setViewName("index"); 
        return modelAndView;               
    }
}