package com.example.mapper;

import com.example.domain.testVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface testMapper {

    List<testVO> getList();
}