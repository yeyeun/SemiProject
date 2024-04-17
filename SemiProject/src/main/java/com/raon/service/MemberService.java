package com.raon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.raon.mapper.MemberMapper;
import com.raon.domain.Members;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberService {
	@Setter(onMethod_=@Autowired)
	private MemberMapper mapper;
	

    public List<Members> getAllMembers() {
        return mapper.getAllMembers();
    }


    public Members getMemberById(String id) {
        return mapper.getMemberById(id);
    }


    public void registerMember(Members member) {
    	mapper.registerMember(member);
    }


    public void updateMember(Members member) {
    	mapper.updateMember(member);
    }


    public void deleteMember(String id) {
    	mapper.deleteMember(id);
    }


    public boolean isUser(@RequestParam("id")String id, @RequestParam("pwd") String pwd) {
        return mapper.isUser(id, pwd);
    }

    
    public void updatePassword(Members member) {
    	mapper.updatePassword(member);
    }
	public boolean selectId(String id) {
		log.info("Service :: selectId...................");
		return mapper.selectId(id);
	}
	public boolean rePwdInfo(@RequestParam("id")String id, @RequestParam("email") String email) {
		return mapper.rePwdInfo(id, email);
	}
}
