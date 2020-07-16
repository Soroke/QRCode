package net.faxuan.core;

import java.io.File;

public class GenerateQRCode {

    /**
     * 默认生成二维码（规格：长款 800px，路径为本地）
     * @param url
     */
    private static void url(String url) {
        if (url.equals("") || url == null) {
            System.err.println("请填写url路径");
        }
        //获取当前的目录
        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,"qrcode.png");
        qrCodeService.encode(url,800,800,file);
    }

    /**
     * 默认生成二维码（规格：长款 800px）
     * @param url  二维码指向URL
     * @param path  二维码文件路径
     */
    private static void urlPath(String url,String path) {
        if (url.equals("") || path == null) {
            System.err.println("url或路径为空");
        }
        //获取当前的目录
//        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,"qrcode.png");
        qrCodeService.encode(url,800,800,file);
    }

    /**
     * 生成二维码（规格：长款 800px）
     * @param url  二维码指向URL
     * @param path  二维码文件路径
     * @param name  二维码文件名称
     */
    private static void urlPathName(String url,String path,String name) {
        if (url.equals("") || path == null) {
            System.err.println("url或路径为空");
        }
        //获取当前的目录
//        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,name);
        qrCodeService.encode(url,800,800,file);
    }

    /**
     * 生成二维码,指定二维码大小
     * @param url  二维码指向URL
     * @param width  二维码宽
     * @param heigth  二维码高
     */
    private static void urlWH(String url,int width,int heigth) {
        if (url.equals("")) {
            System.err.println("url不能为空");
        }
        //获取当前的目录
        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,"qrcode.png");
        qrCodeService.encode(url,width,heigth,file);
    }

    /**
     * 生成二维码,指定二维码大小
     * @param url  二维码指向URL
     * @param path  二维码文件路径
     * @param width  二维码宽
     * @param heigth  二维码高
     */
    private static void urlPathWH(String url,String path,int width,int heigth) {
        if (url.equals("")) {
            System.err.println("url不能为空");
        }
        //获取当前的目录
//        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,"qrcode.png");
        qrCodeService.encode(url,width,heigth,file);
    }

    /**
     * 生成二维码,指定二维码大小
     * @param url  二维码指向URL
     * @param path  二维码文件路径
     * @param name   二维码文件名称
     * @param width  二维码宽
     * @param heigth  二维码高
     */
    private static void urlPathNameWH(String url,String path,String name,int width,int heigth) {
        if (url.equals("")) {
            System.err.println("url不能为空");
        }
        //获取当前的目录
//        String path = System.getProperty("user.dir");
//        System.out.println(path);
        //生成二维码
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File(path,name);
        qrCodeService.encode(url,width,heigth,file);
    }


    public static void main(String[] ages) {
        switch (ages.length){
            case 1:
                url(ages[0]);
                break;
            case 2:
                urlPath(ages[0],ages[1]);
                break;
            case 3:
                urlPathName(ages[0],ages[1],ages[2]);
                break;
            case 5:
                urlPathNameWH(ages[0],ages[1],ages[2],Integer.valueOf(ages[3]),Integer.valueOf(ages[4]));
                break;
            default:
                System.err.println("参数不正确无法创建二维码");
                break;
        }
    }
}
