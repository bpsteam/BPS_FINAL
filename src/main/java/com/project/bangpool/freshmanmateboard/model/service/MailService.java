package com.project.bangpool.freshmanmateboard.model.service;

public interface MailService {
	public boolean send(String subject, String text, String from, String to, String filePath);
}
