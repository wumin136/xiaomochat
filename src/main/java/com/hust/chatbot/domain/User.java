package com.hust.chatbot.domain;

import javax.validation.constraints.Size;
import java.io.File;

public class User {

    @Size(max = 10,message = "{id.length.error}")
    private String userId;

    @Size(max = 50,message = "{name.length.error}")
    private String userName;

    private String userStatus;

    private String chatFile;


    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public String getChatFile() {
        return chatFile;
    }

    public void setChatFile(String chatFile) {
        this.chatFile = chatFile;
    }
}
