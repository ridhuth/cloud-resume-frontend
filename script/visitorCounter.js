let countField;


function counter() {

    fetch('https://y6v9mkpq3b.execute-api.us-east-1.amazonaws.com/default/updateDynamoDB')
    .then(response => response.json()) 
    .then(data => {
        console.log(data.Attributes["count"]["N"]);
        document.getElementById("viewCount").innerHTML = data.Attributes["count"]["N"];
        return data.Attributes["count"]["N"];
     })
    }



// See if we have a viewed value
if (sessionStorage.getItem("viewed") === null) {
    countField = counter();
    // let countField = document.getElementById("viewCount").innerHTML;
    sessionStorage.setItem("count",countField);
    sessionStorage.setItem("viewed","true");
}
else {
    document.getElementById("viewCount").innerHTML = sessionStorage.getItem("count")
}



// document.addEventListener("DOMContentLoaded",counter);


