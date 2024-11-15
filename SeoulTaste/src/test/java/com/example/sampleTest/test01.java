package com.example.sampleTest;

import com.example.sample.Restaurant;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class test01 {


    @Autowired
    Restaurant restaurant;

    @Test
    public void test02() {
        System.out.println(restaurant);
    }


}
