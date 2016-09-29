Tomcat Hot deploy시 문제 해결
1.class 변경 제한
  Tomcat/conf/context.xml에서
   <Context crossContext="true"  antiJARLocking="true" antiResourceLocking="true">
    또는  
    Tomcat/conf/server.xml에서
  <Context docBase="F:\Repository\Git\MyFramework\MyFramework\web" path="/s" reloadable="false" antiJARLocking="true" antiResourceLocking="true" /></Host>
    
    
2. jsp, tags 자동 복사.
	2.1 eclipse Plugin설치 : FileSync
	2.2 eclipse > Project > File synchronization
	2.3 반영될 파일 정보 등록
	  > static/**/*.*
	  > jsp/**/*.*
	  > *.*
	  > WEB-INF/**/*.tag
	
3. myBatis / Message Resource 반영을 위한 처리
	3.1 myBatis (url로 변경)  -> /MyFramework/src/com/base/sql/SqlMapConfig.xml
		<mapper resource="com/base/system/sql/Auth.xml"/><!--  [메뉴 관리] -->
		--> <mapper url="file:////F:/Repository/Git/MyFramework/MyFramework/web/WEB-INF/classes/com/base/system/sql/Auth.xml"/><!--  [권한 관리] -->
	3.2 Message Resource (url로 변경) -> /MyFramework/src/project/config/applicationContext.xml
		<value>/WEB-INF/classes/message/ActionMessage</value>
		--> <value>file:////F:/Repository/Git/MyFramework/MyFramework/web/WEB-INF/classes/message/ActionMessage</value>
	