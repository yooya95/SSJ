package com.oracle.S202350102.service.thService;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.oracle.S202350102.dao.thDao.ThOrder1Dao;
import com.oracle.S202350102.dto.KakaoPayApprovalVO;
import com.oracle.S202350102.dto.KakaoPayCancelVO;
import com.oracle.S202350102.dto.KakaoPayReadyVO;
import com.oracle.S202350102.dto.Order1;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ThKakaoPayImpl implements ThKakaoPay {
    
	private static final String HOST = "https://kapi.kakao.com";
    
    private 		KakaoPayReadyVO 	kakaoPayReadyVO;
    private 		KakaoPayApprovalVO	kakaoPayApprovalVO;
    private			KakaoPayCancelVO	kakaoPayCancelVO;
    private final 	ThOrder1Dao			od1;
    
    //결제 요청및 인증
    public String kakaoPayReady(Order1 order1) {
    	System.out.println("ThKakaoPayImpl kakaoPayReady Start...");
    	System.out.println("kakaoPayReady order1 --> " + order1);
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "47b09ab850144b4a5618939d2b5cb91f");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("partner_order_id", order1.getOrder_num()+"");
        params.add("item_code", order1.getMem_num()+"");
        params.add("partner_user_id", order1.getUser_num()+"");
        params.add("item_name", order1.getMem_name());
        params.add("quantity", "1");
        params.add("total_amount", order1.getPrice()+"");
        params.add("tax_free_amount", "100");
        params.add("approval_url", "https://localhost:8222/kakaoPaySuccess?order_num=" + order1.getOrder_num());
        params.add("cancel_url", "https://localhost:8222/kakaoPayCancel");
        params.add("fail_url", "https://localhost:8222/kakaoPayFail");
 
         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
            
            // order1객체에 tid를담고 order1테이블에 tid를 업데이트 (tid:카카오페이에서 제공하는 결제 한 건에 대한  고유번호)
            order1.setTid(kakaoPayReadyVO.getTid());
            int updateResult = od1.updateTid(order1);
            System.out.println("ThKakaoPayImpl kakaoPayReady Tid updateResult --> " + updateResult);
            
            log.info("" + kakaoPayReadyVO);
            return kakaoPayReadyVO.getNext_redirect_pc_url();
 
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (Exception e) {
        	e.printStackTrace();
		}
        
        return "/pay";   
    }
    
    // 결제승인후 값 가져옴
    public KakaoPayApprovalVO kakaoPayInfo(String pg_token, Order1 order1) {
    	 
        log.info("KakaoPayInfoVO............................................");
        log.info("-----------------------------");
        System.out.println("kakaoPayInfo order1 --> " + order1);
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "47b09ab850144b4a5618939d2b5cb91f");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
 
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", kakaoPayReadyVO.getTid());
        params.add("partner_order_id", order1.getOrder_num()+"");
        params.add("partner_user_id", order1.getUser_num()+"");
        params.add("item_code", order1.getMem_num()+"");
        params.add("pg_token", pg_token);
        params.add("total_amount", order1.getPrice()+"");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
        
        try {
            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
            log.info("" + kakaoPayApprovalVO);
          
            return kakaoPayApprovalVO;
        
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    //결제 환불
    public KakaoPayCancelVO kakaoPayCancel(Order1 order1) {
    	System.out.println("ThKakaoPayImpl kakaoPayCancel Start...");
    	System.out.println("ThKakaoPayImpl kakaoPayCancel order1 --> " + order1);
        RestTemplate restTemplate = new RestTemplate();
 
        // 서버로 요청할 Header
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + "47b09ab850144b4a5618939d2b5cb91f");
        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        
        // 서버로 요청할 Body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("cid", "TC0ONETIME");
        params.add("tid", order1.getTid()+"");
        params.add("cancel_amount", order1.getPrice()+"");
        params.add("cancel_tax_free_amount", "100");
        
        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
 
        try {
            kakaoPayCancelVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/cancel"), body, KakaoPayCancelVO.class);

            log.info("" + kakaoPayCancelVO);
            return kakaoPayCancelVO;
 
        } catch (RestClientException e) {
            e.printStackTrace();
        } catch (URISyntaxException e) {
            e.printStackTrace();
        } catch (Exception e) {
        	e.printStackTrace();
		}
        
        return null;
    }
}
