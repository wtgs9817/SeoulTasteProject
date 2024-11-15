package com.example.controller;


import com.example.domain.testVO;
import com.example.service.MyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Controller
public class testController {

    @Autowired
    MyService myService;

    @GetMapping("/")
    public String test(Model model) {
        System.out.println("실행중...");
        List<testVO> list = myService.getList();
        model.addAttribute("list", list);
        return "index";

    }

    @GetMapping("/map")
        public String map(Model model) {
            System.out.println("지도 실행중...");

            return "map";
        }


    @GetMapping("/testmap")
    public String maptest(Model model) {
        System.out.println("테스트용 지도 실행중...");

        return "testmap";
    }


}
