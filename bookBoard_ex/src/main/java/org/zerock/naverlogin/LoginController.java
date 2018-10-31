package org.zerock.naverlogin;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class LoginController {
	
	@Setter (onMethod_= {@Autowired})
	private BoardService service;

    /* NaverLoginBO */
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;
    
    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    //�α��� ù ȭ�� ��û �޼ҵ�
    @RequestMapping(value = "/users/naverlogin", method = { RequestMethod.GET, RequestMethod.POST })
    public String login(Model model, HttpSession session) {
        
        /* ���̹����̵�� ���� URL�� �����ϱ� ���Ͽ� naverLoginBOŬ������ getAuthorizationUrl�޼ҵ� ȣ�� */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
        System.out.println("���̹�:" + naverAuthUrl);
        
        //���̹� 
        model.addAttribute("url", naverAuthUrl);

        /* ������ ���� URL�� View�� ���� */
        return "users/naverlogin";
    }

    //���̹� �α��� ������ callbackȣ�� �޼ҵ�
    @RequestMapping(value = "/users/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
            throws IOException {
        System.out.println("����� callback");
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //�α��� ����� ������ �о�´�.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
        System.out.println(naverLoginBO.getUserProfile(oauthToken).toString());
        model.addAttribute("result", apiResult);
        System.out.println("result111"+apiResult);
        /* ���̹� �α��� ���� ������ View ȣ�� */
//      JSONObject jsonobj = jsonparse.stringToJson(apiResult, "response");
//      String snsId = jsonparse.JsonToString(jsonobj, "id");
//      String name = jsonparse.JsonToString(jsonobj, "name");
//
//      UserVO vo = new UserVO();
//      vo.setUser_snsId(snsId);
//      vo.setUser_name(name);
//
//      System.out.println(name);
//      try {
//          vo = service.naverLogin(vo);
//      } catch (Exception e) {
//          // TODO Auto-generated catch block
//          e.printStackTrace();
//      }


//      session.setAttribute("login",vo);
//      return new ModelAndView("user/loginPost", "result", vo);
        
        return "users/naversuccess";
    }
    
    
    @PostMapping("/users/naversignup")
    public String naverinfo(NaverVO vo,  HttpSession session) {
    	
    	session.setAttribute("s_ID", vo.getEmail());
    	session.setAttribute("s_img", vo.getImg());
    	
    	BoardVO vo2 = new BoardVO();
    	vo2.setUser_id(vo.getEmail());
    	vo2.setUser_pw("NaverLogin!#@@#@#");
    	vo2.setUser_email(vo.getEmail());
    	vo2.setUser_signature("안녕하세요");
    	
    	if(vo.getImg() != null) {
    		vo2.setUser_img(vo.getImg());    		
    	}else {
    		vo2.setUser_img("/user/default-user.png");
    	}
    	vo2.setUser_name(vo.getName());
    	log.info("Naver getImg-------------------------"+vo.getImg());
    	
    	if(service.get(vo2.getUser_id()) != null ) {
    		session.setAttribute("s_ID", vo.getEmail());
        	session.setAttribute("s_img", vo.getImg());
    	}else {
    		service.APIinsert(vo2);    		
    		session.setAttribute("s_ID", vo.getEmail());
    		session.setAttribute("s_img", vo.getImg());
    	}
    	
    	
    	return "redirect:/board/list?page=1";
    }
}