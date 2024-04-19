package com.raon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.raon.domain.Cart;
import com.raon.domain.Comment;

@Mapper
public interface MypageMapper {
	@Select("select * from cart where id=#{id}")
	public List<Cart> read(String id);
	
	@Insert("INSERT INTO cart (id, contentid, title, firstimage) VALUES (#{id}, #{contentid}, #{title}, #{firstimage})")
	public int insertCart(Cart cart);
	
	@Select("select count(*) from cart where id=#{id} and contentid=#{contentid}")
	public int isItemInCart(@Param("id") String id,@Param("contentid") String contentid);
}
