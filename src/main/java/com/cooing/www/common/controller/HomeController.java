package com.cooing.www.common.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cooing.www.album.dao.BookMarkDAO;
import com.cooing.www.album.dao.AlbumDAO;
import com.cooing.www.album.dao.LikesDAO;
import com.cooing.www.album.dao.ReplyDAO;
import com.cooing.www.album.vo.LikesVO;
import com.cooing.www.album.vo.AlbumVO;
import com.cooing.www.album.vo.BookMark;
import com.cooing.www.album.vo.CategoryPop;
import com.cooing.www.album.vo.PageVO;
import com.cooing.www.album.vo.ReplyVO;
import com.cooing.www.common.dao.SearchDAO;
import com.cooing.www.common.vo.PageLimit;
import com.cooing.www.common.vo.Search;
import com.cooing.www.member.dao.MemberDAO;
import com.cooing.www.member.dao.RelationDAO;
import com.cooing.www.member.vo.Member;
import com.cooing.www.member.vo.Party;
import com.cooing.www.member.vo.PartyMember;
import com.cooing.www.util.PageNavigator;
import com.google.gson.Gson;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private final String strThumbnailPath = "/FileSave/thumbnail/";				// windows
	//private static String strThumbnailPath = "/Users/insect/hindoong_upload/";	// mac
	
	@Autowired
	RelationDAO relationDAO;
	@Autowired
	AlbumDAO albumDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	LikesDAO albumlikesDAO;
	@Autowired
	SearchDAO searchDAO;
	@Autowired
	BookMarkDAO albumbookmarkDAO;
	@Autowired
	ReplyDAO replyDAO;
	
	private Gson gson = new Gson();
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(String search , Model model, HttpSession session) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);
			if(search != null){
				searchDAO.insertSearch(new Search(0 , search , "0"));
				model.addAttribute("search" , search);
			}
		}
		return "home";
	}
	//다른곳에서 카테고리 눌렀을 경우 홈으로 이동 후 검색
	@RequestMapping(value = "/category_other", method = RequestMethod.GET)
	public String category_other_home(Model model, HttpSession session , int categorynum) {
		Member personal = (Member)session.getAttribute("Member");
		if(personal != null){
			searchDAO.insertCategoryPop(new CategoryPop(0 , categorynum , "0"));
			ArrayList<Party> arraystrval = relationDAO.searchPartyByMemberid(personal.getMember_id());
			model.addAttribute("group", arraystrval);			
			//다른 곳에서 홈으로 검색을 통해 home으로 간다는 것을 알려준다.
			model.addAttribute("search_other", 1);
			//검색어
			model.addAttribute("categorynum" , categorynum);			
		}		
		return "home";
	}
	
	/**
	 * 앨범뷰... 앨범과 페이지 리스트를 갖고 albumView로 이동....
	 */
	@RequestMapping(value = "/albumView", method = RequestMethod.GET)
	public String albumPage(int album_num, Model model , HttpSession session, String page_num) {
		//북마크 있을시 저장된 페이지 모데롤 줄 부분
		if(page_num != null){
			model.addAttribute("page_num", page_num);
		}
		
		Member member = (Member)session.getAttribute("Member");
		try {
			AlbumVO album = albumDAO.searchAlbumNum(album_num);
			if(album == null) return "redirect:/";
			ArrayList<PageVO> arr_page = albumDAO.select_pages_by_album_num(album_num);
			//페이지 사이즈가 없으면 2로 책갈피를 없애주고
			if(arr_page.size() > 0){
				if(albumbookmarkDAO.bookmark_check(new BookMark(0,album_num,member.getMember_id(),1))){
					//페이지가 있으면 1로 페이지가 있다고 알려주고
					model.addAttribute("check", 1);
				}else{
					model.addAttribute("check", 0);
				}
			}else{
				model.addAttribute("check", 2);
			}
			
			// 조회할 like vo
			LikesVO like = new LikesVO(album_num, member.getMember_id());
			LikesVO result_like = albumlikesDAO.selelct_like(like);
			
			// 조회할 reply vo
			ArrayList<ReplyVO> arr_reply = replyDAO.listReply(album_num, 1, 3);
			
			PageNavigator pageNav = new PageNavigator(3, 3, 1, replyDAO.getReplyTotal(album_num));
			
			ArrayList<PartyMember> arr_pm = new ArrayList<>();
			
			if(album.getIsPersonal().equals("0")) {
				// 파티 앨범일 경우 파티원도 모델에 담아 보내기
				
				arr_pm = relationDAO.searchPartyMember_by_party_name(album.getAlbum_writer());
				model.addAttribute("isPartymember", "0");
				for (PartyMember partyMember : arr_pm) {
					if (partyMember.getMember_id().equals(member.getMember_id())) {
						model.addAttribute("isPartymember", "1");
						break;
					}
				}
			}
			
			model.addAttribute("albumwrite", memberDAO.selectMember(album.getAlbum_writer()));
			model.addAttribute("album", album);
			model.addAttribute("arr_page", arr_page);
			model.addAttribute("like", result_like);
			model.addAttribute("arr_reply", arr_reply);
			model.addAttribute("pageNav", pageNav);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "album/albumView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getMyAlbumRead", method = RequestMethod.POST)
	public ArrayList<PageVO> getMyAlbumRead(String num) {
		return  albumDAO.select_pages_by_album_num(Integer.parseInt(num));
	}

	//좋아요 체크
	@ResponseBody
	@RequestMapping(value = "/check_likes", method = RequestMethod.GET)
	public String albumTestPage(@RequestParam int likeit_albumnum,
			HttpSession session) {
		
		String likeit_memberid = ((Member) session.getAttribute("Member")).getMember_id();
	
		LikesVO vo = new LikesVO(likeit_albumnum, likeit_memberid);
		
		String check_likeMember = null;
		check_likeMember = albumlikesDAO.check_Likes(vo);
		
		return check_likeMember;
	}
	
	//마이페이지
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(HttpSession session , Model model){
		Member member = (Member)session.getAttribute("Member");		
		return "myPage";
	}
	
	//랭킹페이지
	@RequestMapping(value = "/LankingPage", method = RequestMethod.GET)
	public String LankingPage(){
		return "LankingPage";
	}
	
	//회원가입 페이지
	@RequestMapping(value="/member_get" , method = RequestMethod.GET)
	public String member_get(){		
		logger.info("member_get__jinsu");
		return "/member";
	}
	
	//친구페이지
	@RequestMapping(value="/friend_get" , method = RequestMethod.GET)
	public String friend_get(String id , Model model , HttpSession session){
		logger.info("friend_get__jinsu");
		Member personally = (Member)session.getAttribute("Member");
		Member friend= memberDAO.selectMember(id);
		model.addAttribute("friend_id", friend);
		ArrayList<String> arrfriend = relationDAO.selectFriend(personally.getMember_id());
		for(String s:arrfriend){
			if(s.equals(friend.getMember_id())){
				model.addAttribute("check" , true);
				break;
			}
		}
		return "friendPage";
	}
	
	//책갈피페이지
	@RequestMapping(value = "/bookmark", method = RequestMethod.GET)
	public String bookmark(HttpSession session , Model model){
		return "album/bookmark";
	}
	
	//책갈피 리스트
	@ResponseBody
	@RequestMapping(value = "/bookmark_list", method = RequestMethod.POST)
	public ArrayList<BookMark> bookmark_list(HttpSession session){
		String bookmark_memberid = ((Member) session.getAttribute("Member")).getMember_id();
		ArrayList<BookMark> list = albumbookmarkDAO.bookmark_list(bookmark_memberid);
		for(int i=0; i<list.size(); i++){
			String temp_thumbnail = "home_thumbnail?filePath=" + list.get(i).getAlbum_thumbnail();
			list.get(i).setAlbum_thumbnail(temp_thumbnail);
		}
		return list;
	}
	@RequestMapping(value = "home_thumbnail", method = RequestMethod.GET)
	public String thumbnail(HttpServletResponse response , String filePath) {
		//logger.info("thumbnail__jinsu");
		
		String fullpath = strThumbnailPath + filePath;
		if( filePath.length() != 0){
			FileInputStream filein = null;
			ServletOutputStream fileout = null;
			try {
				filein = new FileInputStream(fullpath);
				fileout = response.getOutputStream();
				FileCopyUtils.copy(filein, fileout);			
				filein.close();
				fileout.close();
			} catch (IOException e) {
				//오류 뜨는 게 보기 싫어 잠깐 끔...
				//e.printStackTrace();
			}
		}
		return null;
	}
	
	@RequestMapping(value="/groupview_get" , method = RequestMethod.GET)
	public String groupview_get(HttpSession session , Model model){
		logger.info("groupview_get__jinsu");
		Member personally = (Member)session.getAttribute("Member");
		if(personally == null){
			return "redirect:/";
		}
		ArrayList<String> groupleaderlist = new ArrayList<String>();
		ArrayList<String> arraystrval = relationDAO.searchLeaderPartyName(personally.getMember_id());
		for(String s : arraystrval){
			groupleaderlist.add(s);
		}
		arraystrval.clear();
		
		// 파티 멤버의 id만 담는 배열
		ArrayList<String> groupmemberlist = new ArrayList<String>();
		
		// 아이디가 속한 파티를 불러온다
		ArrayList<Party> array_party = relationDAO.searchPartyByMemberid(personally.getMember_id());
		
		// 방금 불러온 파티의 party_num으로 파티 멤버를 불러와 멤버의 id만 배열에 담는다
		for (Party party : array_party) {
			ArrayList<PartyMember> array_memeber = relationDAO.searchPartyMember(party.getParty_num());
			for (PartyMember partyMember : array_memeber) {
				groupmemberlist.add(partyMember.getMember_id());
			}
		}
		
		model.addAttribute("leaderlist", groupleaderlist);
		model.addAttribute("memberlist", groupmemberlist);
		
		return "/groupview";
	}
	
	@RequestMapping(value="/groupPage" , method = RequestMethod.GET)
	public String groupPage_get(String group_name , Model model){
		logger.info("groupPage__jinsu");
		Party party = relationDAO.searchParty(group_name);
		if(party != null){
			ArrayList<PartyMember> arr_party_member = relationDAO.searchPartyMember(party.getParty_num());
			ArrayList<Member> arr_member = new ArrayList<Member>();
			for(PartyMember pm: arr_party_member){
				arr_member.add(memberDAO.selectMember(pm.getMember_id()));
			}
			model.addAttribute("partyleader" , memberDAO.selectMember(party.getParty_leader()));
			model.addAttribute("partyinfo", party);
			model.addAttribute("memberlist", arr_party_member);
			model.addAttribute("memberinfo", arr_member);
			return "/groupPage";
		}
		return "redirect:/";		
	}
}
