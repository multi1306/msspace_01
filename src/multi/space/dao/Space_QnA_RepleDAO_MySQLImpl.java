package multi.space.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import main.vo.Space_qna_repleVO;

public class Space_QnA_RepleDAO_MySQLImpl implements Space_QnA_RepleDAO{
	
	@Autowired @Qualifier("sqlSession")
	SqlSession sqlSession = null;
	
	@Override
	public Integer add_space_QnA_Reple_by_space_qna_no(Space_qna_repleVO vo) throws Exception {
		return sqlSession.insert("space_qna_reple.add_spaceQnA_Reple",vo);
	}

	@Override
	public List<Space_qna_repleVO> find_space_QnA_Reple(Space_qna_repleVO vo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("space_qna_reple.find_space_QnA_Reple",vo);
	}

}
