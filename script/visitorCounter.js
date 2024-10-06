let countField;


function counter() {

    fetch('https://y6v9mkpq3b.execute-api.us-east-1.amazonaws.com/default/updateDynamoDB')
    .then(response => response.json()) 
    .then(data => {
        console.log(data.Attributes["count"]["N"]);
        document.getElementById("viewCount").innerHTML = data.Attributes["count"]["N"];
        countField = data.Attributes["count"]["N"];
        sessionStorage.setItem("count",countField);
     })
    }



// See if we have a viewed value
if (sessionStorage.getItem("viewed") === null) {
    counter();
    // let countField = document.getElementById("viewCount").innerHTML;
    sessionStorage.setItem("viewed","true");
}
else {
    document.getElementById("viewCount").innerHTML = sessionStorage.getItem("count")
}



// document.addEventListener("DOMContentLoaded",counter);


