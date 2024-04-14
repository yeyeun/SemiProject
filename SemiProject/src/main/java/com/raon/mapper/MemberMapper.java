package com.raon.mapper;

import java.util.List;

import com.raon.domain.Members;



public interface MemberMapper {
    List<Members> getAllMembers();
    Members getMemberById(String id);
    void registerMember(Members member);
    void updateMember(Members member);
    void deleteMember(String id);
    boolean isUser(String id, String pwd);
    void updatePassword(Members member);
}
