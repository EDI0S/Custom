# 데이터 준비 - 파일 받아서 불필요한 변수(컬럼) 제거, NA값 처리, 
# 그래프(Boxplot, Hist, Bar, density) 그려서 이상치,등 변수 관계 확인(이상치 처리), 
# featuring(새로운 변수 생성 등) - 전처리(앞의 자료 데이터 프레임화) - 
# 모델링(lm, glm, confusionMatrix, 정분류율/민감도/특이도 - 학습/훈련 rmse/mse/mspe/mae)
# 변수 선택법 - 전진선택법(glm(...direction = "forward")), 후진소거법("backward"), 
# 선형회귀 분석 모델 - 오차(error)를 바라보는 관점 - SST, SSR, SSE -> R-squared(결정계수)
# Adjust R-squared(수정된 결정계수) / MSE(Mean squared error), RMSE(Root mean squared error)
# 
# Business Understanding: 
# Data Understanding: 
# Data Preparation: 탐색적 분석 & 준비(전처리), 데이터 정제(NA & 이상치 처리, 
#                   Featuring), 불필요 데이터 제거, 추가 변수 생성,등
# Modeling: 데이터 셋 분리(학습용, 공부용), 변수 선택(알고리즘 선택), 
# Evaluation: 
# Deployment: 
#
#
# R tidyverse 패키지를 사용한 데이터 가공
#
# 필수 패키지 설치 및 읽기
#################################################################################################
### ###
###
### Description : This is for the special course on "Big Data" of SNU-SRI. ###
### This concentrates on "Data Wrangling" with R package "dplyr" and "tidyr". ###
### ###
### Reference : Jaimie (Jaimyoung) Kwon's github (and lecture note) ###
### ###
#################################################################################################
# 필수 패키지 설치
#if (!require(ggplot2)) { install.packages('ggplot2') ; library(ggplot2)}
#if (!require(dplyr)) { install.packages('dplyr') ; library(dplyr)}
#if (!require(tidyr)) { install.packages('tidyverse') ; library(tidyr)}
#if (!require(data.table)) { install.packages('tidyverse') ; library(data.table)}

#if (!require(lubridate)) { install.packages('lubridate') ; library(lubridate)}
#if (!require(Lahman)) { install.packages('Lahman') ; library(Lahman)}

#if (!require(nycflights13)) { install.packages('nycflights13') ; library(nycflights13)}
#if (!require(babynames)) { install.packages('babynames') ; library(babynames)}


install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")
install.packages("data.table")
# 학습을 위해 필요한 패키지 설치
install.packages("lubridate")
install.packages("Lahman")
# 데이터 설치
install.packages("nycflights13")
install.packages("babynames")
# 패키지 로딩
library(ggplot2)
library(dplyr)
library(tidyr)
library(data.table)


#################################################################################################
### ###
### Description : This is for the special course on "Big Data" of SNU-SRI. ###
### This concentrates on "Data Wrangling" with R package "dplyr" and "tidyr". ###
### ###
### Reference : Jaimie (Jaimyoung) Kwon's github (and lecture note) ###
### ###
#################################################################################################
#################################################################################################
########## dplyr ##########
#################################################################################################
library(nycflights13)
help(package="nycflights13")
# 데이터를 transpose 취해서 보여준다. 즉, 각 설명변수(열)들이 어떤 값들이 나왔는지 순서대로 보여주는 것이다.
# 이것을 이용하면 데이터프레임 안에 있는 모든 열들을 콘솔에서 편하게 볼 수 있다.
# str 과 다른 점은 콘솔 상에서 가능한 최대한의 값들을 보여준다.
glimpse(flights)
str(flights)

# 연습문제 12/43
glimpse(airlines)
glimpse(airports)
glimpse(planes)
glimpse(weather)
flights
print(flights)
class(flights)
# x <- data.frame(c(1,1))
# class(x)
# class(tbl_df(x))

################################# 고급 연습문제(13/43) #################################
head(as.data.frame(flights))

##################################### 1. filter() #####################################
# 설명 : 주어진 조건을 만족하는 행들을 추려낸다.
# 기초적인 사용법 : filter(주어진 자료(데이터프레임), 필터링하고자 하는 조건)
# 1월 1일에 출발한 항공편 자료를 찾는 명령
filter(flights, month == 1, day == 1)
filter(flights, month == 1 & day == 1)

# 1월과 2월에 출발한 항공편 자료를 찾는 명령
filter(flights, month == 1 | month == 2)

### slice() : 행을 행 번호로 추려낸다.
# flights[1:10,] ==
slice(flights, 1:10)

##################################### 2. arrange() #####################################
# 설명 : 행을 변수들의 오름차순으로 정렬한다. 즉 지정한 열을 기준으로 가장 작은 값에서 시작하여
# 가장 큰 값으로 끝나는 순서대로 데이터를 정렬한다.
# 기초적인 사용법 : arrange(주어진 자료(데이터프레임), 오름차순으로 정렬하고자 하는 열(기준))
# flights 자료를 year, month, day 순으로 정렬하는 명령
# flights[order(flights$year, flights$month, flights$day),] ==
arrange(flights, year, month, day)

### desc() : 내림차순으로 정렬하도록 바꾸는 함수이다.
# arr_delay가 가장 큰 것부터 정렬하는 명령
arrange(flights, desc(arr_delay))

##################################### 3. select() #####################################
# 설명 : 필요한 열을 선택한다. 열 이름을 써주는 연산이 가장 흔히 쓰인다.
# 기초적인 사용법 : select(주어진 자료(데이터프레임), 추출하고자 하는 열의 이름들)
# year, month, day라는 이름을 가진 열을 추출하는 명령
select(flights, year, month, day)

# 열의 범위를 지정하여 열을 추출하는 명령
select(flights, year:arr_time)

# year, month, day라는 이름을 가진 열을 제외하고 나머지를 추출하는 명령
select(flights, -year, -month, -day)

# 열의 범위를 지정하여 그 열들을 제외한 나머지 열들을 추출하는 명령
select(flights, -(year:arr_time))

### + starts_with() : 정해진 문자열로 시작하는 열들을 모두 지정할 때 사용
# arr로 시작하는 이름을 가진 열들을 모두 제외하는 명령
select(flights, -starts_with("arr"))

### + ends_with() : 정해진 문자열로 끝나는 열들을 모두 지정할 때 사용
# delay로 시작하는 이름을 가진 열들을 모두 추출하는 명령
select(flights, ends_with("delay"))

### + matches() : 정해진 형식으로 구성된 이름을 가진 열들을 모두 지정할 때 사용
# 무엇_무엇 꼴의 이름을 가진 열들을 모두 추출하는 명령
select(flights, matches("._."))
select(flights, matches(".r_t."))

### + contains() : 정해진 문자열이 포함된 이름을 가진 열들을 모두 지정할 때 사용
# _이 들어가는 이름을 가진 열들을 모두 추출하는 명령
select(flights, contains("_"))
select(flights, contains("_."))

## ?select 로 추가적으로 확인할 수 있다.
### rename() : 열의 이름을 바꿔준다.
rename(flights, tail_num = tailnum)

##################################### 4. mutate() #####################################
# 설명 : 기존의 열(들)의 값을 이용해 새로운 열을 추가한다.
# 함수에서 생성한 열을 바로 사용할 수 있다.
# 기초적인 사용법 : mutate(주어진 자료(데이터프레임), 생성하고자 하는 열 계산)
mutate(flights, gain = arr_delay - dep_delay, 
       gain_per_hour = gain / (air_time / 60), 
       speed = distance / air_time * 60)

# transform() 함수와 비교하면?
mutate(flights, gain = arr_delay - dep_delay, 
       gain_per_hour = gain / (air_time / 60))
transform(flights, gain = arr_delay - dep_delay, 
          gain_per_hour = gain / (air_time / 60)) #error

##################################### 5. summarize() #####################################
# 설명 : 주어진 자료(데이터프레임)을 한 줄(행)으로 요약한다. 즉 요약통계량을 계산한다.
# summarise() 함수도 같은 역할을 한다.
# 기초적인 사용법 : summarize(주어진 자료(데이터프레임), 원하는 요약통계량)
# dep_delay의 평균을 계산하는 명령
summarize(flights, delay = mean(dep_delay, na.rm = TRUE))

# 요약통계함수를 사용한다. 요약통계함수는 벡터값을 입력으로 받아 하나의 숫자를 출력한다.
# 기본 R 패키지의 요약통계함수는 min(), max(), mean(), sum(), sd(), median(), IQR() 등이 있다.
# dplyr 패키지에서 제공하는 요약통계함수는 n(), n_distinct(), first(), last(), nth() 이 있다.
# group_by() 함수와 함께 이용하면 매우 편리하다.
############################## 6. sample_n(), sample_frac() ##############################
# 설명 : sample_n() 함수는 정해진 숫자의 열을 랜덤샘플한다.
# sample_frac() 함수는 정해진 비율의 열을 랜덤샘플한다.
# 기초적인 사용법 : sample_n(주어진 자료(데이터프레임), 추출하고자 하는 열의 개수)
# sample_frac(주어진 자료(데이터프레임),
# 추출하고자 하는 열의 개수의 전체 열의 개수에 대한 비율)
# 10줄의 열을 랜덤샘플하는 명령
sample_n(flights, 10)

# 1%의 열을 랜덤샘플하는 명령
sample_frac(flights, 0.01)

# 비복원추출이 default이지만 replace 옵션으로 복원추출할 수도 있다.
# weight 옵션으로 가중치를 정할 수 있다.
# 재현가능한 연구를 위해서는 set.seed해줄 수 있다.
##################################### 7. distinct() #####################################
# 설명 : 주어진 자료에서 고유한 행을 찾아낸다.
# 기초적인 사용법 : distinct(주어진 자료(데이터프레임) 혹은 자료에서 선택한 열)
# 서로 다른 기체번호를 찾는 명령
distinct(select(flights, tailnum))

# 서로 다른 노선을 찾는 명령
distinct(select(flights, origin, dest))

############################# Language of data manipulation #############################
# (1) 행정렬 arrange()
# (2) 행선택 filter()
# (3) 열선택 select()
# (4) 새로운 변수 계산 mutate()
# (5) 요약통계량 계산 summarise()
########################### group_by() 함수를 이용한 그룹연산 ###########################
# 설명 : 데이터셋을 그룹으로 나눈다.
# 기초적인 사용법 : group_by(주어진 자료(데이터프레임), 그룹으로 나누고자 하는 기준이 되는 열(들))
flights
groups(flights)
(by_tailnum = group_by(flights, tailnum))
groups(by_tailnum)

### 연동사용법
## select() 는 그룹변수를 항상 포함한다.
select(by_tailnum, year, month, day)

## arrange() 는 그룹변수로 우선 정렬한다.
arrange(by_tailnum, day)
arrange(flights, day)

## mutate() 와 filter()는 윈도우 함수(window function)과 더불어 사용한다.
# vignette("window-functions")
# 각 비행기 별로 가장 큰 air_time을 가진 항공편을 추출하는 명령
filter(by_tailnum, min_rank(desc(air_time)) == 1)

# 각 비행기 별로 air_time의 크기를 작은 순서대로 순위화하는 명령
mutate(by_tailnum, rank = min_rank(air_time))

## sample_n() 과 sample_frac() 은 그룹별로 랜덤샘플한다.
sample_n(by_tailnum, 1)

## slice() 는 각 그룹별로 행을 추출한다.
#slice는 그룹별 원소의 개수보다 많이 숫자를 설정하면 개수만큼 나온다.
slice(by_tailnum, 5)

# summarise() 는 각 그룹별로 요약통계량을 계산한다.
# 아래 참고
#(by_tailnum = group_by(flights, tailnum))
delay = summarise(by_tailnum,
                  count = n(),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE))
delay = filter(delay, count > 20, dist < 2000)
delay

### exercise 26/43
groups(by_tailnum)
by_tailnum = ungroup(by_tailnum)
groups(by_tailnum)

### exercise 26/43
rowwise(by_tailnum)
delay = summarise(rowwise(by_tailnum),
                  count = n(),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE))
delay = filter(delay, dist < 2000)
delay

