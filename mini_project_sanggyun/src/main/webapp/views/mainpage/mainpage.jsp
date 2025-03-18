<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>

	<title>Strata by HTML5 UP</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="is-preload">

	<!-- Header -->
		<header id="header">
			<div class="inner">
				<a href="#" class="image avatar"><img src="images/avatar.jpg" alt="" /></a>
				<h1><strong>${sessionScope.userDTO.nickname}</strong><br></h1>
					${sessionScope.userDTO.introduction}
					<li><a href="${pageContext.request.contextPath}/views/user/mypage.jsp">마이페이지테스트</a></li>
			</div>
		</header>

	<!-- Main -->
		<div id="main">

			<!-- Two -->
				<section id="two">
					<h2>해시태그 1</h2>
					<div class="row">
						<article class="bord">
							<a href="images/fulls/01.jpg" class="image fit thumb"><img src="images/thumbs/01.jpg" alt="" /></a>
							<h3>제목1</h3>
							<p>내용1</p>
						</article>
						<article class="bord">
							<a href="images/fulls/02.jpg" class="image fit thumb"><img src="images/thumbs/02.jpg" alt="" /></a>
							<h3>제목2</h3>
							<p>내용2</p>
						</article>
						<article class="bord">
							<a href="images/fulls/03.jpg" class="image fit thumb"><img src="images/thumbs/03.jpg" alt="" /></a>
							<h3>제목3</h3>
							<p>내용3</p>
						</article>
					</div>

					<hr>
					<h2>해시태그 2</h2>
					<div class="row">
						<article class="bord">
							<a href="images/fulls/04.jpg" class="image fit thumb"><img src="images/thumbs/04.jpg" alt="" /></a>
							<h3>제목1</h3>
							<p>내용1</p>
						</article>
						<article class="bord">
							<a href="images/fulls/05.jpg" class="image fit thumb"><img src="images/thumbs/05.jpg" alt="" /></a>
							<h3>제목2</h3>
							<p>내용2</p>
						</article>
						<article class="bord">
							<a href="images/fulls/06.jpg" class="image fit thumb"><img src="images/thumbs/06.jpg" alt="" /></a>
							<h3>제목3</h3>
							<p>내용3</p>
						</article>
					</div>

					<hr>
					<h2>해시태그 3</h2>
					<div class="row">
						<article class="bord">
							<a href="images/fulls/04.jpg" class="image fit thumb"><img src="images/thumbs/04.jpg" alt="" /></a>
							<h3>제목1</h3>
							<p>내용1</p>
						</article>
						<article class="bord">
							<a href="images/fulls/05.jpg" class="image fit thumb"><img src="images/thumbs/05.jpg" alt="" /></a>
							<h3>제목2</h3>
							<p>내용2</p>
						</article>
						<article class="bord">
							<a href="images/fulls/06.jpg" class="image fit thumb"><img src="images/thumbs/06.jpg" alt="" /></a>
							<h3>제목3</h3>
							<p>내용3</p>
						</article>
					</div>

					<ul class="actions">
						<li><a href="#" class="button">전체 글</a></li>
					</ul>
				</section>

		</div>

	<!-- Footer -->
		<footer id="footer">
			<div class="inner">
				<ul class="icons">
					<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="#" class="icon brands fa-github"><span class="label">Github</span></a></li>
					<li><a href="#" class="icon brands fa-dribbble"><span class="label">Dribbble</span></a></li>
					<li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
				</ul>
			</div>
		</footer>

	<!-- Scripts -->
		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/jquery.poptrox.min.js"></script>
		<script src="assets/js/browser.min.js"></script>
		<script src="assets/js/breakpoints.min.js"></script>
		<script src="assets/js/util.js"></script>
		<script src="assets/js/main.js"></script>
	
</body>
</html>