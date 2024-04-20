package com.raon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.raon.domain.Members;


@Mapper
public interface MemberMapper {
    public List<Members> getAllMembers();
    public Members getMemberById(String id);
    public void registerMember(Members member);
    public void updateMember(Members member);
    public void deleteMember(String id);
    public boolean isUser(@Param("id")String id, @Param("pwd")String pwd);
    public void updatePassword(@Param("id")String id, @Param("email") String email, @Param("pwd") String pwd);
    public boolean selectId(String id); //중복 Id 검색
    public boolean rePwdInfo(@Param("id")String id, @Param("email")String email);
}
