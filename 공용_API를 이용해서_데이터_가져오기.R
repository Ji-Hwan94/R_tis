
# 노선 번호에 대한 노선 ID 확인  
install.packages("XML")
install.packages("sf")
install.packages("mapview")
library(XML)
library(dplyr)
library(sf)
library(mapview)


# 버스 번호를 저장장
busRtNm <- "402"
# 입력 받은 키를 작성
API_key <- "OckdUErbAGthsbx6VYITeQ9xzEpUow%2F25CZWigZoPo3JVEW%2FU%2Bpd%2B2ZiN06BuDRn3Zjfh21AHXvgg8cWnuP9Hw%3D%3D"

# 서버의 주소, paste는 문자열과 문자열을 연결해주는 함수 / '&strSrch=' 버스의 번호가 들어간다
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", busRtNm,sep="")
# 데이터를 읽어온다
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.252
# xml을 데이터프레임으로 바꾸어 준다 / text나 테그를 node라고 한다. getNodeSet은 node를 가져오는 함수이다.
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
head(df)

# 버스 번호가 402번인 버스를 찾는다.
df_busRoute <- subset(df, busRouteNm==busRtNm)
df_busRoute

df_busRoute$busRouteId

# p.253
# 노선 ID에 대한 버스 실시간 위치 정보 확인 / 버스 위치 확인
API_key <- "n%2FmqCqtciHJ0vA0JLyAWcreYtGbbIWuG%2F8ugHLtjthFy9LlUtvWcsQVadShPO6yqVEm79c2HUB0Z8lnHrjm74g%3D%3D"
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", 
            "100100063", sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.254
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
df

# gps X, Y를 구한다
gpsX <- as.numeric(as.character(df$gpsX))
gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=gpsX, lat=gpsY)
gc

# 위도 경도 값과 지도를 매칭한다. / 지도의 유형을 어떻게 할 건지
gc <- st_as_sf(gc, 
               coords = c("lon", "lat"),
               crs = 4326)

mapview(gc, hide =TRUE)







######################
