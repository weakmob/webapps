<%@page import="aiwa.entity.Anime"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>animeListView</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<%
ArrayList<Anime> animes = (ArrayList<Anime>) request.getAttribute("animes");
String word = (String) request.getAttribute("word");
%>

<style>

html {
    scroll-behavior: smooth;
}
#navbar {
  transition: top 0.4s ease, opacity 0.4s ease;
}
.nav-hidden {
  top: -70px; /* move navbar up out of view */
  opacity: 0;
}


/* Navbar brand floating effect */
.navbar-brand {
    position: relative;
    display: inline-block;
    transition: transform 0.3s ease, color 0.3s ease;
    cursor: pointer; /* show pointer */
}

.navbar-brand:hover {
    transform: translateY(-2px); /* lift up */
    color: #ff4d4d; /* optional: change color on hover */
    text-shadow: 0 4px 6px rgba(0,0,0,0.3); /* optional: subtle shadow for "floating" */
}

.logo {
  width: 50px; /* try 30–60 depending on how subtle you want it */
  height: auto;
  margin-left: 8px; /* keeps text from sticking to it */
  vertical-align: middle;
}


.card {
    box-shadow: 5px 5px 20px rgba(251, 5, 5, 0.826);
    margin: auto; 
    opacity: 0;
    transform: translateY(20px);
    animation: fadeInUp 0.5s forwards;
}
@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }



/* Title and text styling - allow wrapping */
.card-title, .card-text {
    font-size: 1rem;
    white-space: normal !important;   /* allow wrapping */
    overflow: visible !important;
    text-overflow: unset !important;
}

/* Button hover glow effect */
.btn-danger {
    transition: 0.3s;
}

.btn-danger:hover {
    box-shadow: 0 0 15px rgba(255, 0, 0, 0.7);
}



</style>
</head>

<body style="background-color: rgb(18, 18, 28);">
<div class="container">

<!-- NAVBAR -->
<nav id="navbar" class="navbar bg-dark border-bottom border-body fixed-top" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="<%=request.getContextPath()%>/AnimeListController">
      MUST WATCH ANIME 紹介 
      <img src="https://www.pngall.com/wp-content/uploads/13/Anime-Logo-PNG-HD-Image.png" class="logo">
    </a>
    <form class="d-flex ms-auto" action="AnimeListController" method="get" role="search">
      <input class="form-control me-2" type="search" name="word" placeholder="Search anime..." value="<%=word%>" aria-label="Search" />
      <button class="btn btn-danger d-flex align-items-center" type="submit">
        <i class="bi bi-search-heart-fill" style="font-size:1.2rem;"></i>
      </button>
    </form>
  </div>
</nav>
<!-- NAVBAR END -->


  <!-- CARDS -->
<div class="container mt-4">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
        <% for (Anime a : animes) { %>
            <div class="col">
                <div class="card text-bg-dark h-100">
                    <img src="<%=a.getImage()%>" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title text-danger"><%=a.getAnimename()%></h5><hr>
                        <p class="card-text">GENRE: <%=a.getGenre()%></p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="<%= a.getLink() %>" target="_blank" class="btn btn-danger w-100">
                            WATCH NOW
                        </a>
                    </div>
                </div>
            </div>
        <% } %>
    </div>
</div>
<!-- CARDS END -->

 <!-- Scroll-to-top button -->
        <button id="topBtn" class="btn btn-danger position-fixed bottom-0 end-0 m-3" style="display:none;">
            <i class="bi bi-arrow-up-circle-fill" style="font-size: 1.5rem;"></i>
        </button>

        <script>

<!--        scrollToTopBtn-->
            const topBtn = document.getElementById("topBtn");

            window.onscroll = function () {
                if (window.scrollY > 100) {
                    topBtn.style.display = "block";
                } else {
                    topBtn.style.display = "none";
                }
            };

            topBtn.onclick = function () {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            };


<!--            NavBar -->
            let lastScrollY = window.scrollY;
            let navbar = document.getElementById('navbar');
            let hideTimeout;

            window.addEventListener('scroll', () => {
              // Scrolling down → hide navbar
              if (window.scrollY > lastScrollY && window.scrollY > 100) {
                navbar.classList.add('nav-hidden');
              } 
              // Scrolling up → show navbar briefly
              else if (window.scrollY < lastScrollY) {
                navbar.classList.remove('nav-hidden');
                clearTimeout(hideTimeout);
                hideTimeout = setTimeout(() => {
                  if (window.scrollY > 100) navbar.classList.add('nav-hidden');
                }, 3000); // re-hide after 3 seconds
              }

              lastScrollY = window.scrollY;
            });
                        
        </script>



</div>

</body>
</html>
