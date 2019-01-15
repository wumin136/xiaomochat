package com.hust.chatbot.exception;

public class ManagerException extends Exception{
    private static final long serialVersionUID = 1L;

    private String message; //异常信息

    public ManagerException(String message){
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
