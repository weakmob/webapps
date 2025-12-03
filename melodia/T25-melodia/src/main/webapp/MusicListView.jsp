<%@ page import="aiwa.entity.Music"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Melodia — Discover Music</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
    ArrayList<Music> musics = (ArrayList<Music>) request.getAttribute("musics");
    String word = request.getParameter("word") != null ? request.getParameter("word") : "";
    String selectedLang = request.getParameter("lang") != null ? request.getParameter("lang") : "";
    String selectedGenre = request.getParameter("genre") != null ? request.getParameter("genre") : "";
    String selectedSort = request.getParameter("sort") != null ? request.getParameter("sort") : "";
    int total = (musics == null) ? 0 : musics.size();
%>

<style>

/* Background */
body {
    background: linear-gradient(145deg, #e9f1ff 0%, #dfe7ff 40%, #f1f4ff 100%);
    color: #1c1c1e;
    font-family: "Inter", "Segoe UI", sans-serif;
    min-height: 100vh;
}

/* Navbar */
.navbar {
    height: 64px;
    background: white;
    border-bottom: 1px solid rgba(0,0,0,0.1);
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

.navbar-brand {
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 700;
    font-size: 1.2rem;
    color: #ff6b9d;
    text-decoration: none;
}

.navbar-brand img {
    height: 38px;
    width: 38px;
    border-radius: 8px;
}


/* HERO */
.hero {
    padding: 72px 20px 28px;
    text-align: center;
}

.hero-title {
    font-size: 38px;
    font-weight: 800;
    background: linear-gradient(90deg, #1c1c1e, #ff6b9d);
    -webkit-background-clip: text;
    color: transparent;
}

.hero-sub {
    margin-top: 8px;
    color: #6f6f6f;
}


/* GRID */
.video-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 22px;
    padding: 20px 10px 40px;
}

/* CARD */
.video-card {
    background: white;
    border-radius: 14px;
    box-shadow: 0 6px 18px rgba(12,12,12,0.08);
    overflow: hidden;
    transition: 0.25s ease;
    cursor: pointer;
}

.video-card:hover {
    transform: translateY(-7px);
    box-shadow: 0 16px 28px rgba(12,12,12,0.15);
}

.video-thumb {
    width: 100%;
    height: 150px;
    object-fit: cover;
}

.video-info {
    padding: 12px;
}

.video-title {
    font-size: 16px;
    font-weight: 600;
}

.video-artist {
    font-size: 14px;
    opacity: 0.75;
}


/* STICKY VIDEO PLAYER */
#sidePlayer {
    position: fixed;
    top: 90px;
    right: 25px;
    width: 360px;
    height: 220px;
    background: black;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
    display: none;
    z-index: 9999;
}

#sidePlayerFrame {
    width: 100%;
    height: 100%;
}

#closePlayer {
    position: absolute;
    top: 6px;
    right: 6px;
    width: 28px;
    height: 28px;
    border: none;
    border-radius: 50%;
    background: rgba(255,255,255,0.85);
    color: black;
    cursor: pointer;
    font-weight: bold;
}

#closePlayer:hover {
    background: white;
}

</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar fixed-top">
    <div class="container-fluid px-4 d-flex align-items-center justify-content-between">

        <a class="navbar-brand" href="<%=request.getContextPath()%>/MusicListController">
            <img src="<%=request.getContextPath()%>/images/melodialogo.png" alt="Melodia logo">
            Melodia
        </a>

        <!-- Filters + Search -->
        <form action="MusicListController" method="get" class="d-flex align-items-center w-75 justify-content-center">

            <div class="filters me-3 d-flex gap-2">
                <select name="lang" class="form-select select-filter" onchange="this.form.submit()">
                    <option value="">すべての曲</option>
                    <option value="en" <%= selectedLang.equals("en")?"selected":"" %>>英語曲</option>
                    <option value="jp" <%= selectedLang.equals("jp")?"selected":"" %>>日本曲</option>
                    <option value="np" <%= selectedLang.equals("np")?"selected":"" %>>ネパール曲</option>
                    <option value="in" <%= selectedLang.equals("in")?"selected":"" %>>インド曲</option>
                </select>

                <select name="genre" class="form-select select-filter" onchange="this.form.submit()">
                    <option value="">すべてのジャンル</option>
                    <option value="Pop" <%= selectedGenre.equals("Pop")?"selected":"" %>>ポップ</option>
                    <option value="Rock" <%= selectedGenre.equals("Rock")?"selected":"" %>>ロック</option>
                    <option value="EDM" <%= selectedGenre.equals("EDM")?"selected":"" %>>EDM</option>
                    <option value="Folk" <%= selectedGenre.equals("Folk")?"selected":"" %>>フォーク</option>
                </select>

                <select name="sort" class="form-select select-filter" onchange="this.form.submit()">
                    <option value="">並び替え：デフォルト</option>
                    <option value="name" <%= selectedSort.equals("name")?"selected":"" %>>Name (A–Z)</option>
                    <option value="newest" <%= selectedSort.equals("newest")?"selected":"" %>>最新</option>
                </select>
            </div>

            <div class="search-wrap d-flex align-items-center">
                <input class="form-control search-input" name="word" value="<%=word%>" placeholder="Search...">
                <button class="btn btn-search ms-2"><i class="bi bi-search"></i></button>
            </div>

        </form>
    </div>
</nav>


<!-- HERO -->
<header class="hero" style="margin-top: 64px;">
    <div class="container-main text-center">
        <h1 class="hero-title"><i class="bi bi-headphones me-2"></i> 音楽でつながる世界</h1>
        <p class="hero-sub">music video (MV) — curated & elegant</p>
    </div>
</header>


<!-- MAIN -->
<main class="container-main px-3">

    <div class="mb-3">
        Showing <strong><%=total%></strong> results
    </div>

    <div class="video-grid">

        <% if (musics != null) {
            for (Music m : musics) {
                String ytId = m.getMusic_url();
                String thumb = "https://img.youtube.com/vi/" + ytId + "/mqdefault.jpg";
        %>

        <div class="video-card" onclick="playSideVideo('<%=ytId%>')">
            <img src="<%=thumb%>" class="video-thumb">

            <div class="video-info">
                <div class="video-title"><%=m.getName()%></div>
                <div class="video-artist"><i class="bi bi-person-fill"></i> <%=m.getArtist()%></div>
            </div>
        </div>

        <% } } %>

    </div>
</main>


<!-- STICKY PLAYER -->
<div id="sidePlayer">
    <iframe id="sidePlayerFrame" src="" allowfullscreen></iframe>
    <button id="closePlayer" onclick="closeSidePlayer()">×</button>
</div>

<script>
function playSideVideo(ytId) {
    document.getElementById("sidePlayer").style.display = "block";
    document.getElementById("sidePlayerFrame").src =
        "https://www.youtube.com/embed/" + ytId + "?autoplay=1&rel=0";
}

function closeSidePlayer() {
    document.getElementById("sidePlayerFrame").src = "";
    document.getElementById("sidePlayer").style.display = "none";
}
</script>

</body>
</html>
