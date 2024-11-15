package com.example.domain;

import lombok.Data;

import java.time.LocalDateTime;


@Data
public class testVO {
    String title;
    String content;
    String writer;

    private LocalDateTime regDate;
    private LocalDateTime updateDate;


}
