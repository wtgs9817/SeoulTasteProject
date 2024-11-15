package com.example.crowling;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class ImageCrowling {

    static String mapclass ="";

    public Document getImageUrl(String url) {
        //WebDriverManager는 Selenium WebDriver에서 브라우저 드라이버(여기서는 크롬)을 자동으로 다운로드하고 설정해주는 라이브러리
        //Chromedriver() 는 크롬을 자동으로 실행할 수 있게 해주는 드라이버 설정 메소드
        //setup() 드라이버를 자동으로 설치하고 드라이버의 경로를 설정해줌. (개발자가 별도로 chromeDriver를 다운로드하고 경로설정할 필요가 없음)

        WebDriverManager.chromedriver().setup();
        WebDriver driver = new ChromeDriver();
        Document doc = null;

        try{
            driver.get(url);

            //페이지가 완전히 로드된 후 html 소스 가져오기
            String pageSource = driver.getPageSource();

            //Jsoup 으로 html 파싱
            doc = Jsoup.parse(pageSource);
            //System.out.println(doc.html());

            // 요소 찾기 (MapMain 포함 클래스)
            WebElement mapMainElement = driver.findElement(By.cssSelector("#root > div > div[class*='MapMain']"));
            mapclass = mapMainElement.getAttribute("class").replace(" ", ".");
        }

        catch(Exception e){
            e.printStackTrace();
        }
        finally {
            driver.quit(); //브라우저 종료
        }

        return doc;
    }

    public static void printHtml(Document doc, String sel) {
        Document document = doc;
        String selector = sel;

        // 요소 찾기 (MapMain 포함 클래스)

        if(document.select(selector) == null) {
            System.out.println("selector 경로가 잘못됨");
        }
        else {
            System.out.println(document.select(selector));
        }
    }

    public static void main(String[] args) {

        String url = "";
    }


}
