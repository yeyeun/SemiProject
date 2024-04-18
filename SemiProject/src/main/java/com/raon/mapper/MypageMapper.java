package com.raon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.raon.domain.Cart;

@Mapper
public interface MypageMapper {
	@Select("select * from cart where id=#{id}")
	public List<Cart> read(String id);
}
