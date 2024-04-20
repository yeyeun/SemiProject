package com.raon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.domain.Board;
import com.raon.domain.Cart;
import com.raon.domain.Comment;
import com.raon.domain.Course;

@Mapper
public interface MypageMapper {
	@Select("select * from cart where id=#{id}")
	public List<Cart> read(String id);
	
	@Insert("INSERT INTO cart (id, contentid, title, firstimage) VALUES (#{id}, #{contentid}, #{title}, #{firstimage})")
	@SelectKey(statement="SELECT ROW_COUNT()", keyProperty="rowCount", before=false, resultType=int.class)
	public int insertCart(@Param("id") String id,@Param("contentid") String contentid, @Param("firstimage") String firstimage, @Param("title") String title);
	
	@Select("select count(*) from cart where id=#{id} and contentid=#{contentid}")
	public int isItemInCart(@Param("id") String id,@Param("contentid") String contentid);
	
	@Delete("delete from cart where id=#{id} and contentid=#{contentid}")
	@SelectKey(statement="SELECT ROW_COUNT()", keyProperty="rowCount", before=false, resultType=int.class)
	public int deleteItemInCart(@Param("id") String id,@Param("contentid") String contentid);
	
	@Select("select * from boardtable where writer=#{writer}")
	public List<Board> myboard(@Param("writer") String writer);
	
	@Select("select * from course where id = #{id}")
	public List<Course> mycourse(@Param("id") String id);
}
