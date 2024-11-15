var location = document.getElementById("location");
var reset = document.getElementById("reset");
var search = document.getElementById("search");
var marker = null;

var map = new naver.maps.Map('map' , {
    center : new naver.maps.LatLng(37.5665, 126.9780),
    zoom : 11
})

search.addEventListener("click", function() {
    var keyword = loc.value;

    naver.maps.Service.geocode({query : keyword}, function(status, response) {
        if(status != naver.maps.Service.Status.OK) {
            alert("검색 결과 없습니다.")
            return;
        }

        var result = response.v2.addresses[0];
        var loc2 = new naver.maps.LatLng(result.y, result.x);

        //마커

        if(!marker) {
            marker = new naver.maps.Marker({
                map : map
            });
        }

        marker.setPosition(loc);  //해당 위치에 마커 표시

        map.setCenter(loc2);  //지도 중심을 마커가 위치한 곳으로
        map.setZoom(15);
    });
})


reset.addEventListener("click", function() {
    location.value = "";

    if(marker) {
        marker.setMap(null);  //지도에서 마커 지우기
        marker = null;
    }

})