########################### ggplot2 패키지를 이용한 시각화 ###########################
by_tailnum = group_by(flights, tailnum)
delay = summarise(by_tailnum,
                  count = n(),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE))
delay = filter(delay, count > 20, dist < 2000)
delay
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()
sum(select(delay, count)>=1000)
sum(is.na(select(delay, delay)))

########################### %>% 연산자와 체이닝(chaining) ###########################
# The downside of the functional nature of dplyr is that when you combine multiple data manipulation
# operations, you have to read from the inside out and the arguments may be very distant to the function

# call. These functions providing an alternative way of calling dplyr (and other data manipulation)
# functions that you read can from left to right. (dyplyr 패키지 설명의 chain 부분)
# 임시변수 방법
a1 = group_by(flights, year, month, day)
a2 = select(a1, arr_delay, dep_delay)
a3 = summarise(a2,
               arr = mean(arr_delay, na.rm = TRUE),
               dep = mean(dep_delay, na.rm = TRUE))
(a4 = filter(a3, arr > 30 | dep > 30))

# 중첩 방법
filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

# 두 방법 모두 가독성이 떨어진다.
### %>% 연산자
# simple1
head(iris)
iris %>% head

# simple2
head(iris, 10)
iris %>% head(10)

# 위의 임시변수 방법과 중첩 방법과 결과가 같다.
# 또한 가독성이 좋다.
flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)

################################## 연습문제(31/43) ##################################
# 날짜 형식을 다루는 패키지
library(lubridate)

# C 언어 중에서 지역화를 지정하는 기능.
# 구체적으로는 setlocale 함수나 localconv 함수로 통화(通貨)의 표현,
# 10진수 표현(소수 점이 점인가 콤마인가 등), 일시(日時) 표현의 차이 등 각국 특유의 표현을 지정한다.
# [네이버 지식백과] 로컬 [locale] (컴퓨터인터넷IT용어대사전, 2011. 1. 20., 일진사)
Sys.setlocale("LC_TIME", "usa")
(per_day = flights %>%
    group_by(year, month, day) %>%
    summarise(flights = n(),
              distance = mean(distance),
              arr = mean(arr_delay, na.rm = TRUE),
              dep = mean(dep_delay, na.rm = TRUE)
    ) %>%
    mutate(dt_str = sprintf("%04d-%02d-%02d", year, month, day),
           dt = parse_date_time(dt_str, "ymd",tz = "US/Eastern"),
           dow = wday(dt, label=TRUE)
    )
)

# 각각의 도착지에 대해 비행기 개수
flights %>% group_by(tailnum, dest) %>% distinct() %>% 
  group_by(dest) %>% summarise(count = n())

# 각각의 도착지에 대해 다른 항공편 편수
flights %>% group_by(dest) %>% summarise(count = n())

# 각 날짜별 비행기 편수
select(per_day, year:flights)
flights %>% group_by(year,month, day) %>% summarise(count = n())

# 각 요일별 비행기 편수
ungroup(per_day) %>% group_by(dow) %>% summarise(count = sum(flights))
ungroup(per_day) %>% group_by(dow) %>% summarise(count = mean(flights))
per_day %>% ggplot(aes(dt, flights)) + geom_line() + geom_point() + geom_smooth()
  
per_day %>% ggplot(aes(dow, flights)) +
  geom_boxplot()
per_day %>% ggplot(aes(dt, dep)) +
  geom_line() + geom_point() + geom_smooth()
per_day %>% ggplot(aes(dow, dep)) +
  geom_boxplot()
per_day %>% ggplot(aes(dt, distance)) +
  geom_line() + geom_point() + geom_smooth()
per_day %>% ggplot(aes(dow, distance)) +
  geom_boxplot()

########################## join 함수를 이용한 테이블 결합 ##########################
(df1 <- data_frame(x = c(1, 2), y = 2:1))
(df2 <- data_frame(x = c(1, 3), a = 10, b = "a"))

# inner_join() 함수는 x와 y에 모두 매칭되는 행만 포함한다. 교집합이다.
df1 %>% inner_join(df2)

# left_join() 함수는 x 의 모든 행을 포함한다. 매칭되지 않은 y 테이블 변수들을 NA가 된다. 차집합이다.
df1 %>% left_join(df2)

# right_join() 함수는 y 테이블의 모든 행을 포함한다.
# left_join(y,x) 의 경우와 행의 순서만 다를 뿐 동일한 결과를 준다.
df1 %>% right_join(df2)

# full_join() 함수는 x와 y의 모든 행을 포함한다. 합집합이다.
df1 %>% full_join(df2)

################################## 연습문제(35/43) ##################################
(flights2 = flights %>% select(year:day, hour, origin, dest, tailnum, carrier))
airlines
flights2 %>% left_join(airlines)
# flights2 %>% left_join(airlines, by="carrier")
# rm(list = ls())

################################# 연습문제(37/43)-1 #################################
ds <- tbl_df(mtcars)
ds
as.data.frame(ds)
if (require("Lahman") && packageVersion("Lahman") >= "3.0.1") {
  batting <- tbl_df(Batting)
  dim(batting)
  colnames(batting)
  head(batting)
  # Data manipulation verbs ---------------------------------------------------
  filter(batting, yearID > 2005, G > 130)
  select(batting, playerID:lgID)
  arrange(batting, playerID, desc(yearID))
  summarise(batting, G = mean(G), n = n())
  mutate(batting, rbi2 = if(is.null(AB)) 1.0 * R / AB else 0)
  # Group by operations -------------------------------------------------------
  # To perform operations by group, create a grouped object with group_by
  players <- group_by(batting, playerID)
  head(group_size(players), 100)
  summarise(players, mean_g = mean(G), best_ab = max(AB))
  best_year <- filter(players, AB == max(AB) | G == max(G))
  progress <- mutate(players, cyear = yearID - min(yearID) + 1,
                     rank(desc(AB)), cumsum(AB))
  # When you group by multiple level, each summarise peels off one level
  per_year <- group_by(batting, playerID, yearID)
  stints <- summarise(per_year, stints = max(stint))
  filter(stints, stints > 3)
  summarise(stints, max(stints))
  mutate(stints, cumsum(stints))
  # Joins ---------------------------------------------------------------------
  player_info <- select(tbl_df(Master), playerID, birthYear)
  hof <- select(filter(tbl_df(HallOfFame), inducted == "Y"), 
                playerID, votedBy, category)
  # Match players and their hall of fame data
  inner_join(player_info, hof)
  # Keep all players, match hof data where available
  left_join(player_info, hof)
  # Find only players in hof
  semi_join(player_info, hof)
  # Find players not in hof
  anti_join(player_info, hof)
}
# rm(list = ls())

################################# 연습문제(37/43)-2 #################################
library(babynames)
babynames
class(babynames)
babynames %>% group_by(year) %>% filter(min_rank(desc(n)) == 1)
babynames %>% group_by(year) %>% filter(min_rank(desc(n)) <= 10) %>% 
  summarise(rate = sum(prop))
# rm(list = ls())

################################# 연습문제(37/43)-3 #################################
# 주소로 지정할 수도 있지만...
batting = read.csv(file.choose())
master = read.csv(file.choose())
head(batting)
head(master)
batting = tbl_df(batting)
master = tbl_df(master)
class(batting)
class(master)

# 각 연도별 타자들의 타율을 계산하라. ( AVG(타율) = H(안타) / AB(타수) )
mutate(batting, AVG = H / AB) %>% select(playerID:lgID, AVG)
full.batting = mutate(batting, AVG = H / AB)

# 각 연도별로 선수들의 타율의 분포를 시각화하라.
### plot
full.batting %>% mutate(year = factor(yearID)) %>%
  group_by(year) %>%
  ggplot(aes(year, AVG)) + geom_point() + geom_smooth(aes(group=1))

# 자료를 선별하여 분포를 그린 것이므로 참고만 하자.
full.batting %>% mutate(year = factor(yearID)) %>%
  filter(AB >= 100, yearID >= 1985) %>%
  group_by(year) %>%
  ggplot(aes(year, AVG)) + geom_point() + geom_smooth(aes(group=1))
full.batting %>% filter(AB >= 100) %>%
  group_by(yearID) %>%
  summarise( n = n()) %>%
  ggplot(aes(yearID, n))+ geom_point()

### box-plot
full.batting %>% mutate(year = factor(yearID)) %>%
  group_by(year) %>%
  ggplot(aes(year, AVG)) + geom_boxplot()

# 자료를 선별하여 분포를 그린 것이므로 참고만 하자.
full.batting %>% mutate(year = factor(yearID)) %>%
  filter(AB >= 100, yearID >= 1985) %>%
  group_by(year) %>%
  ggplot(aes(year, AVG)) + geom_boxplot()

# 1980년 이후 최고타율을 기록한 선수들의 리스트를 구하라.
(AVGtable = full.batting %>% select(playerID:lgID, AVG))

# min_rank() 함수의 성질
cw <- c(1,2,3,4,NA, 2913)
min_rank(cw)
temp = AVGtable %>% group_by(playerID) %>% filter(min_rank(desc(AVG)) == 1 & yearID >= 1980)

AVGtable %>% filter(playerID == "blackti01")

# 결과 테이블을 Master 테이블과 join 해서 선수의 이름을 표시하라.
(name = master %>% select(playerID, nameFirst, nameLast, nameGiven, retroID, bbrefID))

# select() 순서를 바꾸기 위해 사용해보자.
list = temp %>% left_join(name, by="playerID") %>% select(playerID, nameFirst:bbrefID, yearID:AVG)
list

#################################################################################################
########## tidyr ##########
#################################################################################################
# Key concepts : Long format <-> Wide format, Pivot table
# Core contents : spread() and gather() function
# library(tidyr)
##################################### 1. spread() #####################################
# 설명 : Long format -> Wide format
# 기초적인 사용법 : spread(주어진 자료(데이터프레임), 피벗이 되는 열, 대상이 되는 열)
digest = flights %>% group_by(carrier, origin) %>%
  summarise(air_time_mean = mean(air_time, na.rm=TRUE))
as.data.frame(digest)

# 피벗 테이블
spread(digest, origin, air_time_mean)
flights %>% group_by(carrier, origin) %>%
  summarise(air_time_mean = mean(air_time, na.rm=TRUE)) %>%
  spread(origin, air_time_mean)

# NA를 0으로 채우기
spread(digest, origin, air_time_mean, fill = 0)

##################################### 2. gather() #####################################
# 설명 : Wide format -> Long format
# 기초적인 사용법 : gather(주어진 자료(데이터프레임), 변수명을 포함한 열, 대상이 되는 열,
# long format 으로 전환할 열)
series = flights %>% group_by(month, day) %>%
  summarise(air_time_mean = mean(air_time, na.rm=TRUE), 
            dep_delay_mean = mean(dep_delay, na.rm=TRUE))
series
series %>% gather(indicators, value, air_time_mean, dep_delay_mean)
series %>% gather(indicators, value, -month, -day)


# 데이터 시각화 (Data Visualization)

