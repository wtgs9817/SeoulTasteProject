package com.example.sample;


import lombok.RequiredArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

@Component
@ToString
@RequiredArgsConstructor
public class Restaurant {
    private final Chef chef;

    public static void main(String[] args) {
        System.out.println("한글 됨?????");
    }

}
