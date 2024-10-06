
// See if we have a viewed value
if (sessionStorage.getItem("viewed") === null) {
    let counter = counter();
    // let countField = document.getElementById("viewCount").innerHTML;
    let countField = counter["count"]["N"];
    sessionStorage.setItem("count",countField);
    sessionStorage.setItem("viewed","true");
}
else {
    document.getElementById("viewCount").innerHTML = sessionStorage.getItem("count")
}

function counter() {

fetch('https://y6v9mkpq3b.execute-api.us-east-1.amazonaws.com/default/updateDynamoDB')
.then(response => response.json()) 
.then(data => {
    console.log(data.Attributes["count"]["N"]);
    document.getElementById("viewCount").innerHTML = data.Attributes["count"]["N"];
    return data;
 })
}

// document.addEventListener("DOMContentLoaded",counter);