# Install Packages
install.packages('ggmap')
install.packages('ggplot2')
install.packages('tm')
install.packages('SnowballC')
install.packages('wordcloud')
install.packages('networkD3')
install.packages('curl')
install.packages('GGally')
install.packages('ggvis')
install.packages('shiny')
install.packages('plotly')
# 1차원 자료용 그래픽
# Data: 초미세먼지 자료
setwd("~/Desktop/개인/Big Data 시각화 (2016.02)")
pollution <- read.csv("avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
head(pollution)
## pm25 fips region longitude latitude
## 1 9.771185 01003 east -87.74826 30.59278
## 2 9.993817 01027 east -85.84286 33.26581
## 3 10.688618 01033 east -87.72596 34.73148
## 4 11.337424 01049 east -85.79892 34.45913
## 5 12.119764 01055 east -86.03212 34.01860
## 6 10.827805 01069 east -85.35039 31.18973
# Five Number Summary
summary(pollution$pm25)
## Min. 1st Qu. Median Mean 3rd Qu. Max.
## 3.383 8.549 10.050 9.836 11.360 18.440
# Boxplot
boxplot(pollution$pm25, col="blue")
boxplot(pollution$pm25, col="blue")
abline(h=12)
# Histogram
hist(pollution$pm25, col="green")
rug(pollution$pm25)
hist(pollution$pm25, col="green",breaks=100)
rug(pollution$pm25)
hist(pollution$pm25, col='green', breaks=c(2,5,8,10,14,18,20))
# Histogram with bar
hist(pollution$pm25, col="green")
abline(v=12,lwd=2)
abline(v=median(pollution$pm25), col="magenta", lwd=4)
abline(h=60, col="skyblue", lwd=4)
# Barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")
# n차원 자료용 그래픽
# Multiple Boxplot
boxplot(pm25 ~ region, data = pollution, col = "red") #formula in R; y~x1+x2+...
# Multiple Histograms
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1)) ### par(mfrow = c(1, 1)) or dev.off() ; 초기화
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")
# Scatterplot
with(pollution, plot(latitude, pm25)) ## plot(pm25 ~ latitude, data=pollution) 과 같은 표현!
abline(h=12,lwd=2,lty=2)
with(pollution, plot(latitude, pm25, col = region))
abline(h=12,lwd=2,lty=2)
# Multiple Scatterplots
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1)) ## margin : c(bottom, left, top, right)
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))
# R Plot System
# Base plotting system
# Data loading : airquality
library(datasets)
with(airquality, plot(Wind, Ozone))
# Base Plot with Annotation
with(airquality, plot(Wind, Ozone))
title(main="Ozone and Wind in New Yorm City") ## Add a title
# Base Plot with Regression Line
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
?points
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd=2)
abline(1,2, lwd=2) ### intercept(y절편), slope(기울기), thickness(두께)
# Multiple Base Plots
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with (airquality, {
  plot(Wind, Ozone, main = "Ozone and Wind")
  plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
  plot(Temp, Ozone, main = "Ozone and Temperature")
  mtext("Ozone and Weather in New York City", outer = TRUE) #main title;;; 통합 제목
}
)
# Lattice System in R
# Lattice system in R
library(lattice)
str(airquality)
airquality <- transform(airquality, Month = factor(Month)) # Convert 'Month' to a factor variable
levels(airquality$Month)
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
xyplot(Ozone ~ Wind, data = airquality)
# Lattice, Why?
set.seed(10)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y<-x+f-f*x+rnorm(100,sd=0.5)
f <- factor(f, labels = c("Group 1", "Group 2")) # group1(f=0; y=x+norm)=1:50, group2(f=1; y=1+norm)=51:100
xyplot(y ~ x)
xyplot(y ~ x | f, layout = c(2, 1))
# Lattice Panel Functions: Regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
  panel.xyplot(x, y, ...) # First call default panel function
  panel.lmline(x, y, col = 2) # Overlay a simple linear regression line
})
ftn = function(x, y, ...) {
  panel.xyplot(x, y, ...) # First call default panel function
  panel.lmline(x, y, col = 2) # Overlay a simple linear regression line
}
xyplot(y~x | f, panel=ftn)
# ggplot2
# Data ; MAACS
library("ggplot2")
load("maacs.Rda")
# basic ggplot ; using qplot (quick plot)
qplot(logpm25, NocturnalSympt, data = maacs, facets = . ~ bmicat,
      geom = c("point"))+stat_smooth(method="lm")
# Function ggplot
g<-ggplot(maacs, aes(logpm25, NocturnalSympt))
g
g+geom_point()
g+geom_point()+geom_smooth(method = "lm")
g+geom_point()+geom_smooth(method = "lm")+facet_grid(.~bmicat)
# Modifying Aesthetics
g + geom_point(color = "steelblue", size=4, alpha = 1/2)
g + geom_point(aes(color = bmicat), size=4, alpha=1/2)
# Modifying Labels
g + geom_point(aes(color = bmicat), size=4, alpha=1/2) +
  labs(title = "MAACS Cohort") + labs(x=expression("log"*PM[2.5]),y="Nocturnal Symptoms")
# Customizing the Smooth
g + geom_point(aes(color = bmicat), size=4, alpha=1/2) +
  geom_smooth(size = 4, linetype = 3, method = "lm", se = FALSE)

# Parallel Coordinate Plot
require(GGally)
head(mtcars)
ggparcoord(mtcars, columns = c(1,5:10))+geom_line()
# ggmap의 활용(지도 기반 시각화)
# ggmap 패키지
library(ggmap)
geocode("Seoul National University")
## lon lat
## 1 126.978 37.56654
korea <- c(left = 124, bottom = 32, right = 132, top = 43.5)
map <- get_stamenmap(korea, zoom = 5, maptype = "toner-lite")
ggmap(map)
# 휴스턴(Houston) 도심의 범죄 자료
# Basic plot on the map
# crime Data from Google Maps (included in ggmap packages)
str(crime)
## 'data.frame': 86314 obs. of 17 variables:
## $ time : POSIXt, format: "2010-01-01 15:00:00" "2010-01-01 15:00:00" ...
## $ date : chr "1/1/2010" "1/1/2010" "1/1/2010" "1/1/2010" ...
## $ hour : int 0 0 0 0 0 0 0 0 0 0 ...
## $ premise : chr "18A" "13R" "20R" "20R" ...
## $ offense : Factor w/ 7 levels "aggravated assault",..: 4 6 1 1 1 3 3 3 3 3 ...
## $ beat : chr "15E30" "13D10" "16E20" "2A30" ...
## $ block : chr "9600-9699" "4700-4799" "5000-5099" "1000-1099" ...
## $ street : chr "marlive" "telephone" "wickview" "ashland" ...
## $ type : chr "ln" "rd" "ln" "st" ...
## $ suffix : chr "-" "-" "-" "-" ...
## $ number : int 1 1 1 1 1 1 1 1 1 1 ...
## $ month : Ord.factor w/ 8 levels "january"<"february"<..: 1 1 1 1 1 1 1 1 1 1 ...
## $ day : Ord.factor w/ 7 levels "monday"<"tuesday"<..: 5 5 5 5 5 5 5 5 5 5 ...
## $ location: chr "apartment parking lot" "road / street / sidewalk" "residence / house" "residence / house" ...
## $ address : chr "9650 marlive ln" "4750 telephone rd" "5050 wickview ln" "1050 ashland st" ...
## $ lon : num -95.4 -95.3 -95.5 -95.4 -95.4 ...
## $ lat : num 29.7 29.7 29.6 29.8 29.7 ...
downtown<-subset(crime,
                 -95.39681 <= lon & lon <= -95.34188 &
                   29.73631 <= lat & lat <= 29.78400)
qmplot(lon, lat, data = downtown, maptype = "toner-background", color = I("red"))
Different Source / Type of map
배경에 표시될 지도의 출처(source option)와 종류(maptype option)를 다양하게 바꿈으로써,
상황에 어울리는 시각화가 가능하다.
source = “stamen”(기본설정)일 때, 가능한 maptype :
  “terrain”, “terrain-background”, “terrain-labels”, “terrain-lines”, “toner”,
“toner-2010”, “toner-2011”, “toner-background”, “toner-hybrid”, “toner-labels”,
“toner-lines”, “toner-lite”, “watercolor”
source = “google”일 때, 가능한 maptype :
  “terrain”, “satellite”, “roadmap”, and “hybrid”
qmplot(lon, lat, data = downtown, maptype = "watercolor", color = I("red"))
qmplot(lon, lat, data = downtown, maptype = "terrain-background", color = I("red"))
qmplot(lon, lat, data = downtown, maptype = "toner-hybrid", color = I("red"))
qmplot(lon, lat, data = downtown, source = "google", maptype = "terrain", color = I("red"))
qmplot(lon, lat, data = downtown, source = "google", maptype = "satellite", color = I("red"))
qmplot(lon, lat, data = downtown, source = "google", maptype = "hybrid", color = I("red"))
# 범죄율의 밀도(Density) 표현
robberies <- subset(downtown, offense == "robbery")
qmplot(lon, lat, data = robberies, geom = "blank", zoom = 15, maptype = "toner-background", darken = .7) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .3, color = NA)+
  scale_fill_gradient2("Robbery\nPropensity", low = "white", mid = "yellow", high = "red", midpoint = 700)
# 범죄율의 밀도(Density) 표현 - ggmap 함수를 이용한 표현
downtownmap<-get_stamenmap(c(left=-95.39681,bottom= 29.73631,right=-95.34188,top=29.78400),zoom = 15, maptype = "toner-background", darke
                           n= .7)
ggmap(downtownmap, darken=.7)+
  stat_density_2d(aes(fill = ..level..), geom = "polygon", alpha = .3, color = NA,data=robberies)+
  scale_fill_gradient2("Robbery\nPropensity", low = "white", mid = "yellow", high = "red", midpoint = 700)

# 범죄의 종류별 시각화
qmplot(lon, lat, data = downtown, maptype = "toner-background", color = offense) +
  facet_wrap(~ offense)
# Quiz1
# baseball.csv 파일에는 한국 프로야구 10개의 팀의 연고지(구장)의 위치의 경도(lon)와 위도(lat) 값과 2015년 프로야구 관중수(crowd)가 담겨있
다.
# 파일을 불러들여서(header = TRUE), 다음과 같이 지도에 각 구단의 연고지를 구단 별로 다른 색으로 위치를 표시해 보자.
# Hint :
# qmplot(lon, lat, data = downtown, maptype = “toner-background”, color = I(“red”)) 이 코드를 알맞게 변형해보세요.
# Quiz1 - Advanced
# Quiz의 결과는 다소 눈에 익지 않다. 가장 큰 이유중 하나는 대한민국 지도가 한꺼번에 보이지 않기 때문일 것이며, 10개의 팀을 모두 각기 다른
색으로 표현하는 것은 10개의 팀을 쉽게 구분할 수 있는 방법은 아닐 수 있다. 또한, baseball.csv 파일안에는 프로야구 관중수(crowd)라는 정보도
포함되어 있다.
# ggmap과 ggplot의 함수들을 함께 사용하면 다음과 같이 지도 영역의 자유로운 설정과 다양한 정보를 담을 수 있다.
# 텍스트 자료의 시각화
library(tm)
library(SnowballC)
library(wordcloud)
jeopQ <- read.csv('JEOPARDY_CSV.csv', stringsAsFactors = FALSE)
###Data Cleaning
jeopCorpus <- Corpus(VectorSource(jeopQ$Question))
jeopCorpus <- tm_map(jeopCorpus, removePunctuation) ## . , ? ! ()
jeopCorpus <- tm_map(jeopCorpus, removeWords, c("the", "this", "The", "This", stopwords('english'))) ## stopwords("en")
jeopCorpus <- tm_map(jeopCorpus, stemDocument) ## went -> go
jeopCorpus <- tm_map(jeopCorpus, PlainTextDocument)
wordcloud(jeopCorpus, max.words = 100, random.order = FALSE)
# 네트워크 자료의 시각화
# Basic Network Diagram
library(networkD3)
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
simpleNetwork(networkData)
# Sankey Diagram
library(networkD3)
URL <- paste0(
  "https://cdn.rawgit.com/christophergandrud/networkD3/",
  "master/JSONdata/energy.json")
Energy <- jsonlite::fromJSON(URL)
head(Energy$nodes)
## name
## 1 Agricultural 'waste'
## 2 Bio-conversion
## 3 Liquid
## 4 Losses
## 5 Solid
## 6 Gas
head(Energy$links)
## source target value
## 1 0 1 124.729
## 2 1 2 0.597
## 3 1 3 26.862
## 4 1 4 280.322
## 5 1 5 81.144
## 6 6 2 35.000
sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "TWh", fontSize = 12, nodeWidth = 30)

# Interactive Graphics
# ggvis system
# Data : mtcars data
# ggvis
# The %>% operator passes the left hand object to the first argument of the right hand expression
library(ggvis)
library(shiny)
p <- ggvis(mtcars, x = ~wt, y = ~mpg)
layer_points(p)

# ggvis using pipe function %>%
mtcars %>% ## DATA
  ggvis(x = ~wt, y = ~mpg) %>% ## model
  layer_points() ## plotting

# Different Layers
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_points()
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_lines()
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_bars()
mtcars %>%
  ggvis(x = ~wt, y = ~mpg) %>%
  layer_smooths()
