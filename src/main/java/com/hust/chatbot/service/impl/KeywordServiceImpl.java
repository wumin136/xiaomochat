package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.KeywordMapper;
import com.hust.chatbot.service.KeywordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KeywordServiceImpl implements KeywordService {

    @Autowired
    KeywordMapper keywordMapper;
}
