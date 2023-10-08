package com.ly.em.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ly.em.entity.MyFile;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FileMapper extends BaseMapper<MyFile> {
}