# Interactive Controls
mtcars %>%
  ggvis(~wt, ~mpg,
        size := input_slider(10, 100), # := set a property to a value
        #size = ~wt, # = set a property w.r.t a variable with ~variable format
        opacity := input_slider(0, 1)
  ) %>%
  layer_points() ##Press Escape/Ctrl + C to stop.
mtcars %>%
  ggvis(~wt, ~mpg,
        size := input_numeric(30),
        opacity := input_radiobuttons(choices=c(0.2,0.4,0.6,0.8,1))
  ) %>%
  layer_points() ##Press Escape/Ctrl + C to stop.
# Examples
mtcars %>% ggvis(x=~wt) %>%
  layer_densities(
    adjust = input_slider(.1,2, value =1, step=.1, label="Bandwidth adjustment"),
    kernel = input_select(
      c("Gaussian"="gaussian","Epanechnikov"="epanechnikov","Rectangular"="rectangular", "Triangular"="triangular", "Biweight"="biweight"
        ,"Cosine"="cosine", "Optcosine"="optcosine"), label="Kernel"))
# Quiz2
# Basic R plot 을 통해 “pollution” 데이터의 scatter plot을 다음과 같이 그려볼 수 있었다.
with(pollution, plot(latitude, pm25))
# 이번에는 같은 그래프를 “ggvis”패키지와 pipe function “%>%”을 사용하여
# 다음과 같이 투명도(opacity), 크기(size), 색깔(fill)을 interactive하게 바꿀 수 있는 그래프를 그려보자.
# Hint
# 투명도(“opacity” 옵션) : input_slider 이용
# 크기(“size” 옵션) : input_numeric 이용
# 색깔(“fill” 옵션) : input_select 이용
# plotly system
# plotly
library(plotly)
set.seed(100)
d<-diamonds[sample(nrow(diamonds),1000), ]
plot_ly(d, x=carat, y=price, text=
          paste("Clarity: ", clarity),
        mode = "markers", color = carat, size= carat)
plot_ly(ggplot2::diamonds, y=price, color=cut, type="box")
plot_ly(z=volcano, type="surface")


# 회귀 분석 (Regression Analysis)
install.packages("ISLR")

# 선형회귀모형의 적합
Advertising = read.csv("~/Desktop/Advertising.csv", header = TRUE)
lm.fit = lm(Sales ~ TV, data = Advertising)
summary(lm.fit)

##
## Call:
## lm(formula = Sales ~ TV, data = Advertising)
##
## Residuals:
## Min 1Q Median 3Q Max
## -8.3860 -1.9545 -0.1913 2.0671 7.2124
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 7.032594 0.457843 15.36 <2e-16 ***
## TV 0.047537 0.002691 17.67 <2e-16 ***
## ---
## Signif. codes: 0 *** 0.001 ** 0.01 * 0.05 . 0.1 1
##
## Residual standard error: 3.259 on 198 degrees of freedom
## Multiple R-squared: 0.6119,Adjusted R-squared: 0.6099
## F-statistic: 312.1 on 1 and 198 DF, p-value: < 2.2e-16
confint(lm.fit, level=0.95)
## 2.5 % 97.5 %
## (Intercept) 6.12971927 7.93546783
## TV 0.04223072 0.05284256
# 중회귀모형의 적합도
lm.fit = lm(Sales ~ TV + Radio + Newspaper, data = Advertising)
summary(lm.fit)
##
## Call:
## lm(formula = Sales ~ TV + Radio + Newspaper, data = Advertising)
##
## Residuals:
## Min 1Q Median 3Q Max
## -8.8277 -0.8908 0.2418 1.1893 2.8292
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 2.938889 0.311908 9.422 <2e-16 ***
## TV 0.045765 0.001395 32.809 <2e-16 ***
## Radio 0.188530 0.008611 21.893 <2e-16 ***
## Newspaper -0.001037 0.005871 -0.177 0.86
## ---
## Signif. codes: 0 *** 0.001 ** 0.01 * 0.05 . 0.1 1
##
## Residual standard error: 1.686 on 196 degrees of freedom
## Multiple R-squared: 0.8972,Adjusted R-squared: 0.8956
## F-statistic: 570.3 on 3 and 196 DF, p-value: < 2.2e-16
cor(Advertising)
## X TV Radio Newspaper Sales
## X 1.00000000 0.01771469 -0.11068044 -0.15494414 -0.05161625
## TV 0.01771469 1.00000000 0.05480866 0.05664787 0.78222442
## Radio -0.11068044 0.05480866 1.00000000 0.35410375 0.57622257
## Newspaper -0.15494414 0.05664787 0.35410375 1.00000000 0.22829903
## Sales -0.05161625 0.78222442 0.57622257 0.22829903 1.00000000
# 가변수 (Dummy variable)
Credit = read.csv("~/Desktop/Credit.csv", header = TRUE)
lm.fit = lm(Balance ~ Gender, data = Credit)
summary(lm.fit)
##
## Call:
## lm(formula = Balance ~ Gender, data = Credit)
##
## Residuals:
## Min 1Q Median 3Q Max
## -529.54 -455.35 -60.17 334.71 1489.20
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 509.80 33.13 15.389 <2e-16 ***
## GenderFemale 19.73 46.05 0.429 0.669
## ---
## Residual standard error: 460.2 on 398 degrees of freedom
## Multiple R-squared: 0.0004611,Adjusted R-squared: -0.00205
## F-statistic: 0.1836 on 1 and 398 DF, p-value: 0.6685
# 가변수를 포함한 회귀모형
lm.fit = lm(Balance~ Ethnicity, data=Credit)
summary(lm.fit)

##
## Call:
## lm(formula = Balance ~ Ethnicity, data = Credit)
##
## Residuals:
## Min 1Q Median 3Q Max
## -531.00 -457.08 -63.25 339.25 1480.50
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 531.00 46.32 11.464 <2e-16 ***
## EthnicityAsian -18.69 65.02 -0.287 0.774
## EthnicityCaucasian -12.50 56.68 -0.221 0.826
## ---
## Residual standard error: 460.9 on 397 degrees of freedom
## Multiple R-squared: 0.0002188,Adjusted R-squared: -0.004818
## F-statistic: 0.04344 on 2 and 397 DF, p-value: 0.9575
# 가법성 가정 완화 (교호작용)
lm.fit = lm(Sales ~ TV*Radio, data = Advertising)
summary(lm.fit)
##
## Call:
## lm(formula = Sales ~ TV * Radio, data = Advertising)
##
## Residuals:
## Min 1Q Median 3Q Max
## -6.3366 -0.4028 0.1831 0.5948 1.5246
##
## Coefficients:
## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 6.750e+00 2.479e-01 27.233 <2e-16 ***
## TV 1.910e-02 1.504e-03 12.699 <2e-16 ***
## Radio 2.886e-02 8.905e-03 3.241 0.0014 **
## TV:Radio 1.086e-03 5.242e-05 20.727 <2e-16 ***
## ---
## Residual standard error: 0.9435 on 196 degrees of freedom
## Multiple R-squared: 0.9678,Adjusted R-squared: 0.9673
## F-statistic: 1963 on 3 and 196 DF, p-value: < 2.2e-16
# 변수선택
library(ISLR)
names(Hitters)
## [1] "AtBat" "Hits" "HmRun" "Runs" "RBI"
## [6] "Walks" "Years" "CAtBat" "CHits" "CHmRun"
## [11] "CRuns" "CRBI" "CWalks" "League" "Division"
## [16] "PutOuts" "Assists" "Errors" "Salary" "NewLeague"
dim(Hitters)
## [1] 322 20
sum(is.na(Hitters$Salary))
## [1] 59
Hitters = na.omit(Hitters)
dim(Hitters)
## [1] 263 20
sum(is.na(Hitters))
## [1] 0
# RSS를 포함한 변수선택을 위한 통계량 변화
par(mfrow = c(2,2))
plot(reg.summary$rss, xlab = "Number of Variables", ylab = "RSS", type = "l")
plot(reg.summary$adjr2, xlab = "Number of Variables", ylab = "Adjusted RSq", type = "l")
which.max(reg.summary$adjr2)
## [1] 11
points(11, reg.summary$adjr2[11], col = "red", cex = 2, pch = 20)
plot(reg.summary$cp, xlab = "Number of Variables", ylab = "Cp", type = "l")
which.min(reg.summary$cp)
## [1] 10
points(10, reg.summary$cp[10], col = "red", cex = 2, pch = 20)
plot(reg.summary$bic, xlab = "Number of Variables", ylab = "BIC", type = "l")
which.min(reg.summary$bic)
## [1] 6
points(6, reg.summary$bic[6], col = "red", pch = 20)
# 능선회귀와 라쏘 (Ridge Regression and LASSO)
x = model.matrix(Salary ~ . , data = Hitters)[,-1]
y = Hitters$Salary
library(glmnet)
grid = 10^seq(10, -2, length=100)
ridge.mod = glmnet(x, y, alpha=0, lambda = grid)
dim(coef(ridge.mod))

## [1] 20 100
ridge.mod$lambda[50]

## [1] 11497.57
coef(ridge.mod)[,50]

## (Intercept) AtBat Hits HmRun Runs
## 407.356050200 0.036957182 0.138180344 0.524629976 0.230701523
## RBI Walks Years CAtBat CHits
## 0.239841459 0.289618741 1.107702929 0.003131815 0.011653637
## CHmRun CRuns CRBI CWalks LeagueN
## 0.087545670 0.023379882 0.024138320 0.025015421 0.085028114
## DivisionW PutOuts Assists Errors NewLeagueN
## -6.215440973 0.016482577 0.002612988 -0.020502690 0.301433531
sqrt(sum(coef(ridge.mod)[-1,50]^2))

## [1] 6.360612
ridge.mod$lambda[60]

## [1] 705.4802
coef(ridge.mod)[,60]

## (Intercept) AtBat Hits HmRun Runs
## 54.32519950 0.11211115 0.65622409 1.17980910 0.93769713
## RBI Walks Years CAtBat CHits
## 0.84718546 1.31987948 2.59640425 0.01083413 0.04674557
## CHmRun CRuns CRBI CWalks LeagueN
## 0.33777318 0.09355528 0.09780402 0.07189612 13.68370191
## DivisionW PutOuts Assists Errors NewLeagueN
## -54.65877750 0.11852289 0.01606037 -0.70358655 8.61181213
sqrt(sum(coef(ridge.mod)[-1,60]^2))

## [1] 57.11001
predict(ridge.mod, s=50, type = "coefficients")[1:20,]

## (Intercept) AtBat Hits HmRun Runs
## 4.876610e+01 -3.580999e-01 1.969359e+00 -1.278248e+00 1.145892e+00
## RBI Walks Years CAtBat CHits
## 8.038292e-01 2.716186e+00 -6.218319e+00 5.447837e-03 1.064895e-01
## CHmRun CRuns CRBI CWalks LeagueN
## 6.244860e-01 2.214985e-01 2.186914e-01 -1.500245e-01 4.592589e+01
## DivisionW PutOuts Assists Errors NewLeagueN
## -1.182011e+02 2.502322e-01 1.215665e-01 -3.278600e+00 -9.496680e+00
set.seed(1)
train = sample(1:nrow(x), nrow(x)/2)
test = (-train)
y.test = y[test]
ridge.mod = glmnet(x[train, ], y[train], alpha = 0, lambda = grid, thresh = 1e-12)
ridge.pred = predict(ridge.mod, s=4, newx = x[test,])
mean((ridge.pred - y.test)^2)

## [1] 101036.8
mean((mean(y[train]) - y.test)^2)

## [1] 193253.1
ridge.pred = predict(ridge.mod, s=1e10, newx = x[test,])
mean((ridge.pred - y.test)^2)

## [1] 193253.1
set.seed(1)
cv.out = cv.glmnet(x[train,], y[train], alpha = 0)
plot(cv.out)
bestlam = cv.out$lambda.min
bestlam

## [1] 211.7416
ridge.pred = predict(ridge.mod, s=bestlam, newx = x[test,])
mean((ridge.pred - y.test)^2)

## [1] 96015.51
out = glmnet(x, y, alpha = 0)
predict(out, type = "coefficients", s = bestlam)[1:20,]

