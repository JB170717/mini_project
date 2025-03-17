<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.blog.util.GeminiExample" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gemini AI 대화형 인터페이스</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Nanum Gothic', sans-serif;
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f0f4f8;
            color: #333;
        }
        .container {
            background-color: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        header {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid #eaeaea;
            padding-bottom: 15px;
        }
        .logo {
            width: 40px;
            height: 40px;
            margin-right: 15px;
            background-color: #4285f4;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }
        h1 {
            color: #4285f4;
            margin: 0;
            font-size: 24px;
        }
        .subtitle {
            color: #666;
            margin-top: 5px;
            font-size: 14px;
        }
        .chat-container {
            max-height: 400px;
            overflow-y: auto;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .message {
            padding: 12px 15px;
            margin: 8px 0;
            border-radius: 8px;
            position: relative;
            max-width: 80%;
        }
        .user-message {
            background-color: #4285f4;
            color: white;
            margin-left: auto;
            border-top-right-radius: 0;
        }
        .ai-message {
            background-color: #f1f1f1;
            color: #333;
            margin-right: auto;
            border-top-left-radius: 0;
        }
        .message-time {
            font-size: 10px;
            position: absolute;
            bottom: 2px;
            right: 8px;
            opacity: 0.7;
        }
        .user-message .message-time {
            color: rgba(255,255,255,0.8);
        }
        textarea {
            width: calc(100% - 30px);
            height: 120px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            resize: none;
            font-size: 16px;
            font-family: inherit;
            outline: none;
            transition: border-color 0.3s;
        }
        textarea:focus {
            border-color: #4285f4;
            box-shadow: 0 0 0 2px rgba(66, 133, 244, 0.2);
        }
        .input-container {
            position: relative;
        }
        button {
            background-color: #4285f4;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s;
        }
        button i {
            margin-right: 8px;
        }
        button:hover {
            background-color: #2b68c5;
        }
        .settings {
            margin: 20px 0;
            padding: 15px;
            background-color: #f1f1f1;
            border-radius: 8px;
            display: none;
        }
        .settings-toggle {
            background-color: transparent;
            color: #555;
            border: 1px solid #ddd;
            padding: 8px 12px;
            margin-left: 10px;
            font-size: 13px;
        }
        .model-options {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .model-option {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            cursor: pointer;
        }
        .model-option.active {
            background-color: #4285f4;
            color: white;
            border-color: #4285f4;
        }
        .loading {
            display: none;
            margin: 20px 0;
            text-align: center;
            color: #666;
        }
        .loading i {
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .info-box {
            background-color: #e8f0fe;
            padding: 10px 15px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 14px;
            color: #4285f4;
            border-left: 4px solid #4285f4;
        }
        .error-message {
            background-color: #fdeded;
            color: #d83025;
            padding: 12px 15px;
            border-radius: 8px;
            margin-top: 20px;
            border-left: 4px solid #d83025;
        }
    </style>
    <script>
        window.onload = function() {
            scrollToBottom();
            
            document.getElementById('toggleSettings').addEventListener('click', function() {
                var settings = document.getElementById('settings');
                if (settings.style.display === 'none' || !settings.style.display) {
                    settings.style.display = 'block';
                } else {
                    settings.style.display = 'none';
                }
            });
            
            document.getElementById('chatForm').addEventListener('submit', function() {
                document.getElementById('loading').style.display = 'block';
                document.getElementById('submitBtn').disabled = true;
            });
        };
        
        function scrollToBottom() {
            var chatContainer = document.querySelector('.chat-container');
            chatContainer.scrollTop = chatContainer.scrollHeight;
        }
    </script>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo"><i class="fas fa-robot"></i></div>
            <div>
                <h1>Gemini AI 대화형 인터페이스</h1>
                <p class="subtitle">Google의 최신 AI 기술을 활용한 대화 시스템</p>
            </div>
            <button id="toggleSettings" class="settings-toggle"><i class="fas fa-cog"></i> 설정</button>
        </header>
        
        <div id="settings" class="settings">
            <h3>모델 정보</h3>
            <p>현재 사용 중인 AI 모델:</p>
            <div class="model-options">
                <div class="model-option active" data-model="gemini-2.0-flash">Gemini 2.0 Flash</div>
            </div>
        </div>
        
        <div class="chat-container">
            <%
            List<String[]> chatHistory = (List<String[]>) session.getAttribute("chatHistory");
            if (chatHistory == null) {
                chatHistory = new ArrayList<>();
                chatHistory.add(new String[]{"ai", "안녕하세요! Gemini AI입니다. 무엇을 도와드릴까요?", new SimpleDateFormat("HH:mm").format(new Date())});
                session.setAttribute("chatHistory", chatHistory);
            }
            
            String prompt = request.getParameter("prompt");
            if (prompt != null && !prompt.trim().isEmpty()) {
                try {
                    String currentTime = new SimpleDateFormat("HH:mm").format(new Date());
                    chatHistory.add(new String[]{"user", prompt, currentTime});
                    
                    // gemini-2.0-flash 모델로 고정
                    String modelName = "gemini-2.0-flash";
                    
                    GeminiExample gemini = new GeminiExample();
                    
                    String res = gemini.askAi(prompt);
                    
                    chatHistory.add(new String[]{"ai", res, new SimpleDateFormat("HH:mm").format(new Date())});
                    
                    session.setAttribute("chatHistory", chatHistory);
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "오류 발생: " + e.getMessage());
                }
            }
            
            for (String[] message : chatHistory) {
                String messageType = message[0];
                String messageText = message[1];
                String messageTime = message[2];
                
                if ("user".equals(messageType)) {
            %>
                <div class="message user-message">
                    <%= messageText %>
                    <span class="message-time"><%= messageTime %></span>
                </div>
            <% } else { %>
                <div class="message ai-message">
                    <%= messageText %>
                    <span class="message-time"><%= messageTime %></span>
                </div>
            <% } 
            }
            %>
        </div>
        
        <div id="loading" class="loading">
            <i class="fas fa-spinner"></i> AI가 응답을 생성하고 있습니다...
        </div>
        
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
        
        <form method="post" id="chatForm">
            <div class="input-container">
                <textarea name="prompt" placeholder="메시지를 입력하세요..." required></textarea>
                <input type="hidden" id="modelName" name="modelName" value="gemini-2.0-flash">
            </div>
            <button type="submit" id="submitBtn"><i class="fas fa-paper-plane"></i> 전송하기</button>
            <button type="button" onclick="location.href='?clear=true'" style="background-color: #757575;"><i class="fas fa-trash"></i> 대화 초기화</button>
        </form>
        
        <div class="info-box">
            <i class="fas fa-info-circle"></i> Gemini AI는 Google의 생성형 AI 모델로, 자연어 처리 및 다양한 질문에 대한 응답을 제공합니다.
            <br>현재 Gemini 2.0 Flash 모델을 사용 중입니다.
        </div>
        
        <%
        if (request.getParameter("clear") != null) {
            session.removeAttribute("chatHistory");
            response.sendRedirect(request.getRequestURI());
        }
        %>
    </div>
</body>
</html>
