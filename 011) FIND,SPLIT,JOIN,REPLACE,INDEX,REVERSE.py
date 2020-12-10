# -*- coding: utf-8 -*-
"""
Created on Thu Dec 10 14:41:18 2020

@author: goboy
"""


■Q-284.  우리반 데이터(emp122.csv) 를 파이썬으로 로드해서
 이메일만 출력하시오 !

import  csv
file = open("c:\\data\\emp122.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    print ( emp_list[6] )

■Q-285.  위에서 출력한 이메일에서 @ 의 위치 인덱스 번호를
출력하시오 !

import  csv
file = open("c:\\data\\emp122.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    print ( emp_list[6].find('@') )

■Q-286. 그러면 이번에는 이메일에서 . 의 위치 인덱스를 출력하시오

import  csv
file = open("c:\\data\\emp122.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    print ( emp_list[6].find('.') )

■Q-287.   이번에는 이메일을 출력하는데 이메일의 첫번째 철자부터
세번째 철자까지만 출력하시오 !

import  csv
file = open("c:\\data\\emp122.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    print ( emp_list[6][0:4] )

■Q-288.  우리반 데이터 이메일을 출력하는데 이메일에서 도메인만 출력하시오

 gmail
 gmail
 naver
 naver
   :
   :

답:

import  csv
file = open("c:\\data\\emp123.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    a = emp_list[6].find('@')  # @ 의 위치 인덱스 번호
    b = emp_list[6].find('.')    # .  의 위치 인덱스 번호 
    print ( emp_list[6][ a +1 : b ] )

■Q-289. 미승이의 이메일인 miseung.hailey@gmail.com 도 같이 
출력하려면 어떻게 해야하는가 ?

import  csv
file = open("c:\\data\\emp123.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    a = emp_list[6].find('@')  # @ 의 위치 인덱스 번호
    b = emp_list[6].rfind('.')    # .  의 위치 인덱스 번호를 뒤에서 부터 찾음
    print ( emp_list[6][ a +1 : b ] )

■Q-290. rfind도 domain.co.kr 같은곳은 domain.co까지 끊겨서 
문제생기지 않을까요?




■ Q-291. 아래의 url 변수에 있는 문자열은 슬래쉬(/) 로 구분되어있는데
            이 문자열의 요소를 아래의 리스트 처럼 구성하시오 !

url ='http://www.naver.com/news/today=20191204'
result = url.split('/')
print (result)


■Q-292.  우리반 데이터에서 이름만 출력하시오 !

import  csv
file = open("c:\\data\\emp123.csv", encoding="UTF8")
emp_csv = csv.reader(file)
for  emp_list  in  emp_csv:
    print(emp_list[1] )

■Q-293. 위에서 출력된 이름을 a 라는 비어있는 리스트에 담고
 a 리스트를 출력하시오 !

import  csv
file = open("c:\\data\\emp1222.csv", encoding="CP949")
emp_csv = csv.reader(file)
a = [ ]
for  emp_list  in  emp_csv:
    a.append(emp_list[1] )

print(a)


■Q-294.  위의 a 리스트에 담겨진 이름을 하나씩 뽑아서 콤마(,) 로 연결해서
아래와 같이 문자열로 출력되게하시오
이준혁,한결,현지연,성기창,유혜영,......................

import  csv
file = open("c:\\data\\emp1222.csv", encoding="CP949")
emp_csv = csv.reader(file)
a = [ ]
for  emp_list  in  emp_csv:
    a.append(emp_list[1] )
bond=','
result = bond.join(a)
print(result)

■Q-295.  위의 결과가 김씨부터 출력되게하시오 ~ 
 (한글을 정렬을 해서 출력하시오 ㄱ ㄴ ㄷ ㄹ 순서로)

import  csv
file = open("c:\\data\\emp1222.csv", encoding="CP949")
emp_csv = csv.reader(file)
a = [ ]
for  emp_list  in  emp_csv:
    a.append(emp_list[1] )
a.sort()  # a 리스트 안의 요소를 정렬을 합니다. 
bond=','
result = bond.join(a)
print(result)


■Q-296.  emp2.csv 에서 이름과 월급을 출력하는데 월급을 출력할 때
0 대신에 * 로 출력하시오 !

 SCOTT   3***
 SMITH  125*
    :         : 
import  csv 
file = open("c:\\data\\emp2.csv")
emp_csv=csv.reader(file)

for  emp_list  in  emp_csv:
    print( emp_list[1], emp_list[5].replace('0','*' ) )

■Q-297. 아래의 리스트를 가지고 아래와 같이 출력하시오 !

a = [ 'name:홍길동', 'age:17', 'major:경영학', 'nation:한국' ]

결과:
         name ----> 홍길동
         age  ----> 17
         major ----> 경영학
         nation ----> 한국

a = [ 'name:홍길동', 'age:17', 'major:경영학', 'nation:한국' ]

for  i in  a:
    print ( i.replace( ':' , ' ----> ')  )

■Q-298. (점심시간 문제)  우리반 데이터에서 이름을 출력하는데
아래와 같이 나이도 같이 출력되게하시오 !


import csv
file = open("c:\\data\\emp1222.csv",encoding='UTF8')
emp_csv=csv.reader(file)
a=[]
for emp_list in emp_csv:
    a.append(emp_list[1]+'('+ emp_list[2]+')')
print(a)



■ Q-300.  주사위 2개를 만들고 주사위 2개를 동시에 던져서
두 주사위의 눈의 합이 10 이 나오는 확률을 구하시오 !
 ( 주사위 2개를 동시에 10000 번 던지세요 ~)

import  random

dice1 = list( range(1, 7) )
dice2 = list( range(1, 7) )
cnt = 0
for  i  in  range(1, 10001):
    result1 = random.choice(dice1)
    result2 = random.choice(dice2)
    if  result1 + result2 == 10:
        cnt = cnt + 1

print(cnt/10000)  # 0.084

■ Q-301.  아래의 결과를 출력하시오!

  [ 2, 4, 6, 7, 10, 12, 14, 16, 18 ]

a = list( range(2, 20, 2) )  # range(시작숫자, 끝숫자, 스텝)
print (a)                       # 시작숫자부터 끝숫자 미만까지 스텝만큼 증가해서
                                 # 출력한다.

 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 


■ Q-302. 아래의 리스트에서 숫자 7을 출력하시오 !

b = [ 2, 3, 4, [ 5, 6 ], [ 7, 8 ], 9 ] 

print (b[4][0])

print ( a.index('a') )  # 2

■ Q-303.  아래의 리스트에서  숫자 4의 인덱스 번호를 출력하시오!

a = [ 1, 2, 'a', 'b', 'c', [ 4, 5, 6 ] ] 

print (a.index(4) )

ValueError: 4 is not in list

답:  리스트 안에 있는 리스트의 인덱스 번호는 출력못함


■ Q-304.  list_a 의 알파벳 d 를  k 로 변경하시오 !

list_a = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g' ]

list_a[ list_a.index('d') ] = 'k'
print( list_a )  # ['a', 'b', 'c', 'k', 'e', 'f', 'g']


■ Q-305. 위에는 알파벳 a 부터 g 까지 담은 리스트를 만들었는데 
 이번에는 알파벳 a 부터 z 까지를 담는 리스트를 list_a 로 
  생성하시오 ~

['a', 'b', 'c', 'd', ..............................,'z' ]

import  string  # string 모듈안에 알파벳이 들어있습니다. 

list_a = [ ]
for  i  in   string.ascii_lowercase:
    list_a.append(i)
print ( list_a ) 

■ Q-306.  위에서 만든 list_a 에서 요소를 검색하는데 맨 끝에  알파벳 z 
빼고 모든 요소를 다 출력하시오 !  

['a', 'b', 'c', 'd',....................'y' ]

import  string  # string 모듈안에 알파벳이 들어있습니다. 

list_a = [ ]
for  i  in   string.ascii_lowercase:
    list_a.append(i)
print ( list_a[0 : list_a.index('z') ] ) 


■ Q-307.  1부터 100까지의 숫자중에 짝수만 아래의 list_a 담아서 출력하시오

print (list_a)

 [ 2, 4, 6, 8 , 10, 12, ................................  100 ]

답:
list_a = list( range(2, 101, 2 )  )
print (list_a) 

■ Q-308.   우리반 테이블에서 이름을 출력하는데 ㅎ 부터 ㄱ 까지 출력될수
있도록 하시오 

import csv
file=open('c:\\data\\emp122.csv',encoding='UTF8')
emp_122 =csv.reader(file)
a=[]
for emp_list in emp_122:
    a.append(emp_list[1])
a.sort()
a.reverse()
result = ','.join(a)
print(result)

 
■ Q-309.  emp2.csv 에서 이름과 월급을 출력하시오 !

import  csv 
file = open("c:\\data\\emp2.csv")
emp_csv=csv.reader(file)

for  emp_list  in  emp_csv:
    print( emp_list[1], emp_list[5] )

■ Q-310.  위의 데이터중 월급을 비어있는 리스트인 a 리스트에 담으시오 

import  csv 
file = open("c:\\data\\emp2.csv")
emp_csv=csv.reader(file)
a = [ ] 
for  emp_list  in  emp_csv:
    a.append( emp_list[5] )
print(a)

■ Q-311. 위의 a 리스트에 있는 월급을 월급이 높은 순서데로 정렬해서 
a 리스트에 들어있게 하고 a 리스트를 출력하시오 

import  csv 
file = open("c:\\data\\emp2.csv")
emp_csv=csv.reader(file)
a = [ ] 
for  emp_list  in  emp_csv:
    a.append( int( emp_list[5] ) )
a.sort()  # 먼저 낮은값에 높은값 순으로 정렬하고 
a.reverse() # 낮은값에서 높은값 순으로 정렬된 a 리스트의 데이터를 
              # 역순으로 만듭니다. 
print(a)


■ Q-312.  아래와 같이 엄마와 아기가 함께하는 수영교실 나이 리스트를
생성하시오 !  일일이 숫자를 쓰지말고 파이썬 코드로 간단하게
만들어보세요

[ 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]

답:
listdata1 = [34]
listdata2 = [2] 
print ( listdata1 * 10 + listdata2 * 2 )


■ Q-313.   아래의 엄마와 아기가 함께하는 수영교실의 나이의 평균값을
출력하시오 !

swim_age = [ 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]

import   numpy  as  np
a = np.array(swim_age) # numpy array(배열) 로 만들어준다. 
b = np.mean(a)
print(b)   # 18.0

■ Q-314. 아래의 엄마와 아기의 수영교실의 중앙값을 출력하시오 !
 ( 중앙값은 가운데 있는 값)

swim_age = [ 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]

import   numpy  as  np
a = np.array(swim_age) # numpy array(배열) 로 만들어준다. 
b = np.median(a)
print(b)   # 18.0

■ Q-315. 엄마와 아기가 함께하는 수영교실 나이 데이터의 최빈값을 출력하시오

swim_age = [ 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]

from  scipy  import  stats
import  numpy  as  np
a = np.array(swim_age)
result = stats.mode(a)
print (result) # ModeResult(mode=array([2]), count=array([10]))

■ Q-316.  우리반 나이 데이터를 비어있는 리스트 a 에 담으시오 !
( emp1222.csv 를 읽으세요 ~)

import  csv
file = open("c:\\data\\emp1222.csv", encoding="CP949")
emp_csv = csv.reader(file)
a = [ ]
for  emp_list  in  emp_csv:
    a.append( int(emp_list[2] ) )
print(a)

[29, 31, 35, 29, 28, 28, 25, 28, 27, 27, 27, 26, 33, 30, 27, 27, 25, 28, 29, 24, 24, 29, 36, 26, 26, 26, 44, 28, 29, 28]

■ Q-317. 우리반 나이 데이터의 평균값과 중앙값과 최빈값을 출력하시오 !

import  csv
import  numpy as  np
from scipy  import  stats
file = open("c:\\data\\emp1222.csv", encoding="CP949")
emp_csv = csv.reader(file)
a = [ ]
for  emp_list  in  emp_csv:
    a.append( int(emp_list[2] ) )
a2 = np.array(a)
print('평균값:', np.mean(a2))
print('중앙값:', np.median(a2))
print('최빈값:', stats.mode(a2) )


■ Q-318. (오늘의 마지막 문제) 우리반 나이 데이터를 가지고 히스토그램 
그래프를 그리시오 !                                          
x축의 계급(간격)은  24 ~ 44 (2살 간격으로)

import numpy as np
import matplotlib.pyplot as plt
import csv
file=open('c:\\data\\emp1222.csv',encoding='CP949')
emp_1222=csv.reader(file)
age=[]
for emp_list in emp_1222:
    age.append(int(emp_list[2]))
bins=[24,26,28,30,32,34,36,38,40,42,44]
plt.grid()
plt.hist(age,bins,rwidth=0.8,alpha=0.7,color='teal)