## (Intercept) AtBat Hits HmRun Runs
## 9.88487157 0.03143991 1.00882875 0.13927624 1.11320781
## RBI Walks Years CAtBat CHits
## 0.87318990 1.80410229 0.13074381 0.01113978 0.06489843
## CHmRun CRuns CRBI CWalks LeagueN
## 0.45158546 0.12900049 0.13737712 0.02908572 27.18227535
## DivisionW PutOuts Assists Errors NewLeagueN
## -91.63411299 0.19149252 0.04254536 -1.81244470 7.21208390
# 라쏘의 경우
lasso.mod=glmnet(x[train ,],y[train],alpha =1, lambda =grid)
plot(lasso.mod)
set.seed(1)
cv.out=cv.glmnet(x[train ,],y[train],alpha =1)
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam

## [1] 16.78016
lasso.pred=predict(lasso.mod,s=bestlam,newx=x[test ,])
mean((lasso.pred-y.test)^2)

## [1] 100743.4
out=glmnet(x,y,alpha=1,lambda=grid)
lasso.coef=predict(out,type="coefficients",s=bestlam )[1:20 ,]
lasso.coef

## (Intercept) AtBat Hits HmRun Runs
## 18.5394844 0.0000000 1.8735390 0.0000000 0.0000000
## RBI Walks Years CAtBat CHits
## 0.0000000 2.2178444 0.0000000 0.0000000 0.0000000
## CHmRun CRuns CRBI CWalks LeagueN
## 0.0000000 0.2071252 0.4130132 0.0000000 3.2666677
## DivisionW PutOuts Assists Errors NewLeagueN
## -103.4845458 0.2204284 0.0000000 0.0000000 0.0000000
# 다항회귀모형의 적합
fit = lm(wage ~ poly(age, 4), data = Wage)
coef(summary(fit))

## Estimate Std. Error t value Pr(>|t|)
## (Intercept) 111.70361 0.7287409 153.283015 0.000000e+00
## poly(age, 4)1 447.06785 39.9147851 11.200558 1.484604e-28
## poly(age, 4)2 -478.31581 39.9147851 -11.983424 2.355831e-32
## poly(age, 4)3 125.52169 39.9147851 3.144742 1.678622e-03
## poly(age, 4)4 -77.91118 39.9147851 -1.951938 5.103865e-02
fit2 = lm(wage ~ poly(age, 4, raw = TRUE), data = Wage)
coef(summary(fit2))
fit2a = lm(wage ~ age + I(age^2) + I(age^3) + I(age^4), data = Wage)
coef(summary(fit2a))
fit2b = lm(wage ~ cbind(age, age^2, age^3, age^4), data = Wage)
coef(summary(fit2b))
agelims = range(Wage$age)
age.grid = seq(from = agelims[1], to = agelims[2])
preds = predict(fit, newdata = list(age = age.grid), se = TRUE)
se.bands = cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
attach(Wage)
plot(age, wage, xlim = agelims, cex = .5, col = "darkgrey", main = "Degree-4 Polynomial")
lines(age.grid, preds$fit, lwd = 2, col = "blue")
matlines(age.grid, se.bands, lwd=1, col = "blue", lty = 3)
# 회귀스플라인 (Regression Spline)
library(splines)
fit = lm(wage~bs(age, knots=c(25,40,60)), data = Wage)
pred = predict(fit, newdata = list(age = age.grid), se = TRUE)
plot(age, wage, col = "gray")
lines(age.grid, pred$fit, lwd = 2)
lines(age.grid, pred$fit + 2*pred$se, lty = "dashed")
lines(age.grid, pred$fit - 2*pred$se, lty = "dashed")
# 자연스플라인 (Natural Spline)
fit2 = lm(wage ~ ns(age, df=4), data = Wage)
pred2 = predict(fit2, newdata = list(age = age.grid), se = TRUE)
plot(age, wage, col = "gray")
lines(age.grid, pred2$fit, col = "red", lwd = 2)
# 평활스플라인 (Smoothing Spline)
plot(age, wage, xlim=agelims, cex = .5, col = "darkgrey", main = "Smoothing Spline")
fit = smooth.spline(age, wage, df = 16)
fit2 = smooth.spline(age, wage, cv = TRUE)
fit2$df
## [1] 6.794596
lines(fit, col = "red", lwd = 2)
lines(fit2, col = "blue", lwd = 2)
legend("topright",legend=c("16 DF","6.8 DF"),col=c("red "," blue "),lty =1, lwd =2, cex =.8)
# 국소회귀 (Local Regression)
plot(age,wage,xlim=agelims,cex=.5,col="darkgrey")
title("Local Regression")
fit=loess(wage~age,span=.2,data=Wage)
fit2=loess(wage~age,span=.5,data=Wage)
lines(age.grid,predict(fit,data.frame(age=age.grid)),col="red",lwd=2)
lines(age.grid,predict(fit2,data.frame(age=age.grid)),col="blue",lwd=2)
legend("topright",legend=c("Span=0.2","Span=0.5"),col=c("red","blue"),lty=1,lwd=2,cex=.8)
# 일반화가법모형 (Generalized Additive Models)
gam1 = lm(wage~ns(year, 4)+ns(age, 5) + education, data=Wage)
library(gam)
gam.m3 = gam(wage~s(year, 4) + s(age, 5) + education, data=Wage)
summary(gam.m3)
##
## Call: gam(formula = wage ~ s(year, 4) + s(age, 5) + education, data = Wage)
## Deviance Residuals:
## Min 1Q Median 3Q Max
## -119.43 -19.70 -3.33 14.17 213.48
##
## (Dispersion Parameter for gaussian family taken to be 1235.69)
##
## Null Deviance: 5222086 on 2999 degrees of freedom
## Residual Deviance: 3689770 on 2986 degrees of freedom
## AIC: 29887.75
##
## Number of Local Scoring Iterations: 2
##
## Anova for Parametric Effects
## Df Sum Sq Mean Sq F value Pr(>F)
## s(year, 4) 1 27162 27162 21.981 2.877e-06 ***
## s(age, 5) 1 195338 195338 158.081 < 2.2e-16 ***
## education 4 1069726 267432 216.423 < 2.2e-16 ***
## Residuals 2986 3689770 1236
## ---
## Signif. codes: 0
***
  0.001
**
  0.01
*
  0.05
.
0.1
1
##
## Anova for Nonparametric Effects
## Npar Df Npar F Pr(F)
## (Intercept)
## s(year, 4) 3 1.086 0.3537
## s(age, 5) 4 32.380 <2e-16 ***
## education
## ---
preds = predict(gam.m3, newdata = Wage)
par(mfrow = c(1,3))
plot(gam.m3, se=TRUE, col = "blue")
plot.gam(gam1, se=TRUE, col = "red")
gam.m1=gam(wage~s(age,5)+education,data=Wage)
gam.m2=gam(wage~year+s(age,5)+education,data=Wage)
anova(gam.m1,gam.m2,gam.m3,test="F")
## Analysis of Deviance Table
##
## Model 1: wage ~ s(age, 5) + education
## Model 2: wage ~ year + s(age, 5) + education
## Model 3: wage ~ s(year, 4) + s(age, 5) + education
## Resid. Df Resid. Dev Df Deviance F Pr(>F)
## 1 2990 3711731
## 2 2989 3693842 1 17889.2 14.4771 0.0001447 ***
## 3 2986 3689770 3 4071.1 1.0982 0.3485661
## ---
gam.lo=gam(wage~s(year,df=4)+lo(age,span=0.7)+education,data=Wage)
par(mfrow=c(1,3))
plot.gam(gam.lo, se=TRUE, col="green")
gam.lo.i=gam(wage~lo(year,age,span=0.5)+education,data=Wage)
library(akima)
par(mfrow=c(1,2))
plot(gam.lo.i)
table(education,I(wage>250))
##
## education FALSE TRUE
## 1. < HS Grad 268 0
## 2. HS Grad 966 5
## 3. Some College 643 7
## 4. College Grad 663 22
## 5. Advanced Degree 381 45
par(mfrow=c(1,3))
gam.lr.s=gam(I(wage>250)~year+s(age, df=5)+education, family=binomial
             , data=Wage, subset =( education !="1. < HS Grad"))
plot(gam.lr.s, se=T, col="green")


# 분류, 군집 (Classification, Clustering)
# 분류
## Data for An Introduction to Statistical Learning with Applications in R
library(ISLR)

## for lda() and qda()
library(MASS)

## for knn()
library(class)

## Plotting
library(ggplot2)
library(gridExtra)
data(package = "ISLR")

## Load Smarket (S&P Stock Market Data)
data(Smarket)
head(Smarket)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
attach(Smarket)
# Logistic Regression
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)
summary(glm.fit)
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts(Direction)
glm.pred=rep("Down",1250)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction)
(507+145)/1250
mean(glm.pred==Direction)
train=(Year<2005)
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
mean(glm.pred!=Direction.2005)
## Plot
plotData <- ggplot(data = Smarket,
                   mapping = aes(x = Lag1, y = Lag2, color = Direction, shape = factor(Year))) +
  geom_point(stat = "identity", alpha = 0.8) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Original data")
plotData
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket,family=binomial(link = "logit"),subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs>.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76)
predict(glm.fit,newdata=data.frame(Lag1=c(1.2,1.5),Lag2=c(1.1,-0.8)),type="response")

## Plot
plotData <- ggplot(data = Smarket.2005,
                   mapping = aes(x = Lag1, y = Lag2, color = Direction, shape = factor(Year))) +
  geom_point(stat = "identity", alpha = 0.8) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Test data")
plotData

## Put the predicted probability
predProbLogit <- predict(glm.fit,Smarket.2005,type="response")
predClassLogit <- factor(predict(glm.fit,Smarket.2005,type="response") > 0.5,
                         levels = c(FALSE,TRUE), labels = c("Down","Up"))

## Plot (probability)
plotLogit <- ggplot(data = Smarket.2005,
                    mapping = aes(x = Lag1, y = Lag2, color = predProbLogit, shape = factor(Year))) +
  geom_point(alpha = 0.8) +
  scale_color_gradient(low = "yellow", high = "red") +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted probability of outcome (Logistic)")
grid.arrange(plotData, plotLogit, ncol = 2)
plotLdaClass <- ggplot(data = Smarket.2005,
                       mapping = aes(x = Lag1, y = Lag2, color = predClassLogit, shape = factor(Year))) +
  geom_point(alpha = 0.7) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted outcome (Logistic; p>0.5)")
grid.arrange(plotData, plotLdaClass, ncol = 2)
#Linear Discriminant Analysis
library(MASS)
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket,subset=train)
lda.fit
plot(lda.fit)
lda.pred=predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class=lda.pred$class
table(lda.class,Direction.2005)
mean(lda.class==Direction.2005)
sum(lda.pred$posterior[,1]>=.5)
sum(lda.pred$posterior[,1]<.5)
lda.pred$posterior[1:20,1]
lda.class[1:20]
sum(lda.pred$posterior[,1]>.9)
## Put into the dataset
predProbLda <- lda.pred$posterior[,"Up"]
predClassLda <- lda.pred$class
## Plot (probability)
plotLdaProb <- ggplot(Smarket.2005,
                      mapping = aes(x = Lag1, y = Lag2, color = predProbLda, shape = factor(Year))) +
  geom_point(alpha = 0.5) +
  scale_color_gradient(low = "yellow", high = "red") +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted probability of outcome (LDA)")
grid.arrange(plotData, plotLdaProb, ncol = 2)

## Plot (classification)
plotLdaClass <- ggplot(Smarket.2005,
                       mapping = aes(x = Lag1, y = Lag2, color = predClassLda, shape = factor(Year))) +
  geom_point(alpha = 0.5) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted outcome (LDA)")
grid.arrange(plotData, plotLdaClass, ncol = 2)

# Quadratic Discriminant Analysis
qda.fit=qda(Direction~Lag1+Lag2,data=Smarket,subset=train)
qda.fit
qda.pred=predict(qda.fit,Smarket.2005)
qda.class=qda.pred$class
table(qda.class,Direction.2005)
mean(qda.class==Direction.2005)

## Put into the dataset
predProbQda <- qda.pred$posterior[,"Up"]
predClassQda <- qda.pred$class

