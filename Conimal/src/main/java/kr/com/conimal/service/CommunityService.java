package kr.com.conimal.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.com.conimal.model.command.SearchCommand;
import kr.com.conimal.model.dto.BoardDto;
import kr.com.conimal.model.dto.FileDto;

public interface CommunityService {
	
	/* 글 목록 */
	public List<BoardDto> findBoardAll(SearchCommand search);
	
	/* 글 갯수 조회 */
	public int findBoardCount(SearchCommand search) throws Exception;
	
	/* 글 작성 */
	public Long saveBoard(BoardDto board) throws Exception;
	
	/* 파일 저장 */
	public void saveFile(Long board_id, MultipartHttpServletRequest request) throws Exception;
	
	/* 글 상세 보기 */
	public BoardDto findBoard(Long board_id) throws Exception;
	
	/* 파일 가져오기 */
	public List<FileDto> findFile(Long board_id) throws Exception;
	
	/*/ 글 수정 */
	public int updateBoard(BoardDto board) throws Exception;

	/* 글 삭제 */
	public int deleteBoard(Long board_id) throws Exception;

}
