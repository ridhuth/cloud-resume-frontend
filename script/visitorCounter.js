function counter() {

fetch('https://y6v9mkpq3b.execute-api.us-east-1.amazonaws.com/default/updateDynamoDB')
.then(response => response.json()) 
.then(data => {
    console.log(data.Attributes["count"]["N"]);
    document.getElementById("viewCount").innerHTML = data.Attributes["count"]["N"];
 })
}

document.addEventListener("DOMContentLoaded",counter);
