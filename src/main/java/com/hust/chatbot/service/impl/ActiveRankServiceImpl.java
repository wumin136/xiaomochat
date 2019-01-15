package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.ActiveRankMapper;
import com.hust.chatbot.service.ActiveRankService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ActiveRankServiceImpl implements ActiveRankService {

    @Autowired
    ActiveRankMapper activeRankMapper;
}
