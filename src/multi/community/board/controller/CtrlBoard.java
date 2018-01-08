package multi.community.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import main.Controller;
import main.ModelAndView;
import main.ModelAttribute;
import main.RequestMapping;
import main.ResponseBody;
import main.vo.Community_boardVO;
import main.vo.Community_board_repleVO;
import multi.community.board.dao.Community_boardDAO;
import multi.community.board.dao.Community_boardrepleDAO;

@Controller
public class CtrlBoard {
	
	@Autowired @Qualifier("community_boardDAO")
	private Community_boardDAO community_boardDAO = null;
	
	@Autowired @Qualifier("community_boardrepleDAO")
	private Community_boardrepleDAO community_boardrepleDAO = null;
	
	
	//Ŀ�´�Ƽ ���� 
	 @RequestMapping("/community_board_list.do")
	   public ModelAndView community_board() throws Exception{
	      ModelAndView mnv = new ModelAndView("community_board_list");
	      List<Community_boardVO> rl = community_boardDAO.findAll();
	      mnv.addObject("rl",rl);
	      return mnv;
	   }
	 
	 
	 @RequestMapping("/community_board_add.do")
	 public ModelAndView community_board_add(@ModelAttribute Community_boardVO pvo ) throws Exception{
		 ModelAndView mnv = new ModelAndView("community_board_add2");
		 return mnv;
		 
	 }
	 
	 @RequestMapping("/community_board_add2.do")
	 public String community_board_add2(@ModelAttribute Community_boardVO pvo)throws Exception {
		 community_boardDAO.add(pvo);
		 return "redirect:/community_board_list.do";
	 }
	 
	 
	 @RequestMapping("/community_board_read.do")
	 public ModelAndView community_board_read(@ModelAttribute Community_boardVO pvo, @ModelAttribute Community_board_repleVO rvo) throws Exception{
		 System.out.println("qwer"+pvo.getCom_board_no());
		 Community_boardVO bvo = community_boardDAO.findByPK(pvo);
		 ModelAndView mnv = new ModelAndView("community_board_read");
		 mnv.addObject("vo", bvo);
		 
		 community_boardDAO.incViewLogic(pvo);
		 List<Community_board_repleVO> rl = community_boardrepleDAO.findAllreple(rvo);
		 mnv.addObject("rl",rl);
		 
	
		 return mnv;
		 
	 }
	 
	 
	 @RequestMapping("/community_board_mod.do")
	 public ModelAndView community_board_mod (@ModelAttribute Community_boardVO pvo)throws Exception {
		ModelAndView mnv= new ModelAndView("community_board_mod2");
		mnv.addObject("mvo", pvo);
		return mnv;
		 
	 } 
	 
	 @RequestMapping("/community_board_mod2.do")
	 public String community_board_mod2(@ModelAttribute Community_boardVO pvo)throws Exception {
		 community_boardDAO.mod(pvo);
		 return "redirect:/community_board_read.do?com_board_no="+pvo.getCom_board_no();
		 
	 }
	 
	 
	 @RequestMapping("/community_board_del.do")
	 
	 public String community_board_del(@ModelAttribute Community_boardVO pvo)throws Exception {
		 	community_boardDAO.delByPK(pvo);
			return "redirect:/community_board_list.do";
	 }
	 
	 
	@RequestMapping("/community_board_recom.do")
	@ResponseBody
	 public String community_board_recom(@ModelAttribute Community_boardVO pvo)throws Exception {
		System.out.println(pvo.getCom_board_no());
		 community_boardDAO.incRecomLogic(pvo);
		System.out.println(pvo.getRecom_count());
		 return pvo.getRecom_count().toString();
	 
	 }
	 
	
	//Ŀ�´�Ƽ ���� �� ����
	@RequestMapping("/community_board_addreple.do")
	public String community_board_addreple( @ModelAttribute Community_board_repleVO  pvo) throws Exception {
		community_boardrepleDAO.addReple(pvo);
		return "redirect:/community_board_read.do?com_board_no="+pvo.getCom_board_no();
	}
	
	@RequestMapping("/community_board_replemod.do")
	public String community_board_replemod(@ModelAttribute  Community_board_repleVO  pvo) throws Exception {
		community_boardrepleDAO.modReple(pvo);
		return  "redirect:/community_board_read.do?com_board_no="+pvo.getCom_board_no();
	}
	
	@RequestMapping("/community_board_repledel.do")
	public String community_board_repledel(@ModelAttribute  Community_board_repleVO  pvo) throws Exception {
		System.out.println("aa"+pvo.getCom_board_no());
	community_boardrepleDAO.delReple(pvo);
	return "redirect:/community_board_read.do?com_board_no="+pvo.getCom_board_no();
	}

}