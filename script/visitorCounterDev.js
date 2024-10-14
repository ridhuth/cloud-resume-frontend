let countField;


function counter() {

    fetch('https://y6v9mkpq3b.execute-api.us-east-1.amazonaws.com/dev/updateDynamoDB')
    .then(response => response.json()) 
    .then(data => {
        document.getElementById("viewCount").innerHTML = data.Attributes["count"]["N"];
        countField = data.Attributes["count"]["N"];
        sessionStorage.setItem("count",countField);
     })
}



if (sessionStorage.getItem("viewed") === null) {
    counter();
    sessionStorage.setItem("viewed","true");
}
else {
    document.getElementById("viewCount").innerHTML = sessionStorage.getItem("count")
}


