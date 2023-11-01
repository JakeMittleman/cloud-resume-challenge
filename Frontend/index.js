window.addEventListener('load', function() {
    fetch("https://api.jakemittlemanresu.me/visits")
    .then((response) => response.json())
    .then((json) => {
        document.getElementById("visitor-count").innerText = json["visit_count"]
    });
})