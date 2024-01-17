package com.oracle.S202350102.service.jkService;


import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.util.List;


import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.S202350102.dao.jkDao.JkBoardDao;
import com.oracle.S202350102.dto.Board;
import com.oracle.S202350102.dto.User1;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JkBoardServiceImpl implements JkBoardService {

	private final JkBoardDao jbd;
	
	
	@Override
	public List<Board> sharing(Board board) {
		List<Board> sharing = null;
		System.out.println("JkCommunityServiceImpl start...");
		sharing = jbd.sharing(board);
		System.out.println("JkCommunityServiceImpl Sharing.size()-->"+sharing.size());
		return sharing ;
	}

	@Override
	public User1 userSelect(int user_num) {
		return jbd.userSelect(user_num);
	}
	
	@Override
	public Board likeService(int brd_num) {
		System.out.println("likeService start...");
		 try {
		        Board board = jbd.getboardBybrd_num(brd_num);

		        if (board != null) {
		            jbd.updateLikeStatus(brd_num); // 좋아요 증가

		            return board;
		        } else {
		            return null;
		        }
		    } catch (Exception e) {
		        System.out.println("Error while getting like status: " + e.getMessage());
		        return null;
		    }
		}

	@Override
	public void updateLikeStatus(int brd_num) {
		  System.out.println("BoardServiceImpl updateLikeStatus start..." + brd_num);
	        jbd.updateLikeStatus(brd_num);
		
	}

	@Override
	public int writeFormSharing(Board board) {
	    System.out.println("BoardServiceImpl writeFormSharing start...");

	    try {
	        int rowsInserted = jbd.writeFormSharing(board); 

	        if (rowsInserted > 0) {
	            return rowsInserted; // 삽입된 행의 수를 반환
	        } else {
	            return 0; // 삽입된 행이 없을 때 0 반환
	        }
	    } catch (Exception e) {
	        System.out.println("Error while writing the new sharing: " + e.getMessage());
	        return 0; // 에러 발생 시 0 반환
	    }
	}

	@Override
	public Board detailSharing(int brd_num) {
		System.out.println("JkBoardServiceImpl detailSharing start...");
		Board board = null;
		board = jbd.detailSharing(brd_num);
		
		return board;
	}

	@Override
	public int updateSharing(Board board) {
		System.out.println("JkBoardServiceImpl updateSharing start...");
		int updateSharing = 0;
		updateSharing = jbd.updateSharing(board);
		
		return updateSharing;
	}

	@Override
	public int deleteSharing(int brd_num) {
		System.out.println("JkBoardServiceImpl deleteSharing start...");
		int deleteResult = 0;
		deleteResult = jbd.deleteSharing(brd_num);
		
		return deleteResult;
	}

	public String uploadImage(MultipartFile file) {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("이미지를 선택해주세요");
        }

        try {
            String fileName = StringUtils.cleanPath(file.getOriginalFilename());
            String directory = "C:\\project\\backup\\SSJ2\\S202350102\\src\\main\\resources\\static\\images\\b_upload";
            Path uploadPath = Paths.get(directory);

            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Assign the input stream to a variable
            InputStream inputStream = file.getInputStream();
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(inputStream, filePath);

            // Close the input stream
            inputStream.close();

            return filePath.toString(); // 혹은 실제 저장된 이미지 URL을 반환합니다.
        } catch (IOException e) {
            throw new RuntimeException("이미지 업로드 실패: " + e.getMessage());
        }
	}

	@Override
	public List<Board> loadSortedPosts(String sort) {
		List<Board> loadSortedPosts = null;
		System.out.println("JkBoardServiceImpl loadSortedPosts start...");
		
		if("view_cnt".contentEquals(sort)) {
			return jbd.getPopularPosts();
		} else if ("reg_date".equals(sort)) {
			return jbd.getRecentPosts();
		} else {
			return jbd.getRecentPosts();
		}
	}

	@Override
	public void commentSharing(Board board) {
		System.out.println("JkCommunityServiceImpl commentSharing start..");
		jbd.commentSharing(board);
	
		
	}

	@Override
	public List<Board> listCommentSharing(int brd_num) {
		List<Board> listCommentSharing = null;
		System.out.println("JkCommunityServiceImpl listCommentSharing start...");
		listCommentSharing = jbd.listCommentSharing(brd_num);
		return listCommentSharing;
	}

	@Override
	public void commentUpdateSharing(Board board) {
		System.out.println("JkCommunityServiceImpl commentUpdateSharing start..");
		jbd.commentUpdateSharing(board);
	}

	@Override
	public void commentDeleteSharing(Board board) {
		System.out.println("JkCommunityServiceImpl commentDeleteSharing start..");
		jbd.commentDeleteSharing(board);
	
	}

	@Override
	public int commentCountSharing(int brd_num) {
		System.out.println("JkCommunityServiceImpl commentCountSharing start...");
		int commentCountSharing = jbd.commentCountSharing(brd_num);
		return commentCountSharing;
	}

	@Override
	public List<Board> sharingResult(Board board) {
		List<Board> sharingResult = null;
		System.out.println("JkNearby sharingResult start...");
		sharingResult = jbd.sharingResult(board);
		System.out.println("JkNearby sharingResult.size()-->"+sharingResult.size());
		return sharingResult ;
		
	}

	@Override
	public List<Board> sharing2(Board board) {
		List<Board> sharing2 = null;
		System.out.println("JkCommunityServiceImpl start...");
		sharing2 = jbd.sharing2(board);
		System.out.println("JkCommunityServiceImpl Sharing.size()-->"+sharing2.size());
		return sharing2 ;
	}

	@Override
	public int myBoard(int user_num) {
		System.out.println("JkCommunityServiceImpl myBoard Start...");
		
		int myBoard = jbd.myBoard(user_num);
		
		return myBoard;
	}
}
