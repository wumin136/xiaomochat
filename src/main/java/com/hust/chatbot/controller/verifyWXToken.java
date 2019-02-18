package com.hust.chatbot.controller;

import com.hust.chatbot.util.SignUtil;
import com.hust.chatbot.util.MessageUtil;
import com.hust.chatbot.domain.TextMessage;
import org.dom4j.DocumentException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.Map;

/**
 * 核心请求处理类
 *
 */

public class verifyWXToken extends HttpServlet {
    private static final long serialVersionUID = 4440739483644821986L;

    /**
     * 确认请求来自微信服务器
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("-----开始校验签名-----");
        // 微信加密签名
        String signature = request.getParameter("signature");
        // 时间戳
        String timestamp = request.getParameter("timestamp");
        // 随机数
        String nonce = request.getParameter("nonce");
        // 随机字符串
        String echostr = request.getParameter("echostr");

        PrintWriter out = response.getWriter();
        // 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
        if (SignUtil.checkSignature(signature, timestamp, nonce)) {
            out.print(echostr);
        }
        out.close();
        out = null;
    }

    /**
     * 处理微信服务器发来的消息
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO 消息的接收、处理、响应
        request.setCharacterEncoding("UTF-8");//转换编码方式
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();//通过PrintWriter返回消息至微信后台

        //接收消息
        try {
            Map<String,String> map = MessageUtil.xmlToMap(request);
            String fromUserName = map.get("FromUserName");//发送方帐号（一个OpenID）
            String toUserName = map.get("ToUserName");//开发者微信号
            String msgType = map.get("MsgType");//text//如果是文本消息的话，MsgType="text"
            String content = map.get("Content");//文本消息内容
            String MsgId = map.get("MsgId");//消息ID

            String line;
            String lines = "";
            String message = null;

            //执行python脚本———聊天
            Process proc;
            String[] args = new String[] {"python","D:\\python\\code\\chatbot_by_similarity\\demo\\demo_knowledge_ask&answer.py",content};
            proc = Runtime.getRuntime().exec(args);

            //使用缓冲流接受程序返回的结果
            BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream(),"GBK"));//注意格式
            while((line = in.readLine())!=null) {
                lines += (line + "\n");
            }
            in.close();
            proc.waitFor();

            //判断是否为文本消息
            if("text".equals(msgType)) {
                TextMessage text = new TextMessage();
                text.setFromUserName(toUserName);//注意，这里发送者与接收者调换了
                text.setToUserName(fromUserName);
                text.setMsgType("text");//文本类型
                text.setCreateTime(new Date().getTime());//当前时间
                text.setContent(lines);//返回消息
                text.setMsgId(MsgId);//消息ID

                //排重
                boolean isDuplicate = MessageUtil.isDuplicate(map);
                if(isDuplicate)
                    return;

                //将文本消息转换为xml
                message = MessageUtil.textMessageToXml(text);

                System.out.println(message);
            }
            out.print(message);//返回消息
        } catch (InterruptedException | DocumentException e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}
