package com.example.service;

import com.example.domain.testVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.mapper.testMapper;

import java.util.List;

@Service
public class MyService {

    @Autowired
    testMapper testMapper;

    public List<testVO> getList() {
        return testMapper.getList();
    }




}
