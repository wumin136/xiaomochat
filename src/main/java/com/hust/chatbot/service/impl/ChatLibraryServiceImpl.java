package com.hust.chatbot.service.impl;

import com.hust.chatbot.mapper.ChatLibraryMapper;
import com.hust.chatbot.service.ChatLibraryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatLibraryServiceImpl implements ChatLibraryService {

    @Autowired
    ChatLibraryMapper chatLibraryMapper;

}
