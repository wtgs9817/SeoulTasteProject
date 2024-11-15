<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>웹페이지 제목</title>

	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=kyvybyx7ee&submodules=geocoder,places"></script>
</head>
<body>
	<div>
		<input id="loc" placeholder="지역, 음식 또는 식당명 입력" value="서울">
		<button id="reset"> reset </button>
		<button id="search" type="button" aria-label="검색하기 버튼"> 검색 </button>
	</div>
	<br>
	<br>


	<div id="map" style="width:100%;height:600px;"></div>
	<script>

		var loc = document.getElementById("loc");
		var reset = document.getElementById("reset");
		var search = document.getElementById("search");
		var marker = null;


		//가게 정보 가져오기
		//서울 열린 데이터 광장 OpenAPI (서울 음식점 정보)
		var xhr = new XMLHttpRequest();
		//XMLHttpRequest 는 비동기적으로 서버와 브라우저 간 데이터를 주고받는 API로, 페이지 새로고침 없이 서버와의 통신을
		//처리할 수 있음.

		//한번에 1000개의 데이터까지만 가지고 올 수 있어서 추후에 코드 수정이 필요할 듯 전체 데이터를 가져와야해서
		var url = 'http://openapi.seoul.go.kr:8088/4d4474467a77746736306d745a6855/xml/LOCALDATA_072404/1/1000/'; /* URL */



		var map = new naver.maps.Map('map' , {
			center : new naver.maps.LatLng(37.5665, 126.9780),
			zoom : 11
		})


		search.addEventListener("click", function() {
			//console.log(window.naver ? "네이버 API 로드 성공" : "네이버 API 로드 실패");

			var keyword = loc.value;
			//console.log(keyword);

			//가게명으로 검색했을 때
			xhr.open('GET', url);  // open : 서버에 요청을 보내기 전에 호출되는 메소드
			//문법: open("HTTP 전송 방식", "URL 경로", 비동기 여부)

			//XMLHttpRequest.onreadystatechange 는 readyState 속성의 상태가 변할 때 호출될 함수 설정하는 속성
			    /*readyState 는 요청의 상태를 나타내는 값
				0 (UNSENT): open() 메소드가 호출되기 전 초기 상태
				1 (OPENED): open() 메소드가 호출되어 서버와 연결이 설정된 상태
				2 (HEADERS_RECEIVED): send() 메소드가 호출되어 서버가 요청을 수신한 상태
				3 (LOADING): 서버에서 응답 데이터를 로딩 중인 상태
				4 (DONE): 요청이 완료되고 서버 응답이 전부 도착한 상태
			    */
			xhr.onreadystatechange = function () {
				if (this.readyState == xhr.DONE) {  // <== 정상적으로 준비되었을때
					if(xhr.status == 200||xhr.status == 201) { // <== 호출 상태가 정상적일때
						//status : 서버의 응답 상태코드
						// 200 -> 요청성공 / 403 -> 접근 거부 오류 / 404 -> 파일 또는 페이지가 없음 / 500 -> 서버 내부 오류
						var xmlobj = xhr.responseXML;
						var restaurantNamelist = xmlobj.getElementsByTagName("BPLCNM");  //가게명 태그
						var addressList = xmlobj.getElementsByTagName("SITEWHLADDR"); // 주소 태그
						var detailaddressList = xmlobj.getElementsByTagName("RDNWHLADDR"); //상세주소 태그
						var catagoryList = xmlobj.getElementsByTagName("UPTAENM");  // 종류

						var restaurantName = "";
						var address = "";
						var detailaddress = "";
						var catagory = "";

						for (var i = 0; i < restaurantNamelist.length; i++) {
							if (restaurantNamelist[i].textContent.includes(keyword)) {
								restaurantName = restaurantNamelist[i].textContent;

								// console.log(restaurantName);

								address = addressList[i].textContent;
								detailaddress = detailaddressList[i].textContent;
								catagory = catagoryList[i].textContent;
							}
						}
						//데이터 확인
						//console.log(restaurantName);
						//console.log(address);
						//console.log(detailaddress);
						//console.log(catagory);

						if(restaurantName !== "") {
							keyword = address;
						}

						//geocode 는 주소 -> 좌표로 변환
						naver.maps.Service.geocode({ query : keyword}, function(status, response) {
							//console.log("status : ", status);
							//console.log("response : ",response);

							//주소만 검색했을 때도 식당만 나오게 해야할듯

							if(status === naver.maps.Service.Status.OK && response.v2.addresses.length > 0) {

								//첫 번째 결과의 주소 좌표 추출
								var result = response.v2.addresses[0];

								if (result) {
									var position = new naver.maps.LatLng(result.y, result.x);

									//이전 마커가 있을 경우 삭제
									if (marker) {
										marker.setMap(null);
										//마커 없애기
									}

									//지도에 표시된 특정 위치에 대한 정보를 팝업 형태로 보여줌
									var infowindow = new naver.maps.InfoWindow({
										//content 안에는 html 문자열로 정의함.(이미지,텍스트,링크 등 포함가능)
										content : '<div style="padding:10px;">' +
												'<h4>' + restaurantName + '</h4>' +
												'<p> 주소 : ' + detailaddress + '</p>'+
												'<p> 종류 : ' + catagory + '</p>' +
									'</div>'
									})

									//새 마커 지도에 추가
									marker = new naver.maps.Marker({
										position: position,
										map: map
									})

									//
									infowindow.open(map, marker);

									//지도 중심 이동
									map.setCenter(position);
									map.setZoom(15);
								}
							}

							else {
								alert("해당 가게는 존재하지 않습니다.")
								return;
							}
						})


					}
				}
			};
			xhr.send(''); //send : 요청을 서버로 전송하는 메소드




		})

		//입력창 비우기
		reset.addEventListener("click", function() {
			loc.value = "";

			if (marker) {
				marker.setMap(null);  //지도에서 마커 지우기
				marker = null;
			}
		})

	</script>



</body>
</html>