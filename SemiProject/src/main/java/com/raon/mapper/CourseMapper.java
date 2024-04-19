package com.raon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.raon.domain.Course;

@Mapper
public interface CourseMapper {
    @Select("SELECT * FROM course")
    List<Course> getList();
    
    @Select("SELECT * FROM course WHERE contentid=#{contentid}")
    Course detail(String contentid);
    
    @Select("SELECT subcontentid FROM course WHERE contentid=#{contentid}")
    String getSubContents(String contentid);
    
    @Insert("INSERT INTO COURSE (contentid, title, overview, firstimage, subcontentid, id) VALUES (#{contentid}, #{title}, #{overview}, #{firstimage}, #{subcontentid}, #{id})")
    void add(@Param("contentid") String contentid, @Param("firstimage") String firstimage, @Param("subcontentid") String subcontentid, @Param("id") String id, @Param("title") String title, @Param("overview") String overview);
}
