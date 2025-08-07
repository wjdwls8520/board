package com.himedia.board.dao;

import com.himedia.board.dto.MemberDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMemberDao {
    MemberDto getMember(String userid);
    void insert(MemberDto memberdto);
    void update(MemberDto memberdto);
    void deleteMember(String userid);
}
