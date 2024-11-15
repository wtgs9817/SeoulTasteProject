
//가게 정보 가져오기
//서울 열린 데이터 광장 OpenAPI (서울 음식점 정보)
var xhr = new XMLHttpRequest();
var url = 'http://openapi.seoul.go.kr:8088/4d4474467a77746736306d745a6855/xml/LOCALDATA_072404/1/5'; /* URL */



xhr.open('GET', url);
xhr.onreadystatechange = function () {
    if (this.readyState == xhr.DONE) {  // <== 정상적으로 준비되었을때
        if (xhr.status == 200 || xhr.status == 201) { // <== 호출 상태가 정상적일때

            var xmlobj = xhr.responseXML;
            var restaurantNamelist = xmlobj.getElementsByTagName("BPLCNM");  //가게명 태그
            var addressList = xmlobj.getElementsByTagName("SITEWHLADDR"); // 주소 태그
            var detailaddressList = xmlobj.getElementsByTagName("RDNWHLADDR"); //상세주소 태그
            var catagoryList = xmlobj.getElementsByTagName("UPTAENM");  //

            for(i =0; i<restaurantNamelist.length; i++) {
                document.write(restaurantNamelist[i].textContent);
            }
        }
    }
}



/*

var heading = document.querySelector("#heading")

heading.onclick = function (){
    heading.style.color='red'
}



function inntext() {
    var now = new Date()
    document.getElementById("current").innerText = now;

}

var btn = document.querySelector("button")

btn.onclick = function () {
    var now = new Date()
    document.getElementById("current").innerText = now
}

var double = document.querySelector("#double");

function fun01() {
    var now = new Date()
    document.getElementById("current2").innerText = now;
}

double.addEventListener("dblclick", fun01);

var kakao = document.getElementById("kakao");

kakao.addEventListener("mouseover", function () {
    kakao.src = "b747.JPG";
})

kakao.addEventListener("mouseout", function() {
    kakao.src = "카카오프렌즈.JPG";
})

/*
var prom = prompt("입력 : ")

if(prom != null) {
    if(prom % 3 === 0) {
        alert("3의 배수")
    }
    else if(prom % 2 === 0) {
        alert("2의 배수")
    }
}

*/

/*
var con = confirm("변경 ? ");

if(con == true) {
    heading.style.color = 'pink';
}

document.write("<h3>" + con + "</h3>")
document.write(typeof con)

var a  = new Array(5);

for (var i =0; i<a.length; i++) {
    var result = Math.floor(Math.random() * 10) + 1
    a[i] = result;
    document.write("a [ " + i + "] : " + a[i] +" \n")

}

 */

