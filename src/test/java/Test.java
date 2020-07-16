import net.faxuan.core.QRCodeService;

import java.io.File;

public class Test {
    public static void main(String [] ages) {
        QRCodeService qrCodeService = new QRCodeService();
        File file = new File("D:\\","soroke.png");
        qrCodeService.encode("https://www.jianshu.com/p/6015822d44c7",800,800,file);
        File file1 = new File("D:\\","soroke1.png");
        File file2 = new File("D:\\原D盘\\aaaAAA原来的桌面\\Test\\头像\\1.jpg");
        qrCodeService.encodeWithLogo(file,file2,file1);
    }
}
