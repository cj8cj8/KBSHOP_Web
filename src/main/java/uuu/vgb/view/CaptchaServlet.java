package uuu.vgb.view;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CaptchaServlet
 */
//@WebServlet(urlPatterns = {"/images/captcha.png","/images/captcha_register.png"})
public class CaptchaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private int len,width=30*2+12*len,height=40;
     
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CaptchaServlet() {
        super();
        System.out.println("captchServlet 建立了一個物件");
    }
    @Override
    public void init() {
    	String len=this.getInitParameter("length");
    	if(len!=null&&len.matches("\\d+")) {
    		this.len=Integer.parseInt(len);
    		width=30*2+12*this.len;
    	}
    	
    }
  
   
    private BufferedImage generateImage(String rand, int width, int height) {
        //開始建立圖片
        BufferedImage image =
        new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();   //取得影像繪圖區
 
        //畫出背景方塊
        g.setColor(getRandomColor(200, 250)); //設定繪圖區背景色
        g.fillRect(0, 0, width, height);    //在繪圖區畫個長方型

        //畫干擾線讓背景雜亂  i=>畫幾條線
        Random random = new Random();
        g.setColor(getRandomColor(150, 230));
        for (int i = 0; i<200; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(25);
            g.drawLine(x, y, x + xl, y + yl);
          
         
        }

        //畫出認證文字
        g.setFont(new Font("Arial", Font.HANGING_BASELINE, 30));//設定字體
        g.setColor(getRandomColor(20, 140));
        
        //將認證文字畫到image中
       
        g.drawString(rand, 5, 30);
        
        g.dispose();
        return image;
    } 

    private Color getRandomColor(int fc, int bc) {
        //在參數設定的範圍內，隨機產生顏色
        Random random = new Random();
        if (fc > 255) fc = 255;
        if (bc > 255) bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			//1.不需取得request中的FormData
			//2.用亂數產生len個英(大寫)數字的字元
			String captcha="";
			Random random=new Random();
			for(int i=0;i<len;i++) {
				int data =random.nextInt(62);
				char ch=(char)(data<10?(data+'0'):((data>9&&data<36)?(data-10+'A'):(data-36+'a')));
				//char ch=(char)(data<10?(data+'0'):(data-10+'A'));
				captcha+=ch;
				//System.out.println("ch:"+ch);
			}
		System.out.println("captcha:"+captcha);
		
		HttpSession session =request.getSession();
		session.setAttribute(this.getServletName(), captcha);//this.getServletName();
		
			
		  BufferedImage image = generateImage(captcha, width, height);
		 
		  response.setContentType("image/png");
	        try (ServletOutputStream outStream = response.getOutputStream();){      //將影像輸出到前端
	            ImageIO.write(image, "JPEG", outStream);
	        } 
	
	}

}