## Plot (probability)
plotQdaProb <- ggplot(Smarket.2005,
                      mapping = aes(x = Lag1, y = Lag2, color = predProbQda, shape = factor(Year))) +
  geom_point(alpha = 0.5) +
  scale_color_gradient(low = "yellow", high = "red") +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted probability of outcome (QDA)")
grid.arrange(plotData, plotQdaProb, ncol = 2)

## Plot (classification)
plotQdaClass <- ggplot(Smarket.2005,
                       mapping = aes(x = Lag1, y = Lag2, color = predClassQda, shape = factor(Year))) +
  geom_point(alpha = 0.5) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted outcome (QDA)")
grid.arrange(plotData, plotQdaClass, ncol = 2)
# K-Nearest Neighbors
library(class)
train.X=cbind(Lag1,Lag2)[train,]
test.X=cbind(Lag1,Lag2)[!train,]
train.Direction=Direction[train]
set.seed(1)
knn.pred=knn(train.X,test.X,train.Direction,k=1)
table(knn.pred,Direction.2005)
(83+43)/252
knn.pred=knn(train.X,test.X,train.Direction,k=3)
table(knn.pred,Direction.2005)
mean(knn.pred==Direction.2005)
## Fit KNN (the output is a vector of prediction)
knn.pred <- knn(train = train.X,
                test = test.X,
                cl = train.Direction, k = 3)
predClassKnn <- knn.pred

## Plot (classification)
plotKnnClass <- ggplot(Smarket.2005,
                       mapping = aes(x = Lag1, y = Lag2, color = predClassKnn, shape = factor(Year))) +
  geom_point(alpha = 0.8) +
  scale_color_manual(values = c("Down" = "yellow", "Up" = "red")) +
  theme_bw() +
  theme(legend.key = element_blank()) +
  labs(title = "Predicted outcome (KNN)")
grid.arrange(plotData, plotKnnClass, ncol = 2)


#군집분석, 요인분석

# K-Means Clustering
library(ggplot2)
set.seed(2)
nd=matrix(rnorm(50*2), ncol=2)
nd[1:25,1]=nd[1:25,1]+3
nd[1:25,2]=nd[1:25,2]-4
colnames(nd)=c("x1","x2")
km.out=kmeans(nd,2,nstart=20)
km.out$cluster
cluster=factor(km.out$cluster)
nd1=data.frame(nd,cluster)
c1=ggplot(nd1, aes(x1, x2 , color = cluster)) +
  geom_point(alpha = 0.4, size = 3.5) + labs(title = "K-Means Clustering Results with K=2")
print(c1)
dev.off()
set.seed(4)
km.out=kmeans(nd,3,nstart=20)
km.out
cluster=factor(km.out$cluster)
nd2=data.frame(nd,cluster)
c2=ggplot(nd2, aes(x1, x2 , color = cluster)) +
  geom_point(size = 3.5) + labs(title = "K-Means Clustering Results with K=3")
print(c2)
centers=as.data.frame(km.out$centers)
ggplot(data=nd2, aes(x=x1, y=x2,color=cluster )) +
  geom_point() +
  geom_point(data=centers, aes(x=x1,y=x2, color='Center')) +
  geom_point(data=centers, aes(x=x1,y=x2, color='Center'), size=52, alpha=.3, show.legend=FALSE)
set.seed(3)
km.out=kmeans(nd,3,nstart=1)
km.out$tot.withinss
km.out=kmeans(nd,3,nstart=20)
km.out$tot.withinss
#cf)
library(ggfortify)
autoplot(km.out, data=nd1,frame = TRUE)
autoplot(km.out, data=nd1,frame = TRUE, frame.type = 'norm')
autoplot(km.out, data=nd2, frame.type = "convex", frame.level = 0.95,
         frame.alpha = 0.2, main="K-Means Clustering Results with K=3")
# Hierarchical Clustering
hc.complete=hclust(dist(nd), method="complete")
hc.average=hclust(dist(nd), method="average")
hc.single=hclust(dist(nd), method="single")

#your own labels (now rownames) are supplied in geom_text() and label=label
dendr= dendro_data(hc.complete, type="rectangle")
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Complete Linkage")
dendr = dendro_data(hc.average, type="rectangle")
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Average Linkage")
dendr = dendro_data(hc.single, type="rectangle")
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Single Linkage")
ndsc=scale(nd)
hcsc.complete=hclust(dist(nd), method="complete")
dendr = dendro_data(hcsc.complete, type="rectangle")
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Hierarchical Clustering with Scaled Features")
nd3=matrix(rnorm(30*3), ncol=3)
ndd=as.dist(1-cor(t(nd3)))
hcc.complete=hclust(dist(ndd), method="complete")
dendr = dendro_data(hcc.complete, type="rectangle")
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Complete Linkage with Correlation-Based Distance")
cutree(hc.complete, 2)
cutree(hc.average, 2)
cutree(hc.single, 2)
cutree(hc.single, 4)
hc.average=hclust(dist(nd), method="average") # heirarchal clustering
dendr = dendro_data(hc.average, type="rectangle") # convert for ggplot
clust = cutree(hc.average,k=3) # find 2 clusters
names(clust)=c(1:50)
clust.df <- data.frame(label=names(clust), cluster=factor(clust))

# dendr[["labels"]] has the labels, merge with clust.df based on label column
dendr[["labels"]] <- merge(dendr[["labels"]],clust.df, by="label")

# plot the dendrogram; note use of color=cluster in geom_text(...)
ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x, y, label=label, hjust=0, color=cluster),
            size=3) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())
#(cf)

# demonstrate plotting directly from object class hclust
ggdendrogram(hc.complete)
ggdendrogram(hc.complete, rotate = TRUE, size = 5, theme_dendro = FALSE)

# demonstrate converting hclust to dendro using dendro_data first
hcdata <- dendro_data(hc.complete)
ggdendrogram(hcdata, rotate=TRUE) +
  labs(title="Dendrogram in ggplot2")

# Triangular lines
ddata <- dendro_data(as.dendrogram(hc.complete), type = "triangle")
ggplot(segment(ddata)) + geom_segment(aes(x = x, y = y, xend = xend,
                                          yend = yend)) +
  geom_text(data = label(ddata), aes(x = x,y = y, label = label), angle = 90, lineheight = 0)

# factor analysis
life<-read.table("life_expectation.txt",header=TRUE)
cor.life<-cor(life)
library(corrplot)
corrplot(cor.life, type="upper", order="hclust", tl.col="black", tl.srt=45)
d.factanal=factanal(life,factors=1, ,method="mle",rotation="varimax")
d.factanal=factanal(life,factors=2, method="mle",rotation="varimax")
d.factanal=factanal(life,factors=3, method="mle",rotation="varimax")
# How could we interpret the three factors?
sapply(1:3, function(f)
  factanal(life, factors = f, method="mle")$PVAL)
# The communalities:
life.exp <- factanal(life,factors=3, rotation="varimax")
1-life.exp$uniquenesses
### Plot loadings against one another
# Factor 1 vs. Factor 2
text=rownames(d.factanal$loadings)
load = d.factanal$loadings
ggplot(data.frame(load[,1:2]),aes(Factor1, Factor2,label = text))+
  geom_point() +
  geom_text(angle = 20,size=5)+
  labs(title="Factor 1 vs Factor 2", x="Factor1 loadings", y="Factor 2 loadings")
# Factor 1 vs. Factor 3
text=rownames(d.factanal$loadings)
load = d.factanal$loadings
ggplot(data.frame(load[,c(1,3)]),aes(Factor1, Factor3,label = text))+
  geom_point() +
  geom_text(angle = 20,size=5)+
  labs(title="Factor 1 vs Factor 2", x="Factor1 loadings", y="Factor 3 loadings")

# Factor 2 vs. Factor 3:
ggplot(data.frame(load[, 2:3]),aes(Factor2, Factor3,label = text))+
  geom_point() +
  geom_text(angle = 20,size=5)+
  labs(title="Factor 2 vs Factor 3", x="Factor2 loadings", y="Factor 3 loadings")

# Estimating factor scores for the life expectancy data set:
scores <- factanal(life,factors=3, rotation="varimax",scores="regression")$scores

### Doing separate 2-D scatterplots of the factor scores:
# Factor 1 vs. Factor 2
scores[,c(1,2,3)]
text=rownames(scores)
ggplot(data.frame(scores[, 1:2]),aes(Factor1, Factor2,label = text))+
  geom_point() +
  geom_text(angle = 20)+
  labs(title="Factor 1 vs Factor 2", x="Factor1 scores", y="Factor 2 scores")

# Factor 1 vs. Factor 3:
ggplot(data.frame(scores[, c(1,3)]),aes(Factor1, Factor3,label = text))+
  geom_point() +
  geom_text(angle = 20)+
  labs(title="Factor 1 vs Factor 3", x="Factor1 scores", y="Factor 3 scores")

# Factor 2 vs. Factor 3:
ggplot(data.frame(scores[, 2:3]),aes(Factor2, Factor3,label = text))+
  geom_point() +
  geom_text(angle = 20)+
  labs(title="Factor 2 vs Factor 3", x="Factor2 scores", y="Factor 3 scores")

#(cf)1.
d.factanal = factanal(life, factors = 3, scores = 'regression')
autoplot(d.factanal, label = TRUE, label.size = 3,
         loadings = TRUE, loadings.label = TRUE, loadings.label.size = 3)
#(cf)2.
#Using fa() from package psych with rotation
install.packages("psych")
library(psych)
d.fa = fa(r=cor.life, nfactors=3, n.obs=31, rotate="varimax")
d.fa

#Factor scores
scores <- factor.scores(x=life, f=d.fa, method="regression")
head(scores)

#Visualize loadings
factor.plot(d.fa, cut=0.5)

# 나무모형

