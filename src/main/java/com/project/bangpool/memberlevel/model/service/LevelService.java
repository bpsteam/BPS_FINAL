package com.project.bangpool.memberlevel.model.service;

import com.project.bangpool.member.model.vo.Member;
import com.project.bangpool.memberlevel.model.vo.ManageMember;

public interface LevelService {

	ManageMember updateLevel(String mlCode);

	int getLoginCount(String mNo);

	int updatelCode(Member m);

}
