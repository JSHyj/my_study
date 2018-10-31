package org.zerock.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;



@Controller
public class GoogleLoginController {
	@Autowired
    private GoogleConnectionFactory googleConnectionFactory;
    @Autowired
    private OAuth2Parameters googleOAuth2Parameters;
 
    private OAuth2Operations oauthOperations;
    
    @Autowired
    private BoardService service;
 
    @RequestMapping(value = "/board/ggLogin", method = { RequestMethod.GET, RequestMethod.POST })
    public String join(HttpServletResponse response, Model model) {
 
        oauthOperations = googleConnectionFactory.getOAuthOperations();
        String url = oauthOperations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
        System.out.println("/googleLogin, url : " + url);
        model.addAttribute("google_url", url);
 
        return "/board/ggLogin";
    }
 
 
    
    @RequestMapping(value = "/board/googleSignInCallback", method = { RequestMethod.GET, RequestMethod.POST })
    public String doSessionAssignActionPage(HttpServletRequest request, HttpSession session) throws Exception {
 
        String code = request.getParameter("code");
 
        oauthOperations = googleConnectionFactory.getOAuthOperations();
        AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
                null);
 
        String accessToken = accessGrant.getAccessToken();
        Long expireTime = accessGrant.getExpireTime();
 
        if (expireTime != null && expireTime < System.currentTimeMillis()) {
            accessToken = accessGrant.getRefreshToken();
            System.out.printf("accessToken is expired. refresh token = {}", accessToken);
 
        }
 
        Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
        Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
        System.out.println(connection);
 
        PlusOperations plusOperations = google.plusOperations();
        Person profile = plusOperations.getGoogleProfile();
        
        BoardVO vo = new BoardVO();
        vo.setUser_id(profile.getDisplayName());
        vo.setUser_img(profile.getImageUrl());
        vo.setUser_name(profile.getDisplayName());
        if(profile.getAccountEmail() != null) {
        	vo.setUser_email(profile.getAccountEmail());
        }else {
        	vo.setUser_email("not");
        }
        
        vo.setUser_pw("GoogleID!@#!@#");
        vo.setUser_signature("안녕하세요^^");
        
        
        if(service.get(vo.getUser_id()) != null) {
        	session.setAttribute("s_ID", profile.getDisplayName());
            session.setAttribute("s_img", profile.getImageUrl());
        }else {
        	service.APIinsert(vo);
        	session.setAttribute("s_ID", profile.getDisplayName());
            session.setAttribute("s_img", profile.getImageUrl());
        }
        
        System.out.println("User Uid : " + profile.getId());
        System.out.println("User Name : " + profile.getDisplayName());
        System.out.println("User Email : " + profile.getAccountEmail());
        System.out.println("User Profile : " + profile.getImageUrl());
        System.out.println("User AboutME : " + profile.getAboutMe());
        System.out.println("User Emails : " + profile.getEmails()); 
        System.out.println("User emailaddress : " + profile.getEmailAddresses()); 
        
    
        // Access Token 
        try {
            System.out.println("Closing Token....");
            String revokeUrl = "https://accounts.google.com/o/oauth2/revoke?token=" + accessToken + "";
            URL url = new URL(revokeUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoOutput(true);
 
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
        } catch (Exception e) {
 
            e.printStackTrace();
        }
        return "redirect:/board/list?page=1";

    }
}