### Decision Trees
# Fitting Classification Trees
Carseats<-read.table("Carseats.txt")
library(tree)
library(ggplot2)
library(ggdendro)
attach(Carseats)
High=ifelse(Sales<=8,"No","Yes")
Carseats=data.frame(Carseats,High)
tree.carseats=tree(High~.-Sales, Carseats)
plot(tree.carseats)
text(tree.carseats)
summary(tree.carseats)
dev.off()
# Confusion matrix
set.seed(2)
train=sample(1:nrow(Carseats), 200)
Carseats.test=Carseats[-train,]
High.test=High[-train]
tree.carseats=tree(High~.-Sales,Carseats,subset=train)
tree.pred=predict(tree.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(86+57)/200
# perform cross-validation in order to determine the optimal level of tree complexity
set.seed(3)
cv.carseats=cv.tree(tree.carseats,FUN=prune.misclass)
# prune.tree() enacts optimal deviance pruning
# prune.misclass() enacts optimal misclassification rate pruning
names(cv.carseats)
cv.carseats
# plot the error rate as a function of both size and k
library(gridExtra)
cv=data.frame(cv.carseats$size,cv.carseats$k,cv.carseats$dev)
colnames(cv) = c("size","k","dev")
min=subset(cv, dev==min(dev))
cv1=ggplot(cv,aes(x=size,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()
cv2=ggplot(cv,aes(x=k,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()
grid.arrange(cv1, cv2, nrow=1, ncol=2)
prune.carseats=prune.misclass(tree.carseats,best=9)
plot(prune.carseats)
text(prune.carseats,pretty=0)

# Confusion matrix
tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(94+60)/200
prune.carseats=prune.misclass(tree.carseats,best=15)
plot(prune.carseats)
text(prune.carseats,pretty=0)
tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred,High.test)
(86+62)/200

# (cf)
library(rpart)
tree.carseats = rpart(High~.-Sales, method = "class", data = Carseats)

# display the results
printcp(tree.carseats)

# Classification tree diagrams
ddata <- dendro_data(tree.carseats)
ggplot() +
  geom_segment(data = ddata$segments,
               aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_text(data = ddata$labels,
            aes(x = x, y = y, label = label), size = 4, vjust = 0) +
  geom_text(data = ddata$leaf_labels,
            aes(x = x, y = y, label = label), size = 4, vjust = 1) +
  theme_dendro()
# visualize cross-validation results
plotcp(tree.carseats)

# plot tree
plot(tree.carseats, uniform=TRUE,
     main="Classification Tree for Carseats")
text(tree.carseats, use.n=TRUE, all=TRUE, cex=.8)
# prune the tree
pfit<- prune(tree.carseats, cp=tree.carseats$cptable[which.min(tree.carseats$cptable[,"xerror"]),"CP"])
# plot the pruned tree
plot(pfit, uniform=TRUE,
     main="Pruned Classification Tree for Carseats")
text(pfit, use.n=F, all=TRUE, cex=.8)
# perform cross-validation in order to determine the optimal level of tree complexity
ddata <- dendro_data(pfit)
ggplot() +
  geom_segment(data = ddata$segments,
               aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_text(data = ddata$labels,
            aes(x = x, y = y, label = label), size = 4, vjust = 0) +
  geom_text(data = ddata$leaf_labels,
            aes(x = x, y = y, label = label), size = 4, vjust = 1) +
  theme_dendro()
install.packages("rpart.plot")
library(rpart.plot)
prp(pfit, faclen = 0, cex = 0.8, extra = 1)
only_count <- function(x, labs, digits, varlen)
{
  paste(x$frame$n)
}
boxcols <- c("pink", "lightblue")[pfit$frame$yval]
par(xpd=TRUE)
prp(pfit, faclen = 0, cex = 0.8, node.fun=only_count, box.col = boxcols)
legend("bottomright", legend = c("No","Yes"), fill = c("pink", "lightblue"),
       title = "Group")
# Fitting Regression Trees
library(MASS)
set.seed(1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston=tree(medv~.,Boston,subset=train)
summary(tree.boston)

# Regression tree diagrams
tree_data <- dendro_data(tree.boston)
ggplot(segment(tree_data)) +
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend, size = n),
               colour = "blue", alpha = 0.5) +
  scale_size("n") +
  geom_text(data = label(tree_data),
            aes(x = x, y = y, label = label), vjust = -0.5, size = 4) +
  geom_text(data = leaf_label(tree_data),
            aes(x = x, y = y, label = label), vjust = 0.5, size = 3) +
  theme_dendro()+
  labs(title="Regression tree diagrams")

# perform cross-validation in order to determine the optimal level of tree complexity
cv.boston=cv.tree(tree.boston)

# plot the error rate as a function of size
cv=data.frame(cv.boston$size,cv.boston$k,cv.boston$dev)
colnames(cv) = c("size","k","dev")
min=subset(cv, dev==min(dev))
ggplot(cv,aes(x=size,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()

# plot the pruned tree
prune.boston=prune.tree(tree.boston,best=5)
tree_data <- dendro_data(prune.boston)
ggplot(segment(tree_data)) +
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend, size = n),
               colour = "blue", alpha = 0.5) +
  scale_size("n") +
  geom_text(data = label(tree_data),
            aes(x = x, y = y, label = label), vjust = -0.5, size = 4) +
  geom_text(data = leaf_label(tree_data),
            aes(x = x, y = y, label = label), vjust = 0.5, size = 3) +
  theme_dendro()+
  labs(title="Regression tree diagrams")
# the test set MSE associated with the regression tree
yhat=predict(tree.boston,newdata=Boston[-train,])
boston.test=Boston[-train,"medv"]
mean((yhat-boston.test)^2)
ggplot()+
  geom_point(aes(x=yhat, y=boston.test))+
  geom_abline(intercept = 0, slope = 1, color="red",
              linetype="dashed", size=1.5)+
  xlab(expression(hat(y)))+
  ylab(expression(y[0]))
# Bagging and Random Forests
# Bagging
library(randomForest)
set.seed(1)
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,importance=TRUE)
bag.boston
# the test MSE for bagging
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)
ggplot()+
  geom_point(aes(x=yhat.bag, y=boston.test))+
  geom_abline(intercept = 0, slope = 1, color="red",
              linetype="dashed", size=1.5)+
  xlab(expression(hat(y)))+
  ylab(expression(y[0]))
bag.boston=randomForest(medv~.,data=Boston,subset=train,mtry=13,ntree=25)
yhat.bag = predict(bag.boston,newdata=Boston[-train,])
mean((yhat.bag-boston.test)^2)

# Random Forests
set.seed(1)
rf.boston=randomForest(medv~.,data=Boston,subset=train,mtry=6,importance=TRUE)

# the test MSE for random forests
yhat.rf = predict(rf.boston,newdata=Boston[-train,])
mean((yhat.rf-boston.test)^2)

# Variable Importance Plot
var_importance <- data.frame(variable=setdiff(colnames(Boston), "medv"),
                             importance=as.vector(rf.boston$importance[,1]))
var_importance <- var_importance[order(var_importance[,2]),]
var_importance$variable <- factor(var_importance$variable, levels=var_importance$variable)
vi=ggplot(var_importance,aes(x=variable, y=importance, fill=variable)) +
  geom_bar(stat='identity', position='identity')+
  scale_fill_discrete(name="Variable Name",guide = guide_legend(reverse=TRUE)) +
  coord_flip()+
  theme(axis.text.x=element_blank(),
        axis.text.y=element_text(size=12),
        axis.title=element_text(size=16),
        plot.title=element_text(size=18),
        legend.title=element_text(size=16),
        legend.text=element_text(size=12))+
  ylab("Mean square error")
var_purity <- data.frame(variable=setdiff(colnames(Boston), "medv"),
                         purity=as.vector(rf.boston$importance[,2]))
var_purity = var_purity[order(var_purity[,2]),]
var_purity$variable <- factor(var_purity$variable, levels=var_purity$variable)
np=ggplot(var_purity,aes(x=variable, y=purity, fill=variable)) +
  geom_bar(stat='identity', position='identity') +
  scale_fill_discrete(name="Variable Name",guide = guide_legend(reverse=TRUE)) +
  coord_flip()+
  theme(axis.text.x=element_blank(),
        axis.text.y=element_text(size=12),
        axis.title=element_text(size=16),
        plot.title=element_text(size=18),
        legend.title=element_text(size=16),
        legend.text=element_text(size=12))+
  ylab("Node impurity")
grid.arrange(vi, np, nrow=1, ncol=2,top="Variable Importance from Random Forest Fit")
varImpPlot(rf.boston)
# Boosting
library(gbm)
set.seed(1)
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4)
summary(boost.boston)

# partial dependence plots for rm and lstat.
par(mfrow=c(1,2))
plot(boost.boston,i="rm",col="red")
plot(boost.boston,i="lstat",col="blue")

# the test MSE for boosting
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=5000,interaction.depth=4,shrinkage=0.2,verbose=F)
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)


# [연습문제]
# 분류
# Logistic Regression
# Exercise1
#(1)
titanic = read.csv("titanic3.csv")
dim(titanic)
str(titanic)
summary(titanic)
sum(is.na(titanic))
titanic = titanic[,c(1,2,4:7)]
titanic=na.omit(titanic)
glm.fit= glm(survived ~ pclass + sex + age + sibsp,
             family = binomial, data = titanic)
summary(glm.fit)
coef(glm.fit)
summary(glm.fit)$coef
summary(glm.fit)$coef[,4]
#(2)
attach(titanic)
train = (parch < 1)
test = !train
train.titanic = titanic[train, ]
test.titanic = titanic[test, ]
test.survived = survived[test]
#(3)
glm.fit=glm(survived ~ pclass + sex + age,
            family = binomial,subset=train)
glm.probs=predict(glm.fit,test.titanic,type="response")
glm.pred=rep(0,length(glm.probs))
glm.pred[glm.probs>.5]=1
mean(glm.pred!=test.survived)
# Linear Discriminant Analysis
# Exercise 2
#(1)
library(MASS)
lda.fit=lda(survived ~ pclass + sex + age + sibsp,data=titanic, subset=train)
lda.fit
#(2)
lda.pred=predict(lda.fit,test.titanic)
names(lda.pred)
lda.class=lda.pred$class
table(lda.class,test.survived)
mean(lda.class!==test.survived)

# Quadratic Discriminant Analysis
# Exercise 3
#(1)
qda.fit=qda(survived ~ pclass + sex + age + sibsp,data=titanic, subset=train)
qda.fit

#(2)
qda.class=predict(qda.fit ,test.titanic)$class
table(qda.class,test.survived)
mean(qda.class!=test.survived)

# K-Nearest Neighbors
# Exercise 4
#(1)
library(class)
train.x = cbind(pclass, sex, age, sibsp)[train, ]
rownames(train.x)=NULL
test.x = cbind(pclass, sex, age, sibsp)[test, ]
rownames(test.x)=NULL
train.survived = survived[train]

# K=1
set.seed(0413)
knn.pred=knn(train.x,test.x,train.survived,k=1)
mean(knn.pred != test.survived)

# K=10
knn.pred=knn(train.x,test.x,train.survived,k=3)
mean(knn.pred != test.survived)

# K=100
knn.pred = knn(train.x,test.x,train.survived,k = 100)
mean(knn.pred != test.survived)


# 군집분석, 요인분석

# K-Means Clustering
# Exercise 10
library(ggfortify)
geneData = read.csv("Ch10Ex11.csv", header=F)
dim(geneData)
geneData = t(geneData)
rownames(geneData)=c(paste("H", 1:20, sep = ""),paste("D", 1:20, sep = ""))
colnames(geneData)=c(paste("g",1:1000,sep=""))
set.seed(0413)
km.out=kmeans(geneData,2,nstart=20)
cluster = km.out$cluster
cluster
autoplot(km.out,data=geneData,label = TRUE, label.size = 3, frame=TRUE)
# Hierarchical Clustering
# Exercise 11
geneData = read.csv("Ch10Ex11.csv", header=F)
dim(geneData)
geneData = t(geneData)
rownames(geneData)=c(paste("H", 1:20, sep = ""),paste("D", 1:20, sep = ""))
colnames(geneData)=c(paste("g",1:1000,sep=""))
dd = as.dist(1 - cor(t(geneData)))
hc.complete=hclust(dd, method="complete")
hc.average=hclust(dd, method="average")
hc.single=hclust(dd, method="single")
library(ggdendro)
library(gridExtra)
dendr = dendro_data(hc.complete, type="rectangle")
h1=ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Complete Linkage with Correlation-Based Distance")
dendr = dendro_data(hc.average, type="rectangle")
h2=ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Average Linkage with Correlation-Based Distance")
dendr = dendro_data(hc.single, type="rectangle")
h3= ggplot() +
  geom_segment(data=segment(dendr), aes(x=x, y=y, xend=xend, yend=yend)) +
  geom_text(data=label(dendr), aes(x=x, y=y, label=label, hjust=0), size=4) +
  coord_flip() + scale_y_reverse(expand=c(0.2, 0)) +
  theme(axis.line.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_rect(fill="white"),
        panel.grid=element_blank())+
  labs(title="Single Linkage with Correlation-Based Distance")
grid.arrange(h1, h2, h3,nrow=1, ncol=3)

# factor analysis
# Exercise 12
#(1)
pers<-read.csv("personality.csv")
library(corrplot)
corrplot(cor(pers), order = "hclust", tl.col="black", tl.srt=90)
stand.pers = as.data.frame(scale(pers))

#(2)
fac.pers = factanal(stand.pers, factors = 10, rotation = "none", na.action = na.omit)
fac.pers

#(3)
1-fac.pers$uniquenesses

# Plot loadings against one another
text=rownames(fac.pers$loadings)
load = fac.pers$loadings
ggplot(data.frame(load[,1:2]),aes(Factor1, Factor2,label = text))+
  geom_point() +
  geom_text(angle = 20,size=5)+
  labs(title="Factor 1 vs Factor 2", x="Factor1 loadings", y="Factor 2 loadings")
#(4)
# Factor analysis with rotation
fac.pers2 = factanal(stand.pers, factors = 10, rotation = "varimax", na.action = na.omit)
fac.pers2
load2 = fac.pers2$loadings[,1:2]

### Plot loadings against one another
text=rownames(fac.pers2$loadings)
load = fac.pers2$loadings
ggplot(data.frame(load[,1:2]),aes(Factor1, Factor2,label = text))+
  geom_point() +
  geom_text(angle = 20,size=5)+
  labs(title="Factor 1 vs Factor 2", x="Factor1 loadings", y="Factor 2 loadings")

