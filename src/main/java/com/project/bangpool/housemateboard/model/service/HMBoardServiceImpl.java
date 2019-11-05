package com.project.bangpool.housemateboard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.bangpool.housemateboard.model.dao.HMBoardDAO;
import com.project.bangpool.housemateboard.model.vo.HMBoard;

@Service("hbService")
public class HMBoardServiceImpl implements HMBoardService {

	@Autowired
	private HMBoardDAO hbDAO;

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ArrayList<HMBoard> selectList() {
		return hbDAO.selectList(sqlSession);

	}

	@Override
	public HMBoard selectBoard(int hbId) {
		HMBoard b = null;
		
		int result = hbDAO.addReadCount(sqlSession, hbId);
		System.out.println("result :" +result);
		if(result > 0) {
			b = hbDAO.selectBoard(sqlSession, hbId);
		}
		return b;
	}

	@Override
	public int insertBoard(HMBoard hb) {
		// insert시에  파일은 attachment테이블에  저장
		
		int result1 = hbDAO.insertBoard(sqlSession, hb);
		int result2  = 0;
		
		if(result1 > 0) {
			int hbId = hbDAO.selectHbId(sqlSession);	//해당 게시글번호 select 가져오기
			hb.setHbId(hbId);
			hb.setBcode("HMBCODE");
			
			result2 = hbDAO.insertFile(sqlSession, hb);
		}
		
		return result2;
	}

	@Override
	public int updateBoard(HMBoard hb) {
		// update시, 첨부파일은 attachment테이블에 저장
		
		int result1 = hbDAO.updateBoard(sqlSession, hb);
		int result2  = 0;
		
		if(result1 > 0) {
			hb.setBcode("HMBCODE");
			
			result2 = hbDAO.updateFile(sqlSession, hb);
		}
		return result2;
	}
	
	
	

}
