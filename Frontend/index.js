window.addEventListener('load', function() {
    requestBody = {
        "table_name": "s3.jakemittlemanresu.me",
        "db_key": "id",
        "db_key_value": "1",
        "db_attribute": "visits"
    }
    fetch(
        "https://gk3353sikk.execute-api.us-east-1.amazonaws.com/cloud-resume-challenge/visits",
        json=requestBody
    ).then((response) => response.json())
    .then((json) => {
        document.getElementById("visitor-count").innerText = json["visit_count"]
    });
})