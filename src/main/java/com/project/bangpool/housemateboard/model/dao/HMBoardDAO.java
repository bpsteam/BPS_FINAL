package com.project.bangpool.housemateboard.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.bangpool.housemateboard.model.vo.HMBoard;

@Repository("hbDAO")
public class HMBoardDAO {

	public ArrayList<HMBoard> selectList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("hmboardMapper.selectList");
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int hbId) {
		return sqlSession.update("hmboardMapper.addReadCount", hbId);
	}

	public HMBoard selectBoard(SqlSessionTemplate sqlSession, int hbId) {
		return sqlSession.selectOne("hmboardMapper.selectBoard", hbId);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, HMBoard hb) {
		return sqlSession.insert("hmboardMapper.insertBoard", hb);
	}

}