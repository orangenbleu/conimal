package kr.com.conimal.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.com.conimal.dao.UserDao;
import kr.com.conimal.model.dto.UserDto;

@Service("UserService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao dao;
	
	/* 회원가입 */
	@Override
	public int join(UserDto user) throws Exception {
		user.setCreate_date(LocalDate.now());
		user.setUpdate_date(LocalDate.now());
		user.setLast_login(LocalDate.now());
		
		return dao.join(user);
	}

	/* 닉네임 중복 체크 */
	@Override
	public int checkNick(String nickname) throws Exception {
		return dao.checkNick(nickname);
	}
	
	/* 아이디 중복 체크 */
	@Override
	public int checkId(String id) throws Exception {
		return dao.checkId(id);
	}

	/* 이메일 중복 체크 */
	@Override
	public int checkEmail(String email) throws Exception {
		return dao.checkEmail(email);
	}

	/* 로그인 */
	@Override
	public UserDto login(UserDto user) throws Exception {
		dao.lastLogin(user.getUser_id());
		
		return dao.login(user);
	}
	
	/* 회원 정보 가져오기 */
	@Override
	public UserDto findByUserId(Long user_id) throws Exception {
		return dao.findByUserId(user_id);
	}
	@Override
	public UserDto findById(String id) throws Exception {
		return dao.findById(id);
	}
}
