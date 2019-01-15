package com.hust.chatbot.controller;

import com.hust.chatbot.service.ActiveRankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

public class ActiveRankController {

    @Autowired
    ActiveRankService activeRankService;

}