### Decision Trees
# classification Trees
# Exercise 5
#(1)
titanic = read.csv("titanic3.csv")
titanic = titanic[,c(1,2,4:7)]
titanic=na.omit(titanic)
attach(titanic)
train = (parch < 1)
test = !train
train.titanic = titanic[train, ]
test.titanic = titanic[test, ]
test.survived = survived[test]
tree.titanic=tree(as.factor(survived)~ pclass+age+sex+sibsp, titanic,subset=train)
summary(tree.titanic)

#(2)
plot(tree.titanic)
text(tree.titanic,pretty = 0)
tree.pred=predict(tree.titanic,test.titanic, type="class")
table(tree.pred,test.survived)
(70+4)/length(tree.pred)

#(3)
set.seed(0413)
cv.titanic = cv.tree(tree.titanic, FUN = prune.misclass)
names(cv.titanic)
cv.titanic

# plot the error rate as a function of both size and k
library(gridExtra)
cv=data.frame(cv.titanic$size,cv.titanic$k,cv.titanic$dev)
colnames(cv) = c("size","k","dev")
min=subset(cv, dev==min(dev))
cv1=ggplot(cv,aes(x=size,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()
cv2=ggplot(cv,aes(x=k,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()
grid.arrange(cv1, cv2, nrow=1, ncol=2)
prune.titanic=prune.misclass(tree.titanic,best=3)

# Confusion matrix
tree.pred=predict(prune.titanic,test.titanic,type="class")
table(tree.pred,test.survived)
(70+4)/length(tree.pred)

# Regression Trees
# Exercise 6
#(1)
library(ISLR)
dim(Hitters)
sum(is.na(Hitters$Salary))
Hitters =na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters))
train=1:200
train hitters=Hitters[train ]
train.hitters=Hitters[train,]
test.hitters=Hitters[-train,]
attach(Hitters)
tree.hitters=tree(log(Salary) ~., data=Hitters,subset=train)
tree.hitters

#(2)
tree_data <- dendro_data(tree.hitters)
ggplot(segment(tree_data)) +
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend, size = n),
               colour = "blue", alpha = 0.5) +
  scale_size("n") +
  geom_text(data = label(tree_data),
            aes(x = x, y = y, label = label), vjust = -0.5, size = 4) +
  geom_text(data = leaf_label(tree_data),
            aes(x = x, y = y, label = label), vjust = 0.5, size = 3) +
  theme_dendro()+
  labs(title="Regression tree diagrams")
pred.hitters = predict(tree.hitters, test.hitters)
mean((log(test.hitters$Salary) - pred.hitters)^2)

#(3)
set.seed(0413)
cv.hitters = cv.tree(tree.hitters, FUN = prune.tree)
cv=data.frame(cv.hitters$size,cv.hitters$k,cv.hitters$dev)
colnames(cv) = c("size","k","dev")
min=subset(cv, dev==min(dev))
ggplot(cv,aes(x=size,y=dev))+
  geom_point()+
  geom_point(data=min, size=3, colour=alpha("red", 0.7))+
  geom_line()
pruned.hitters = prune.tree(tree.hitters, best = 5)
pred.pruned = predict(pruned.hitters, test.hitters)
mean((log(test.hitters$Salary) - pred.pruned)^2)

# Bagging
# Exercise 7
#(1)
train=1:200
train.hitters=Hitters[train,]
test.hitters=Hitters[-train,]
attach(Hitters)
library(randomForest)
set.seed(0413)
bag.hitters = randomForest(log(Salary) ~ ., data = train.hitters, mtry = 19, ntree = 500,
                           importance = T)

#(2)
bag.pred = predict(bag.hitters, test.hitters)
mean((log(test.hitters$Salary) - bag.pred)^2)
bag.hitters = randomForest(log(Salary) ~ ., data = train.hitters, mtry = 19, ntree = 25,
                           importance = T)
bag.pred = predict(bag.hitters, test.hitters)
mean((log(test.hitters$Salary) - bag.pred)^2)

# Random Forest
# Exercise 8
#(1)
set.seed(0413)
rf.hitters = randomForest(log(Salary) ~ ., data = train.hitters, mtry = 6, ntree = 500,
                          importance = T)
rf.pred = predict(rf.hitters, test.hitters)
mean((log(test.hitters$Salary) - rf.pred)^2)

#(2)
# Variable Importance Plot
var_importance <- data.frame(variable=setdiff(colnames(Hitters), "Salary"),
                             importance=as.vector(rf.hitters$importance[,1]))
var_importance <- var_importance[order(var_importance[,2]),]
var_importance$variable <- factor(var_importance$variable, levels=var_importance$variable)
ggplot(var_importance,aes(x=variable, y=importance, fill=variable)) +
  geom_bar(stat='identity', position='identity')+
  scale_fill_discrete(name="Variable Name",guide = guide_legend(reverse=TRUE)) +
  coord_flip()+
  theme(axis.text.x=element_blank(),
        axis.text.y=element_text(size=12),
        axis.title=element_text(size=16),
        plot.title=element_text(size=18),
        legend.title=element_text(size=16),
        legend.text=element_text(size=12))+
  ylab("Mean square error")

# Boosting
# Exercise 9
#(1)

library(gbm)
set.seed(0413)
boost.hitters=gbm(log(Salary)~.,data=train.hitters,distribution="gaussian",
                  n.trees=5000,interaction.depth=4,shrinkage = 0.01)
summary(boost.hitters)

#(2)
yhat.boost=predict(boost.hitters,newdata=test.hitters,n.trees=5000)
mean((yhat.boost-log(test.hitters$Salary))^2)
5일 : 추천 알고리즘 (Recommendation System)

########################
#3. Colaborate filtering
#3.1 Jester5k data ####
#data loading
install.packages("recommenderlab")
library(recommenderlab)
data(Jester5k)
head(as(Jester5k,"matrix"))
image(Jester5k[1:80]) #Jester5k user1~80까지만 추출해서 ratingmatrix를 확인

#colaborate filtering
r=Recommender(Jester5k[1:1000],method="UBCF") #method를 IBCF로하면 item-based CF
pr=predict(r, Jester5k[1:2], type="ratings")
as(pr,"matrix") #이미 평가한 자료의 경우 예측값을 주지 않는다
ptype=predict(r, Jester5k[1:2], n=5) #n을 통해 추천품목수를 조정 가능
as(ptype,"list")
as(pr[1],"matrix")[,order(as(pr[1],"matrix"),decreasing = T)] #첫번째 user에 대해 예상별점을 정렬

#3.2 scale 보정 #######
#making dummy variable
a = as(Jester5k[1:1000],"matrix")
dgmat=cbind(a[1:100000],as.data.frame(cbind(rep(rownames(a),ncol(Jester5k[1:1000])),rep(colnames(a),each=nrow(Jester5k[1:1000]))))) #
각 행은 하나의 평점에 대한 정보를 가짐
colnames(dgmat)=c("rating","user","item")
user=unique(dgmat$user); item=unique(dgmat$item)
head(dgmat)
dgmat=dgmat[is.na(dgmat$rating)==F,] #평점이 있는 정보만 사용
dummy=model.matrix(rating~user+item,dgmat) #user와 item에 대해 dummy variable 생성
head(dummy)

#estimate mu by ridge regression
library(glmnet)

#cv.lm=cv.glmnet(dummy, dgmat$rating, type.measure="deviance", alpha=0) #시간이 오래 걸림.. 집에서 해보세요..
lm = glmnet(dummy,dgmat$rating,family="gaussian",lambda=0.2, alpha=0) #cv돌려본 결과 최적의 lambda와 대충 일치. 실제로는 cv.lm$lambd
a.min을 넣어준다.

#기존 형식으로 자료 변환
dgmat$rating=dgmat$rating-dummy%*%lm$beta
user.index=match(dgmat$user,user); item.index=match(dgmat$item,item) #각 row의 user(item)가 몇번째 user(item) 인지 확인
mat=sparseMatrix(i=user.index,j=item.index,x=dgmat$rating)
mat=as.matrix(mat) ; sum(dgmat$rating==0,na.rm=T) ;mat[mat==0]=NA #dgmat$rating 값 중 0이 없음을 확인하고 NA를 넣음
colnames(mat)=item ; rownames(mat)=user
mat = as(mat,"realRatingMatrix") #Recommender 함수를 위해 다시 rating matrix로..

#예상 평점 계산
r1=Recommender(mat,method="UBCF")
pr1=predict(r1, mat[1:2], type="ratings")
pr1 = as(pr1,"matrix")
rownames(lm$beta)=gsub('user','',rownames(lm$beta)) ;rownames(lm$beta)=gsub('item','',rownames(lm$beta)) #lm$beta의 이름 정제(왜 필요한
지는 하기 전에 확인)
item=as.character(item) ; user=as.character(user)
user1_dummy=c()
for(i in 1:length(item)){ #user1과 user2에 대해 앞에서 추정한 mu들을 더해주기 위한 과정
  b=rep(0,length(lm$beta))
  b[match(c(user[1],item[i]),rownames(lm$beta))]=1
  b[1]=1
  user1_dummy=cbind(user1_dummy,b)
}
scale.value=rbind(t(lm$beta) %*% user1_dummy ,t(lm$beta) %*% user2_dummy)
pr1.final= scale.value+pr1 ; colnames(pr1.final)=item
pr1.final[,order(pr1.final[1,],decreasing = T)] #user1에 대해 예상평점이 높은 순으로 정렬

#예제 - MovieLense data
data("MovieLense")

#위 과정을 따라서 해보세요!
########################
#4. matrix factorization
#4.1 Jester5k data ####
#install library
library(matfact)
mf = matfact(as(Jester5k,"matrix")[1:1000,])
pred = mf$P %*% t(mf$Q)
colnames(pred)=item ; rownames(pred)=user
head(pred)

#prediction
i1 = is.na(as(Jester5k,"matrix")[1,]) #사용자 1,2가 평점을 내리지 않은 상품들을 추출
i2 = is.na(as(Jester5k,"matrix")[2,])
pred[1,i1==T] ; sort(pred[1,i1==T],decreasing=T) #평점을 내리지 않은 상품들에 대해서만 예상평점을 관찰
pred[2,i2==T] ; sort(pred[2,i2==T],decreasing=T)

#4.2 scale 보정 ####
mat1=as(mat,"matrix") #앞에서 scale 보정에 사용했던 mat 변수를 그대로 사용하면 된다.
mf1 = matfact(mat1)
pred1 = mf1$P %*% t(mf1$Q)
colnames(pred1)=item ; rownames(pred1)=user
pred1.final=pred1[1:2,]+scale.value #앞에서와 같은 보정값을 더해주면 된다
pred1.final[1,i1==T] ; pred1.final[2,i2==T] #matrix factorization을 통한 user1,2의 예상별점
sort(pred1.final[1,i1==T],decreasing=T); sort(pred1.final[2,i2==T],decreasing=T) #matrix factorization을 통한 user1,2의 예상별점(별점
순으로 정렬)

#matrix factorization
#예제 - MovieLense data
#위 과정을 따라서 해보세요!
##########################
#7. 구매자료를 이용한 추천
#7.1 연관성분석 ####
#tot data 불러오기
install.packages("arules")
library(arules)
shop=as.matrix(shop)
rules=apriori(shop, parameter=list(supp=0.1,conf=0.9)) #연관규칙 형성
rules.sorted=sort(rules, by="lift")
inspect(rules.sorted)

#7.2 conditional regression approach ####
#너무 오래 걸림....
#pred=c()
#for(i in 1:ncol(tot)){
# cv.fit=cv.glmnet(tot[,-i],tot[,i],family="binomial",alpha=0,nfolds=3)
# pred.new=predict(cv.fit,newx=tot[,-i],s="lambda.min",type="response")
# pred=cbind(pred,pred.new)
#}
#미리 해놓은 결과값 불러오기
pred=read.csv("F:\\Stat\\job\\recommender_공개강좌\\실습자료\\prediction.csv")
rownames(pred)=pred[,1];pred=pred[,-1]
pred[which(tot==1)]=0 #구매내역이 있으면 기대확률을 볼 필요가 없으므로 0으로 처리
sort(pred[1,],decreasing=T)[1:10] #첫번째 user에게 추천하는 상품들 상위 10개와 그 기대 확률ㄷ

#인터넷 쇼핑몰 자료
#shop 자료 불러오기
#구매자료를 이용한 추천 다시 하기



