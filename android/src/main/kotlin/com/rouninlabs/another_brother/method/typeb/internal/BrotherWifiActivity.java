package com.rouninlabs.another_brother.method.typeb.internal;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Typeface;
import android.graphics.pdf.PdfRenderer;
import android.os.Build;
import android.os.Environment;
import android.os.ParcelFileDescriptor;
import android.os.StrictMode;
import android.text.Layout;
import android.text.StaticLayout;
import android.text.TextPaint;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

import androidx.annotation.RequiresApi;

public class BrotherWifiActivity
{
    private static final String TAG = "THINBTCLIENT";
    private static final boolean D = true;
    private InputStream InStream = null;
    private OutputStream OutStream = null;
    private Socket socket = null;
    private String printerstatus = "";
    private int last_bytes = 0;
    private byte[] buffer = new byte[1024];
    private byte[] readBuf = new byte[1024];
    private static String receive_data = "";
    private Button connect = null;
    private Button closeport = null;
    private Button sendfile = null;
    private Button status = null;
    private TextView tv1 = null;
    private TextView tv2 = null;
    private static int counter = 0;
    private byte[] udp_data = new byte[512];
    private static byte[] udpbyte = new byte[1024];
    private int[] decipaddress = new int[200];
    private static String[] get_NAME = new String[100];
    private static String[] get_IP = new String[100];
    private static String[] get_MAC = new String[100];
    private static String[] get_status = new String[100];
    public String[] UDP_NAME = new String[100];
    public String[] UDP_IP = new String[100];
    public String[] UDP_MAC = new String[100];
    public String[] UDP_status = new String[100];
    private int port_connected = 0;

    public BrotherWifiActivity() {
    }

    public String openport(String ipaddress, int portnumber) {
        Log.e("openport", Thread.currentThread().toString());
        //StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
        //StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

        try {
            this.socket = new Socket();
            this.socket.connect(new InetSocketAddress(ipaddress, portnumber), 2000);
            this.InStream = this.socket.getInputStream();
            this.OutStream = this.socket.getOutputStream();
            this.port_connected = 1;
            return "1";
        } catch (Exception var6) {
            try {
                this.socket.close();
            } catch (IOException var5) {
                this.port_connected = 0;
                return "-2";
            }

            this.port_connected = 0;
            return "-1";
        }
    }

    public String closeport() {
        try {
            Thread.sleep(1500L);
        } catch (InterruptedException var3) {
            var3.printStackTrace();
        }

        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                this.socket.close();
                return "1";
            } catch (IOException var2) {
                return "-1";
            }
        }
    }

    public String closeport(int timeout) {
        try {
            Thread.sleep((long)timeout);
        } catch (InterruptedException var5) {
            var5.printStackTrace();
        }

        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                this.socket.close();
            } catch (IOException var4) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var3) {
                var3.printStackTrace();
            }

            return "1";
        }
    }

    public String setup(int width, int height, int speed, int density, int sensor, int sensor_distance, int sensor_offset) {
        String message = "";
        String size = "SIZE " + width + " mm" + ", " + height + " mm";
        String speed_value = "SPEED " + speed;
        String density_value = "DENSITY " + density;
        String sensor_value = "";
        if (sensor == 0) {
            sensor_value = "GAP " + sensor_distance + " mm" + ", " + sensor_offset + " mm";
        } else if (sensor == 1) {
            sensor_value = "BLINE " + sensor_distance + " mm" + ", " + sensor_offset + " mm";
        }

        message = size + "\r\n" + speed_value + "\r\n" + density_value + "\r\n" + sensor_value + "\r\n";
        byte[] msgBuffer = message.getBytes();

        try {
            this.OutStream.write(msgBuffer);
            return "1";
        } catch (IOException var15) {
            return "-1";
        }
    }

    public String clearbuffer() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "CLS\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    public String barcode(int x, int y, String type, int height, int human_readable, int rotation, int narrow, int wide, String string) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "";
            String barcode = "BARCODE ";
            String position = x + "," + y;
            String mode = "\"" + type + "\"";
            String height_value = "" + height;
            String human_value = "" + human_readable;
            String rota = "" + rotation;
            String narrow_value = "" + narrow;
            String wide_value = "" + wide;
            String string_value = "\"" + string + "\"";
            message = barcode + position + " ," + mode + " ," + height_value + " ," + human_value + " ," + rota + " ," + narrow_value + " ," + wide_value + " ," + string_value + "\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var22) {
                return "-1";
            }
        }
    }

    public String printerfont(int x, int y, String size, int rotation, int x_multiplication, int y_multiplication, String string) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "";
            String text = "TEXT ";
            String position = x + "," + y;
            String size_value = "\"" + size + "\"";
            String rota = "" + rotation;
            String x_value = "" + x_multiplication;
            String y_value = "" + y_multiplication;
            String string_value = "\"" + string + "\"";
            message = text + position + " ," + size_value + " ," + rota + " ," + x_value + " ," + y_value + " ," + string_value + "\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var18) {
                return "-1";
            }
        }
    }

    public String sendcommand(String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    public String printlabel(int quantity, int copy) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "";
            message = "PRINT " + quantity + ", " + copy + "\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var6) {
                return "-1";
            }
        }
    }

    public String windowsfont(int x_coordinates, int y_coordinates, int fontsize, String path, String textToPrint) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        Paint paint = new Paint();
        paint.setStyle(Paint.Style.FILL);
        paint.setColor(-16777216);
        paint.setAntiAlias(true);
        Typeface typeface = Typeface.createFromFile(path);
        paint.setTypeface(typeface);
        paint.setTextSize((float)fontsize);
        TextPaint textpaint = new TextPaint(paint);
        StaticLayout staticLayout = new StaticLayout(textToPrint, textpaint, 832, Layout.Alignment.ALIGN_NORMAL, 1.0F, 0.0F, false);
        int height = staticLayout.getHeight();
        int width = (int)Layout.getDesiredWidth(textToPrint, textpaint);
        if (height > 2378) {
            height = 2378;
        }

        try {
            original_bitmap = Bitmap.createBitmap(width + 8, height, Bitmap.Config.RGB_565);
            Canvas c = new Canvas(original_bitmap);
            c.drawColor(-1);
            c.translate(0.0F, 0.0F);
            staticLayout.draw(c);
        } catch (IllegalArgumentException var32) {
        } catch (OutOfMemoryError var33) {
        }

        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
        return "1";
    }

    public String downloadpcx(Context context, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + filename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var7) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            return "1";
        }
    }

    public String downloadbmp(Context context, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + filename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var7) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            return "1";
        }
    }

    public String downloadttf(Context context, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + filename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var7) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            return "1";
        }
    }

    public String formfeed() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "";
            message = "FORMFEED\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    public String nobackfeed() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "";
            message = "SET TEAR OFF\r\n";
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    public String sendfile(Context context, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                byte[] data = new byte[fis.available()];

                while(fis.read(data) != -1) {
                }

                this.OutStream.write(data);
                fis.close();
                return "1";
            } catch (Exception var4) {
                return "-1";
            }
        }
    }

    public String printerstatus(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 63};
            int length = 0;
            String query = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var7) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var7);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    length = this.InStream.read(this.readBuf);
                }
            } catch (IOException var8) {
                return "-1";
            }

            if (length == 0) {
                return "";
            } else {
                if (this.readBuf[0] == 0) {
                    query = "00";
                } else if (this.readBuf[0] == 1) {
                    query = "01";
                } else if (this.readBuf[0] == 2) {
                    query = "02";
                } else if (this.readBuf[0] == 3) {
                    query = "03";
                } else if (this.readBuf[0] == 4) {
                    query = "04";
                } else if (this.readBuf[0] == 5) {
                    query = "05";
                } else if (this.readBuf[0] == 8) {
                    query = "08";
                } else if (this.readBuf[0] == 9) {
                    query = "09";
                } else if (this.readBuf[0] == 10) {
                    query = "0A";
                } else if (this.readBuf[0] == 11) {
                    query = "0B";
                } else if (this.readBuf[0] == 12) {
                    query = "C";
                } else if (this.readBuf[0] == 13) {
                    query = "0D";
                } else if (this.readBuf[0] == 16) {
                    query = "10";
                } else if (this.readBuf[0] == 32) {
                    query = "20";
                } else if (this.readBuf[0] == 128) {
                    query = "80";
                }

                return query;
            }
        }
    }

    public String rfidGetReadData() {
        return this.sendcommand_getstring("");
    }

    public String rfidRead(String unlock, String format, String startBlock, String readDataSize, String memoryBank) {
        String cmd = "RFID READ," + unlock + "," + format + "," + startBlock + "," + readDataSize + "," + memoryBank + ",\"\"\r\n";
        String result = this.sendcommand(cmd);
        return result;
    }

    public String rfidWrite(String lock, String format, String startBlock, String readDataSize, String memoryBank, String data) {
        String cmd = "RFID WRITE," + lock + "," + format + "," + startBlock + "," + readDataSize + "," + memoryBank + ",\"" + data + "\"\r\n";
        String result = this.sendcommand(cmd);

        try {
            Thread.sleep(500L);
        } catch (InterruptedException var10) {
        }

        return result;
    }

    public String rfidDetect() {
        return this.sendcommand("RFIDDETECT\r\n");
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public String printPDFbyPath(Context context, String filename, int x_coordinates, int y_coordinates, int printer_dpi) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);
            FileInputStream fis = new FileInputStream(file);

            if (!filename.toLowerCase().endsWith(".pdf")) {
                return "-1";
            } else {
                PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
                int PageCount = mPdfRenderer.getPageCount();

                for(int idx = 0; idx < PageCount; ++idx) {
                    PdfRenderer.Page page = mPdfRenderer.openPage(idx);
                    int width = page.getWidth() * printer_dpi / 72;
                    int height = page.getHeight() * printer_dpi / 72;
                    Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                    Canvas canvas = new Canvas(bitmap);
                    canvas.drawColor(-1);
                    canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                    page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                    page.close();
                    this.sendcommand("CLS\r\n");
                    this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                    this.sendcommand("PRINT 1\r\n");
                    bitmap.recycle();
                }

                mPdfRenderer.close();
                return "1";
            }
        } catch (Exception var14) {
            var14.printStackTrace();
            return "-1";
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public String printPDFbyPath(Context context, String filename, int x_coordinates, int y_coordinates, int printer_dpi, int page_index) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);
            FileInputStream fis = new FileInputStream(file);

            if (filename.toLowerCase().endsWith(".pdf")) {
                PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
                int PageCount = mPdfRenderer.getPageCount();
                int idx = page_index - 1;
                if (idx >= 0 && idx < PageCount) {
                    PdfRenderer.Page page = mPdfRenderer.openPage(idx);
                    int width = page.getWidth() * printer_dpi / 72;
                    int height = page.getHeight() * printer_dpi / 72;
                    Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                    Canvas canvas = new Canvas(bitmap);
                    canvas.drawColor(-1);
                    canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                    page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                    page.close();
                    this.sendcommand("CLS\r\n");
                    this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                    this.sendcommand("PRINT 1\r\n");
                    bitmap.recycle();
                }

                mPdfRenderer.close();
                return "1";
            } else {
                return "-1";
            }
        } catch (Exception var15) {
            var15.printStackTrace();
            return "-1";
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public int getPDFPageCountbyPath(Context context, String filename) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);

            if (filename.toLowerCase().endsWith(".pdf")) {
                PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
                int PageCount = mPdfRenderer.getPageCount();
                mPdfRenderer.close();
                return PageCount;
            } else {
                return -1;
            }
        } catch (Exception var5) {
            var5.printStackTrace();
            return -1;
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public String printPDFbyFile(File file, int x_coordinates, int y_coordinates, int printer_dpi) {
        try {
            PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
            int PageCount = mPdfRenderer.getPageCount();

            for(int idx = 0; idx < PageCount; ++idx) {
                PdfRenderer.Page page = mPdfRenderer.openPage(idx);
                int width = page.getWidth() * printer_dpi / 72;
                int height = page.getHeight() * printer_dpi / 72;
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                Canvas canvas = new Canvas(bitmap);
                canvas.drawColor(-1);
                canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                page.close();
                this.sendcommand("CLS\r\n");
                this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                this.sendcommand("PRINT 1\r\n");
                bitmap.recycle();
            }

            mPdfRenderer.close();
            return "1";
        } catch (Exception var13) {
            var13.printStackTrace();
            return "-1";
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public String printPDFbyFile(File file, int x_coordinates, int y_coordinates, int printer_dpi, int page_index) {
        try {
            PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
            int PageCount = mPdfRenderer.getPageCount();
            int idx = page_index - 1;
            if (idx >= 0 && idx < PageCount) {
                PdfRenderer.Page page = mPdfRenderer.openPage(idx);
                int width = page.getWidth() * printer_dpi / 72;
                int height = page.getHeight() * printer_dpi / 72;
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                Canvas canvas = new Canvas(bitmap);
                canvas.drawColor(-1);
                canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                page.close();
                this.sendcommand("CLS\r\n");
                this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                this.sendcommand("PRINT 1\r\n");
                bitmap.recycle();
            }

            mPdfRenderer.close();
            return "1";
        } catch (Exception var14) {
            var14.printStackTrace();
            return "-1";
        }
    }

    public int getPDFPageCountbyFile(File file) {
        try {
            PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
            int PageCount = mPdfRenderer.getPageCount();
            mPdfRenderer.close();
            return PageCount;
        } catch (Exception var4) {
            var4.printStackTrace();
            return -1;
        }
    }

    private String openport(String ipaddress, int portnumber, int delay) {
        Log.e("openport", Thread.currentThread().toString());
        StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
        StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

        try {
            this.socket = new Socket();
            this.socket.connect(new InetSocketAddress(ipaddress, portnumber), 2000);
            this.InStream = this.socket.getInputStream();
            this.OutStream = this.socket.getOutputStream();
            this.port_connected = 1;
        } catch (Exception var8) {
            try {
                this.socket.close();
            } catch (IOException var6) {
                this.port_connected = 0;
                return "-2";
            }

            this.port_connected = 0;
            return "-1";
        }

        try {
            Thread.sleep((long)delay);
        } catch (InterruptedException var7) {
            var7.printStackTrace();
        }

        return "1";
    }

    private String openport_time(String ipaddress, int portnumber, int timeout) {
        StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
        StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

        try {
            this.socket = new Socket();
            this.socket.connect(new InetSocketAddress(ipaddress, portnumber), timeout);
            this.InStream = this.socket.getInputStream();
            this.OutStream = this.socket.getOutputStream();
            this.port_connected = 1;
            return "1";
        } catch (Exception var5) {
            this.port_connected = 0;
            return "-1";
        }
    }

    private String openport_thread(final String ipaddress, final int portnumber) {
        Log.e("openport_thread", Thread.currentThread().toString());
        Thread thread = new Thread(new Runnable() {
            public void run() {
                Log.e("openport_thread2", Thread.currentThread().toString());
                StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
                StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

                try {
                    BrotherWifiActivity.this.socket = new Socket();
                    BrotherWifiActivity.this.socket.connect(new InetSocketAddress(ipaddress, portnumber), 2000);
                    BrotherWifiActivity.this.InStream = BrotherWifiActivity.this.socket.getInputStream();
                    BrotherWifiActivity.this.OutStream = BrotherWifiActivity.this.socket.getOutputStream();
                    BrotherWifiActivity.this.port_connected = 1;
                } catch (Exception var2) {
                    BrotherWifiActivity.this.port_connected = 0;
                }

            }
        });
        thread.start();
        return "1";
    }

    private String openport_thread(final String ipaddress, final int portnumber, int delay) {
        Log.e("openport_thread", Thread.currentThread().toString());
        Thread thread = new Thread(new Runnable() {
            public void run() {
                Log.e("openport_thread2", Thread.currentThread().toString());
                StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
                StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

                try {
                    BrotherWifiActivity.this.socket = new Socket();
                    BrotherWifiActivity.this.socket.connect(new InetSocketAddress(ipaddress, portnumber), 2000);
                    BrotherWifiActivity.this.InStream = BrotherWifiActivity.this.socket.getInputStream();
                    BrotherWifiActivity.this.OutStream = BrotherWifiActivity.this.socket.getOutputStream();
                    BrotherWifiActivity.this.port_connected = 1;
                } catch (Exception var2) {
                    BrotherWifiActivity.this.port_connected = 0;
                }

            }
        });
        thread.start();

        try {
            Thread.sleep((long)delay);
        } catch (InterruptedException var6) {
            var6.printStackTrace();
        }

        return "1";
    }

    private String sendcommand_thread(final String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            Log.e("sendcommand_thread", Thread.currentThread().toString());
            Thread thread = new Thread(new Runnable() {
                public void run() {
                    Log.e("sendcommand_thread2", Thread.currentThread().toString());
                    byte[] msgBuffer = message.getBytes();

                    try {
                        BrotherWifiActivity.this.OutStream.write(msgBuffer);
                    } catch (IOException var3) {
                        var3.printStackTrace();
                    }

                }
            });
            thread.start();
            return "1";
        }
    }

    private String sendcommandUTF8(String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] msgBuffer = null;

            try {
                msgBuffer = message.getBytes("UTF-8");
            } catch (UnsupportedEncodingException var5) {
                var5.printStackTrace();
            }

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    private String sendcommandBig5(String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] msgBuffer = null;

            try {
                msgBuffer = message.getBytes("big5");
            } catch (UnsupportedEncodingException var5) {
                var5.printStackTrace();
            }

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    private String sendcommandGB2312(String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] msgBuffer = null;

            try {
                msgBuffer = message.getBytes("GB2312");
            } catch (UnsupportedEncodingException var5) {
                var5.printStackTrace();
            }

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        }
    }

    public String sendcommand(byte[] message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                this.OutStream.write(message);
                return "1";
            } catch (IOException var3) {
                return "-1";
            }
        }
    }

    private String status() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 83};
            this.readBuf = new byte[1024];

            try {
                this.OutStream.write(message);
            } catch (IOException var4) {
                return "-1";
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var3) {
                var3.printStackTrace();
            }

            int tim;
            try {
                while(this.InStream.available() > 0) {
                    this.readBuf = new byte[1024];
                    tim = this.InStream.read(this.readBuf);
                }
            } catch (IOException var5) {
                return "-1";
            }

            if (this.readBuf[0] == 2 && this.readBuf[5] == 3) {
                for(tim = 0; tim <= 7; ++tim) {
                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ready";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 72 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Jam";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 68 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Empty";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "No Paper";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 66 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Jam";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Empty";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 67 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Cutting";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 75 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Press Print Key";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 76 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Take Label";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 80 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Printing Batch";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 96 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        this.readBuf = new byte[1024];
                        break;
                    }
                }
            }

            return this.printerstatus;
        }
    }

    private String status(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 83};
            this.readBuf = new byte[1024];

            try {
                this.OutStream.write(message);
            } catch (IOException var5) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            int tim;
            try {
                while(this.InStream.available() > 0) {
                    this.readBuf = new byte[1024];
                    tim = this.InStream.read(this.readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            if (this.readBuf[0] == 2 && this.readBuf[5] == 3) {
                for(tim = 0; tim <= 7; ++tim) {
                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ready";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 72 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Jam";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 68 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Empty";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "No Paper";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 66 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Jam";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Empty";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 67 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Cutting";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 75 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Press Print Key";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 76 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Take Label";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 80 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Printing Batch";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 96 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        this.readBuf = new byte[1024];
                        break;
                    }

                    if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        this.readBuf = new byte[1024];
                        break;
                    }
                }
            }

            return this.printerstatus;
        }
    }

    private String status(int delay1, int delay2) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 83};
            this.readBuf = new byte[1024];
            String printername = "";
            printername = this.printername(delay1);
            int name_length = printername.toString().trim().length();
            if (name_length < 3) {
                return "-1";
            } else {
                try {
                    this.OutStream.write(message);
                } catch (IOException var8) {
                    return "-1";
                }

                try {
                    Thread.sleep((long)delay2);
                } catch (InterruptedException var7) {
                    var7.printStackTrace();
                }

                int tim;
                try {
                    while(this.InStream.available() > 0) {
                        this.readBuf = new byte[1024];
                        tim = this.InStream.read(this.readBuf);
                    }
                } catch (IOException var9) {
                    return "-1";
                }

                if (this.readBuf[0] == 2 && this.readBuf[5] == 3) {
                    for(tim = 0; tim <= 7; ++tim) {
                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ready";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 64 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 96 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 72 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Jam";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 68 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Empty";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "No Paper";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 66 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Jam";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 65 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Empty";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 67 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Cutting";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 75 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Press Print Key";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 76 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Take Label";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 80 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Printing Batch";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 96 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            this.readBuf = new byte[1024];
                            break;
                        }

                        if (this.readBuf[tim] == 2 && this.readBuf[tim + 1] == 69 && this.readBuf[tim + 2] == 64 && this.readBuf[tim + 3] == 64 && this.readBuf[tim + 4] == 64 && this.readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            this.readBuf = new byte[1024];
                            break;
                        }
                    }
                }

                return this.printerstatus;
            }
        }
    }

    private String printer_completestatus() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 83};

            try {
                this.OutStream.write(message);
            } catch (IOException var5) {
                return "-1";
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() <= 0) {
                }

                this.readBuf = new byte[1024];
                int length = this.InStream.read(this.readBuf);
                if (length > 0) {
                    String completestatus = new String(this.readBuf, 1, 4);
                    return completestatus;
                } else {
                    return "-1";
                }
            } catch (IOException var6) {
                return "-1";
            }
        }
    }

    private String printer_completestatus(int delaytime) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 83};

            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                return "-1";
            }

            try {
                Thread.sleep((long)delaytime);
            } catch (InterruptedException var5) {
            }

            try {
                while(this.InStream.available() <= 0) {
                }

                this.readBuf = new byte[1024];
                int length = this.InStream.read(this.readBuf);
                if (length > 0) {
                    String completestatus = new String(this.readBuf, 1, 4);
                    return completestatus;
                } else {
                    return "-1";
                }
            } catch (IOException var7) {
                return "-1";
            }
        }
    }

    private String batch() {
        if (this.port_connected == 0) {
            return "Connected Error";
        } else {
            //int printvalue = false;
            String printbatch = "";
            String stringbatch = "0";
            String message = "~HS";
            this.readBuf = new byte[1024];
            byte[] batcharray = new byte[]{48, 48, 48, 48, 48, 48, 48, 48};
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var9) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var9);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            int i;
            try {
                while(this.InStream.available() > 50) {
                    this.readBuf = new byte[1024];
                    i = this.InStream.read(this.readBuf);
                }
            } catch (IOException var10) {
                var10.printStackTrace();
            }

            if (this.readBuf[0] == 2) {
                System.arraycopy(this.readBuf, 55, batcharray, 0, 8);

                for(i = 0; i <= 7; ++i) {
                    if (batcharray[i] == 44) {
                        batcharray = new byte[]{57, 57, 57, 57, 57, 57, 57, 57};
                    }
                }

                stringbatch = new String(batcharray);
                int printvalue = Integer.parseInt(stringbatch);
                printbatch = Integer.toString(printvalue);
                byte[] readBuf = new byte[1024];
                if (printbatch == "99999999") {
                    printbatch = "";
                }
            }

            return printbatch;
        }
    }

    private String printername() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!T";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var5) {
                return "-1";
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 5) {
                    this.readBuf = new byte[1024];
                    int var3 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String name = new String(this.readBuf);
            return name;
        }
    }

    private String printername(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!T";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var6) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 5) {
                    this.readBuf = new byte[1024];
                    int var4 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String name = new String(this.readBuf);
            return name;
        }
    }

    private String printermemory() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!A";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var5) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var5);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 10) {
                    this.readBuf = new byte[1024];
                    int var3 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String memory = new String(this.readBuf);
            return memory;
        }
    }

    private String printermemory(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!A";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 10) {
                    this.readBuf = new byte[1024];
                    int var4 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String memory = new String(this.readBuf);
            return memory;
        }
    }

    private String printermileage() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!@";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var5) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var5);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 1) {
                    this.readBuf = new byte[1024];
                    int var3 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String mileage = new String(this.readBuf);
            return mileage;
        }
    }

    private String printermileage(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!@";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 1) {
                    this.readBuf = new byte[1024];
                    int var4 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String mileage = new String(this.readBuf);
            return mileage;
        }
    }

    private String sendcommand_getstring(String message) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String end_judge = "OUT \"ENDLINE\"\r\n";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();
            byte[] msgBuffer1 = "\r\n".getBytes();
            byte[] msgBuffer2 = end_judge.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                this.OutStream.write(msgBuffer1);
                this.OutStream.write(msgBuffer2);
            } catch (IOException var7) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var7);
            }

            try {
                while(!this.ReadStream_judge()) {
                }
            } catch (Exception var8) {
                return "-1";
            }

            return receive_data;
        }
    }

    private String sendcommand_getstring(String message, int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String end_judge = "OUT \"ENDLINE\"\r\n";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();
            byte[] msgBuffer1 = "\r\n".getBytes();
            byte[] msgBuffer2 = end_judge.getBytes();

            try {
                this.OutStream.write(msgBuffer);
                this.OutStream.write(msgBuffer1);
                this.OutStream.write(msgBuffer2);
            } catch (IOException var8) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var8);
            }

            try {
                while(!this.ReadStream_judge(delay)) {
                }
            } catch (Exception var9) {
                return "-1";
            }

            return receive_data;
        }
    }

    private boolean ReadStream_judge() {
        receive_data = "";

        do {
            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 1) {
                    int length = this.InStream.read(this.readBuf);
                    receive_data = receive_data + new String(this.readBuf);

                    try {
                        Thread.sleep(100L);
                    } catch (InterruptedException var3) {
                        var3.printStackTrace();
                    }
                }
            } catch (IOException var5) {
                return false;
            }
        } while(!receive_data.contains("ENDLINE\r\n"));

        receive_data = receive_data.replace("ENDLINE\r\n", "");
        return true;
    }

    private boolean ReadStream_judge(int delay) {
        receive_data = "";

        do {
            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 1) {
                    int length = this.InStream.read(this.readBuf);
                    receive_data = receive_data + new String(this.readBuf);

                    try {
                        Thread.sleep(100L);
                    } catch (InterruptedException var4) {
                        var4.printStackTrace();
                    }
                }
            } catch (IOException var6) {
                return false;
            }
        } while(!receive_data.contains("ENDLINE\r\n"));

        receive_data = receive_data.replace("ENDLINE\r\n", "");
        return true;
    }

    private String printercodepage() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!I";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var5) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var5);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 5) {
                    this.readBuf = new byte[1024];
                    int var3 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String codepage = new String(this.readBuf);
            return codepage;
        }
    }

    private String printercodepage(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!I";
            this.readBuf = new byte[1024];
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 5) {
                    this.readBuf = new byte[1024];
                    int var4 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String codepage = new String(this.readBuf);
            return codepage;
        }
    }

    private String printerfile() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!F";
            this.readBuf = new byte[1024];
            this.buffer = new byte[1024];
            byte[] buffer2 = new byte[1024];
            int last_bytes = 0;
            //int bytes = false;
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var8) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var8);
            }

            try {
                Thread.sleep(2000L);
            } catch (InterruptedException var7) {
                var7.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int bytes = this.InStream.read(this.readBuf);
                    if (bytes >= 0) {
                        this.buffer = this.readBuf;
                        System.arraycopy(this.buffer, 0, buffer2, last_bytes, bytes);
                    }

                    this.buffer = new byte[1024];
                    last_bytes = bytes;
                    this.readBuf = buffer2;
                }
            } catch (IOException var9) {
                return "-1";
            }

            String files = new String(this.readBuf);
            return files;
        }
    }

    private String printerfile(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            String message = "~!F";
            this.readBuf = new byte[1024];
            this.buffer = new byte[1024];
            byte[] buffer2 = new byte[1024];
            int last_bytes = 0;
            //int bytes = false;
            byte[] msgBuffer = message.getBytes();

            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var9) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var9);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int bytes = this.InStream.read(this.readBuf);
                    if (bytes >= 0) {
                        this.buffer = this.readBuf;
                        System.arraycopy(this.buffer, 0, buffer2, last_bytes, bytes);
                    }

                    this.buffer = new byte[1024];
                    last_bytes = bytes;
                    this.readBuf = buffer2;
                }
            } catch (IOException var10) {
                return "-1";
            }

            String files = new String(this.readBuf);
            return files;
        }
    }

    private void restart() {
        if (this.port_connected != 0) {
            byte[] message = new byte[]{27, 33, 82};

            try {
                this.OutStream.write(message);
            } catch (IOException var3) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var3);
            }

        }
    }

    private byte printerstatus_byte() {
        if (this.port_connected == 0) {
            return -1;
        } else {
            byte[] message = new byte[]{27, 33, 63};
            //int length = false;
            String var3 = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var8 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                this.readBuf[0] = -1;
            }

            return this.readBuf[0];
        }
    }

    private byte printerstatus_byte(int delay) {
        if (this.port_connected == 0) {
            return -1;
        } else {
            byte[] message = new byte[]{27, 33, 63};
            //int length = false;
            String var4 = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var7) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var7);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var9 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var8) {
                this.readBuf[0] = -1;
            }

            return this.readBuf[0];
        }
    }

    private String printerstatus() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 63};
            //int length = false;
            String query = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var8 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            if (this.readBuf[0] == 0) {
                query = "00";
            } else if (this.readBuf[0] == 1) {
                query = "01";
            } else if (this.readBuf[0] == 2) {
                query = "02";
            } else if (this.readBuf[0] == 3) {
                query = "03";
            } else if (this.readBuf[0] == 4) {
                query = "04";
            } else if (this.readBuf[0] == 5) {
                query = "05";
            } else if (this.readBuf[0] == 8) {
                query = "08";
            } else if (this.readBuf[0] == 9) {
                query = "09";
            } else if (this.readBuf[0] == 10) {
                query = "0A";
            } else if (this.readBuf[0] == 11) {
                query = "0B";
            } else if (this.readBuf[0] == 12) {
                query = "0C";
            } else if (this.readBuf[0] == 13) {
                query = "0D";
            } else if (this.readBuf[0] == 16) {
                query = "10";
            } else if (this.readBuf[0] == 32) {
                query = "20";
            } else if (this.readBuf[0] == 128) {
                query = "80";
            }

            return query;
        }
    }

    private String queryprinter() {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 63};
            //int length = false;
            String query = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var6);
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    this.readBuf = new byte[1024];
                    int var8 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            if (this.readBuf[0] == 0) {
                query = "0";
            } else if (this.readBuf[0] == 1) {
                query = "1";
            } else if (this.readBuf[0] == 2) {
                query = "2";
            } else if (this.readBuf[0] == 3) {
                query = "3";
            } else if (this.readBuf[0] == 4) {
                query = "4";
            } else if (this.readBuf[0] == 5) {
                query = "5";
            } else if (this.readBuf[0] == 8) {
                query = "8";
            } else if (this.readBuf[0] == 9) {
                query = "9";
            } else if (this.readBuf[0] == 10) {
                query = "A";
            } else if (this.readBuf[0] == 11) {
                query = "B";
            } else if (this.readBuf[0] == 12) {
                query = "C";
            } else if (this.readBuf[0] == 13) {
                query = "D";
            } else if (this.readBuf[0] == 16) {
                query = "10";
            } else if (this.readBuf[0] == 32) {
                query = "20";
            } else if (this.readBuf[0] == 128) {
                query = "80";
            }

            return query;
        }
    }

    private String queryprinter(int delay) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            byte[] message = new byte[]{27, 33, 63};
            //int length = false;
            String query = "";

            try {
                this.OutStream.write(message);
            } catch (IOException var7) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var7);
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    this.readBuf = new byte[1024];
                    int var9 = this.InStream.read(this.readBuf);
                }
            } catch (IOException var8) {
                return "-1";
            }

            if (this.readBuf[0] == 0) {
                query = "0";
            } else if (this.readBuf[0] == 1) {
                query = "1";
            } else if (this.readBuf[0] == 2) {
                query = "2";
            } else if (this.readBuf[0] == 3) {
                query = "3";
            } else if (this.readBuf[0] == 4) {
                query = "4";
            } else if (this.readBuf[0] == 5) {
                query = "5";
            } else if (this.readBuf[0] == 8) {
                query = "8";
            } else if (this.readBuf[0] == 9) {
                query = "9";
            } else if (this.readBuf[0] == 10) {
                query = "A";
            } else if (this.readBuf[0] == 11) {
                query = "B";
            } else if (this.readBuf[0] == 12) {
                query = "C";
            } else if (this.readBuf[0] == 13) {
                query = "D";
            } else if (this.readBuf[0] == 16) {
                query = "10";
            } else if (this.readBuf[0] == 32) {
                query = "20";
            } else if (this.readBuf[0] == 128) {
                query = "80";
            }

            return query;
        }
    }

    private String qrcode(int x, int y, String ecc, String cell, String mode, String rotation, String model, String mask, String content) {
        String message = "QRCODE " + x + "," + y + "," + ecc + "," + cell + "," + mode + "," + rotation + "," + model + "," + mask + "," + "\"" + content + "\"" + "\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.port_connected == 0) {
            return "-1";
        } else if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var13) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String bar(String x, String y, String width, String height) {
        String message = "BAR " + x + "," + y + "," + width + "," + height + "\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.port_connected == 0) {
            return "-1";
        } else if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var8) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String sendfile(String path, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/" + path + "/" + filename);
                byte[] data = new byte[fis.available()];

                while(fis.read(data) != -1) {
                }

                this.OutStream.write(data);
                fis.close();
                return "1";
            } catch (Exception var5) {
                return "-1";
            }
        }
    }

    private byte[] return_file_byte(String path, String filename) {
        byte[] error_status = "ERROR".getBytes();
        byte[] data = new byte[1024];

        try {
            FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/" + path + filename);
            data = new byte[fis.available()];
            fis.close();
            return data;
        } catch (Exception var6) {
            return error_status;
        }
    }

    private String send_file_data(String download_name, byte[] data) {
        try {
            String download = "DOWNLOAD F,\"" + download_name + "\"," + data.length + ",";
            byte[] download_head = download.getBytes();
            this.OutStream.write(download_head);
            this.OutStream.write(data);
            this.OutStream.flush();
        } catch (Exception var6) {
            return "-1";
        }

        try {
            Thread.sleep(100L);
        } catch (InterruptedException var5) {
            var5.printStackTrace();
        }

        return "1";
    }

    private String downloadfile_absolutePath(String path, String Store_name) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                FileInputStream fis = new FileInputStream(path);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
                String download = "DOWNLOAD F,\"" + Store_name + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var9) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            return "1";
        } else {
            return "-1";
        }
    }

    private String downloadfile_absolutePath(File file, String Store_name) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                FileInputStream fis = new FileInputStream(file);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
                String download = "DOWNLOAD F,\"" + Store_name + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var9) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            return "1";
        } else {
            return "-1";
        }
    }

    private String downloadfile(String path, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                FileInputStream fis = new FileInputStream(path + filename);
                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + filename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var8) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var7) {
                var7.printStackTrace();
            }

            return "1";
        }
    }

    public String downloadfile(File file, String filename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                FileInputStream fis = new FileInputStream(file);
                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + filename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var8) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var7) {
                var7.printStackTrace();
            }

            return "1";
        }
    }

    private String downloadfile(String path, String filename, String savename) {
        if (this.port_connected == 0) {
            return "-1";
        } else {
            try {
                FileInputStream fis = new FileInputStream(path + filename);
                byte[] data = new byte[fis.available()];
                String download = "DOWNLOAD F,\"" + savename + "\"," + data.length + ",";
                byte[] download_head = download.getBytes();

                while(true) {
                    if (fis.read(data) == -1) {
                        this.OutStream.write(download_head);
                        this.OutStream.write(data);
                        this.OutStream.flush();
                        fis.close();
                        break;
                    }
                }
            } catch (Exception var9) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            return "1";
        }
    }

    private void Discovery_UDP(int delay) {
        StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
        StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());

        try {
            this.SendUDP();
            Thread.sleep((long)delay);
            DatagramPacket packet = new DatagramPacket(this.udp_data, this.udp_data.length);
            packet.setAddress(InetAddress.getByName("255.255.255.255"));
            packet.setPort(22368);
            DatagramSocket ds = new DatagramSocket(22368, InetAddress.getByName("0.0.0.0"));
            ds.setBroadcast(true);
            ds.send(packet);
            ds.setSoTimeout(2000);

            while(true) {
                String ip;
                String name;
                String mac;
                String status;
                do {
                    this.decipaddress = new int[200];
                    ds.receive(packet);
                    udpbyte = packet.getData();
                    ds.close();
                    new String(udpbyte);
                    ip = this.printer_ipaddress();
                    name = this.printer_name();
                    mac = this.printer_macaddress();
                    status = this.printer_status();
                } while(ip.equals("0.0.0.0"));

                for(int i = 0; i <= 150; ++i) {
                    int dec = udpbyte[i];
                    if (dec < 0) {
                        this.decipaddress[i] = 256 + dec;
                    }
                }

                String udpend = "END";
                get_NAME[counter] = name;
                get_IP[counter] = ip;
                get_MAC[counter] = mac;
                get_status[counter] = status;
                ++counter;
            }
        } catch (Exception var11) {
            if (counter > 0) {
                for(int i = 0; i <= 100; ++i) {
                    if (get_NAME[i] == null && get_IP[i] == null && get_MAC[i] == null && get_status[i] == null) {
                        this.UDP_NAME = new String[i];
                        this.UDP_IP = new String[i];
                        this.UDP_MAC = new String[i];
                        this.UDP_status = new String[i];

                        for(int j = 0; j <= i - 1; ++j) {
                            this.UDP_NAME[j] = get_NAME[j];
                            this.UDP_IP[j] = get_IP[j];
                            this.UDP_MAC[j] = get_MAC[j];
                            this.UDP_status[j] = get_status[j];
                        }

                        return;
                    }
                }

            }
        }
    }

    private void Discovery_UDP_Thread() {
        StrictMode.setThreadPolicy((new StrictMode.ThreadPolicy.Builder()).detectDiskReads().detectDiskWrites().detectNetwork().penaltyLog().build());
        StrictMode.setVmPolicy((new android.os.StrictMode.VmPolicy.Builder()).detectLeakedSqlLiteObjects().detectLeakedClosableObjects().penaltyLog().penaltyDeath().build());
        (new Thread() {
            public void run() {
                try {
                    BrotherWifiActivity.this.SendUDP();
                    DatagramPacket packet = new DatagramPacket(BrotherWifiActivity.this.udp_data, BrotherWifiActivity.this.udp_data.length);
                    packet.setAddress(InetAddress.getByName("255.255.255.255"));
                    packet.setPort(22368);
                    DatagramSocket socket = new DatagramSocket(22368, InetAddress.getByName("0.0.0.0"));
                    socket.setBroadcast(true);
                    socket.send(packet);
                    socket.setSoTimeout(1000);

                    while(true) {
                        String ip;
                        String name;
                        String mac;
                        String status;
                        do {
                            BrotherWifiActivity.this.decipaddress = new int[200];
                            socket.receive(packet);
                            BrotherWifiActivity.udpbyte = packet.getData();
                            socket.close();
                            new String(BrotherWifiActivity.udpbyte);
                            ip = BrotherWifiActivity.this.printer_ipaddress();
                            name = BrotherWifiActivity.this.printer_name();
                            mac = BrotherWifiActivity.this.printer_macaddress();
                            status = BrotherWifiActivity.this.printer_status();
                        } while(ip.equals("0.0.0.0"));

                        for(int ix = 0; ix <= 150; ++ix) {
                            int dec = BrotherWifiActivity.udpbyte[ix];
                            if (dec < 0) {
                                BrotherWifiActivity.this.decipaddress[ix] = 256 + dec;
                            }
                        }

                        String udpend = "END";
                        BrotherWifiActivity.get_NAME[BrotherWifiActivity.counter] = name;
                        BrotherWifiActivity.get_IP[BrotherWifiActivity.counter] = ip;
                        BrotherWifiActivity.get_MAC[BrotherWifiActivity.counter] = mac;
                        BrotherWifiActivity.get_status[BrotherWifiActivity.counter] = status;
                        BrotherWifiActivity.counter = BrotherWifiActivity.counter + 1;
                    }
                } catch (Exception var10) {
                    if (BrotherWifiActivity.counter > 0) {
                        for(int i = 0; i <= 100; ++i) {
                            if (BrotherWifiActivity.get_NAME[i] == null && BrotherWifiActivity.get_IP[i] == null && BrotherWifiActivity.get_MAC[i] == null && BrotherWifiActivity.get_status[i] == null) {
                                BrotherWifiActivity.this.UDP_NAME = new String[i];
                                BrotherWifiActivity.this.UDP_IP = new String[i];
                                BrotherWifiActivity.this.UDP_MAC = new String[i];
                                BrotherWifiActivity.this.UDP_status = new String[i];

                                for(int j = 0; j <= i - 1; ++j) {
                                    BrotherWifiActivity.this.UDP_NAME[j] = BrotherWifiActivity.get_NAME[j];
                                    BrotherWifiActivity.this.UDP_IP[j] = BrotherWifiActivity.get_IP[j];
                                    BrotherWifiActivity.this.UDP_MAC[j] = BrotherWifiActivity.get_MAC[j];
                                    BrotherWifiActivity.this.UDP_status[j] = BrotherWifiActivity.get_status[j];
                                }

                                return;
                            }
                        }

                    }
                }
            }
        }).start();
    }

    private String printer_ipaddress() {
        String ip = "";
        String singlebyte = "";

        for(int i = 0; i <= 3; ++i) {
            if (i == 1 || i == 2 || i == 3) {
                ip = ip + ".";
            }

            if (udpbyte[44 + i] < 0) {
                int integer = 256 + udpbyte[44 + i];
                singlebyte = new String("" + integer);
            } else {
                int integer = udpbyte[44 + i];
                singlebyte = new String("" + integer);
            }

            ip = ip + singlebyte;
            if (ip == "0.0.0.0") {
                return ip;
            }
        }

        return ip;
    }

    private String printer_name() {
        String name = "";
        String singlebyte = "";
        byte[] namebyte = new byte[16];

        for(int i = 0; i <= 15; ++i) {
            if (udpbyte[52 + i] < 0) {
                namebyte[i] = udpbyte[52 + i];
            } else {
                namebyte[i] = udpbyte[52 + i];
            }

            name = new String(namebyte);
        }

        return name;
    }

    private String printer_macaddress() {
        String mac = "";
        String singlebyte = "";

        for(int i = 0; i <= 5; ++i) {
            if (i == 1 || i == 2 || i == 3 || i == 4 || i == 5) {
                mac = mac + ":";
            }

            if (udpbyte[22 + i] < 0) {
                int integer = 256 + udpbyte[22 + i];
                singlebyte = Integer.toHexString(integer).toString().toUpperCase();
                if (singlebyte.length() < 2) {
                    singlebyte = "0" + singlebyte;
                }
            } else {
                int integer = udpbyte[22 + i];
                singlebyte = Integer.toHexString(integer).toString().toUpperCase();
                if (singlebyte.length() < 2) {
                    singlebyte = "0" + singlebyte;
                }
            }

            mac = mac + singlebyte;
        }

        return mac;
    }

    private String printer_status() {
        byte status = udpbyte[40];
        String printerstatus = String.valueOf(status);
        return printerstatus;
    }

    private String[] UDP_Name() {
        return this.UDP_NAME;
    }

    private String[] UDP_IP() {
        return this.UDP_IP;
    }

    private String[] UDP_Mac() {
        return this.UDP_MAC;
    }

    private String[] UDP_status() {
        return this.UDP_status;
    }

    private void SendUDP() {
        this.udp_data[0] = 0;
        this.udp_data[1] = 32;
        this.udp_data[2] = 0;
        this.udp_data[3] = 1;
        this.udp_data[4] = 0;
        this.udp_data[5] = 1;
        this.udp_data[6] = 8;
        this.udp_data[7] = 0;
        this.udp_data[8] = 0;
        this.udp_data[9] = 2;
        this.udp_data[10] = 0;
        this.udp_data[11] = 0;
        this.udp_data[12] = 0;
        this.udp_data[13] = 1;
        this.udp_data[14] = 0;
        this.udp_data[15] = 0;
        this.udp_data[16] = 1;
        this.udp_data[17] = 0;
        this.udp_data[18] = 0;
        this.udp_data[19] = 0;
        this.udp_data[20] = 0;
        this.udp_data[21] = 0;
        this.udp_data[22] = -1;
        this.udp_data[23] = -1;
        this.udp_data[24] = -1;
        this.udp_data[25] = -1;
        this.udp_data[26] = -1;
        this.udp_data[27] = -1;
        this.udp_data[28] = 0;
        this.udp_data[29] = 0;
        this.udp_data[30] = 0;
        this.udp_data[31] = 0;
    }

    private static void broadcast(int delay) {
        byte[] buf = new byte[256];
        byte[] TSCUDP = new byte[32];
        get_NAME = new String[100];
        get_IP = new String[100];
        get_MAC = new String[100];
        get_status = new String[100];
        TSCUDP[0] = 0;
        TSCUDP[1] = 32;
        TSCUDP[2] = 0;
        TSCUDP[3] = 1;
        TSCUDP[4] = 0;
        TSCUDP[5] = 1;
        TSCUDP[6] = 8;
        TSCUDP[7] = 0;
        TSCUDP[8] = 0;
        TSCUDP[9] = 2;
        TSCUDP[10] = 0;
        TSCUDP[11] = 0;
        TSCUDP[12] = 0;
        TSCUDP[13] = 2;
        TSCUDP[14] = 0;
        TSCUDP[15] = 0;
        TSCUDP[16] = 1;
        TSCUDP[17] = 0;
        TSCUDP[18] = 0;
        TSCUDP[19] = 0;
        TSCUDP[20] = 0;
        TSCUDP[21] = 0;
        TSCUDP[22] = -1;
        TSCUDP[23] = -1;
        TSCUDP[24] = -1;
        TSCUDP[25] = -1;
        TSCUDP[26] = -1;
        TSCUDP[27] = -1;
        TSCUDP[28] = 0;
        TSCUDP[29] = 0;
        TSCUDP[30] = 0;
        TSCUDP[31] = 0;
        DatagramSocket socket = null;
        InetAddress IPAddress = null;

        try {
            IPAddress = InetAddress.getByName("255.255.255.255");
        } catch (UnknownHostException var16) {
            var16.printStackTrace();
        }

        try {
            Thread.sleep((long)delay);
        } catch (InterruptedException var15) {
            var15.printStackTrace();
        }

        try {
            socket = new DatagramSocket(22368);
        } catch (SocketException var14) {
            var14.printStackTrace();
        }

        try {
            socket.setBroadcast(true);
        } catch (SocketException var13) {
            var13.printStackTrace();
        }

        DatagramPacket packet = new DatagramPacket(TSCUDP, TSCUDP.length, IPAddress, 22368);

        try {
            socket.send(packet);
        } catch (IOException var12) {
        }

        while(true) {
            DatagramPacket receive_packet = new DatagramPacket(udpbyte, udpbyte.length);

            try {
                socket.setSoTimeout(1000);
            } catch (SocketException var11) {
                var11.printStackTrace();
            }

            try {
                socket.receive(receive_packet);
                int broadcast_length = receive_packet.getLength();
                if (broadcast_length > 32) {
                    String ip = broadcast_ipaddress();
                    get_IP[counter] = ip;
                    new String(receive_packet.getData(), 0, receive_packet.getLength());
                    ++counter;
                }
            } catch (IOException var10) {
                return;
            }
        }
    }

    private static String broadcast_ipaddress() {
        String ip = "";
        String singlebyte = "";

        for(int i = 0; i <= 3; ++i) {
            if (i == 1 || i == 2 || i == 3) {
                ip = ip + ".";
            }

            if (udpbyte[44 + i] < 0) {
                int integer = 256 + udpbyte[44 + i];
                singlebyte = new String("" + integer);
            } else {
                int integer = udpbyte[44 + i];
                singlebyte = new String("" + integer);
            }

            ip = ip + singlebyte;
            if (ip == "0.0.0.0") {
                return ip;
            }
        }

        return ip;
    }

    private String windowsfont(int x_coordinates, int y_coordinates, int fontsize, Typeface typeface, String textToPrint) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        Paint paint = new Paint();
        paint.setStyle(Paint.Style.FILL);
        paint.setColor(-16777216);
        paint.setAntiAlias(true);
        paint.setTypeface(typeface);
        paint.setTextSize((float)fontsize);
        TextPaint textpaint = new TextPaint(paint);
        StaticLayout staticLayout = new StaticLayout(textToPrint, textpaint, 832, Layout.Alignment.ALIGN_NORMAL, 1.0F, 0.0F, false);
        int height = staticLayout.getHeight();
        int width = (int)Layout.getDesiredWidth(textToPrint, textpaint);
        if (height > 2378) {
            height = 2378;
        }

        try {
            original_bitmap = Bitmap.createBitmap(width + 8, height, Bitmap.Config.RGB_565);
            Canvas c = new Canvas(original_bitmap);
            c.drawColor(-1);
            c.translate(0.0F, 0.0F);
            staticLayout.draw(c);
        } catch (IllegalArgumentException var31) {
        } catch (OutOfMemoryError var32) {
        }

        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
        return "1";
    }

    private String windowsfont(int x_coordinates, int y_coordinates, Bitmap original_bitmap) {
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
        return "1";
    }

    private void sendpicture(int x_coordinates, int y_coordinates, String path) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var25) {
            var25.printStackTrace();
        } catch (SecurityException var26) {
            var26.printStackTrace();
        } catch (IllegalAccessException var27) {
            var27.printStackTrace();
        } catch (NoSuchFieldException var28) {
            var28.printStackTrace();
        }

        original_bitmap = BitmapFactory.decodeFile(path, options);
        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private void sendbitmap(int x_coordinates, int y_coordinates, Bitmap original_bitmap) {
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var24) {
            var24.printStackTrace();
        } catch (SecurityException var25) {
            var25.printStackTrace();
        } catch (IllegalAccessException var26) {
            var26.printStackTrace();
        } catch (NoSuchFieldException var27) {
            var27.printStackTrace();
        }

        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private void sendbitmap_resize(int x_coordinates, int y_coordinates, Bitmap original_bitmap, int resize_width, int resize_height) {
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var27) {
            var27.printStackTrace();
        } catch (SecurityException var28) {
            var28.printStackTrace();
        } catch (IllegalAccessException var29) {
            var29.printStackTrace();
        } catch (NoSuchFieldException var30) {
            var30.printStackTrace();
        }

        Bitmap resizedBitmap = Bitmap.createScaledBitmap(original_bitmap, resize_width, resize_height, false);
        gray_bitmap = this.bitmap2Gray(resizedBitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private void sendbitmap_gray_resize(int x_coordinates, int y_coordinates, Bitmap original_bitmap, int resize_width, int resize_height) {
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var28) {
            var28.printStackTrace();
        } catch (SecurityException var29) {
            var29.printStackTrace();
        } catch (IllegalAccessException var30) {
            var30.printStackTrace();
        } catch (NoSuchFieldException var31) {
            var31.printStackTrace();
        }

        Bitmap resizedBitmap = Bitmap.createScaledBitmap(original_bitmap, resize_width, resize_height, false);
        binary_bitmap = resizedBitmap;
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((resizedBitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(resizedBitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(resizedBitmap.getWidth() + 7) / 8 * resizedBitmap.getHeight()];
        int Width_bytes = (resizedBitmap.getWidth() + 7) / 8;
        int Width = resizedBitmap.getWidth();
        int Height = resizedBitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorA = Color.alpha(pixelColor);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (colorA != 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_color(int x_axis, int y_axis, File f1) throws FileNotFoundException
    {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                gray_bitmap = this.bitmap2Gray(bitmap);
                binary_bitmap = this.gray2Binary(gray_bitmap);
                String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(binary_bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
                int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
                int Width = binary_bitmap.getWidth();
                int Height = binary_bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (total == 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                this.sendcommand(command);
                this.sendcommand(stream);
                this.sendcommand("\r\n");
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var31) {
            var31.printStackTrace();
        }

        return bitmaps;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_color_resize(int x_axis, int y_axis, File f1, int resize_width, int resize_height) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                Bitmap resize_bitmap = Bitmap.createScaledBitmap(bitmap, resize_width, resize_height, false);
                page.render(resize_bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(resize_bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                gray_bitmap = this.bitmap2Gray(resize_bitmap);
                binary_bitmap = this.gray2Binary(gray_bitmap);
                String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(binary_bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
                int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
                int Width = binary_bitmap.getWidth();
                int Height = binary_bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (total == 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                this.sendcommand(command);
                this.sendcommand(stream);
                this.sendcommand("\r\n");
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var34) {
            var34.printStackTrace();
        }

        return bitmaps;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_color_save(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                gray_bitmap = this.bitmap2Gray(bitmap);
                binary_bitmap = this.gray2Binary(gray_bitmap);
                String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(binary_bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
                int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
                int Width = binary_bitmap.getWidth();
                int Height = binary_bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (total == 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                String filename = "document.txt";
                File sdcard = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
                File outfile = new File(sdcard, filename);
                FileOutputStream outStream = new FileOutputStream(outfile);
                byte[] bytes1 = command.getBytes(StandardCharsets.US_ASCII);
                byte[] bytes2 = "\r\n".getBytes(StandardCharsets.US_ASCII);
                outStream.write(bytes1);
                outStream.write(stream);
                outStream.write(bytes2);
                outStream.close();
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var31) {
            var31.printStackTrace();
        }

        return bitmaps;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_gray(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 2);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                binary_bitmap = bitmap;
                String picture_wdith = Integer.toString((bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(bitmap.getWidth() + 7) / 8 * bitmap.getHeight()];
                int Width_bytes = (bitmap.getWidth() + 7) / 8;
                int Width = bitmap.getWidth();
                int Height = bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (colorA != 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                this.sendcommand(command);
                this.sendcommand(stream);
                this.sendcommand("\r\n");
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var31) {
            var31.printStackTrace();
        }

        return bitmaps;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_gray_resize(int x_axis, int y_axis, File f1, int resize_width, int resize_height) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                Bitmap resize_bitmap = Bitmap.createScaledBitmap(bitmap, resize_width, resize_height, false);
                page.render(resize_bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(resize_bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                binary_bitmap = resize_bitmap;
                String picture_wdith = Integer.toString((resize_bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(resize_bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(resize_bitmap.getWidth() + 7) / 8 * resize_bitmap.getHeight()];
                int Width_bytes = (resize_bitmap.getWidth() + 7) / 8;
                int Width = resize_bitmap.getWidth();
                int Height = resize_bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (colorA != 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                this.sendcommand(command);
                this.sendcommand(stream);
                this.sendcommand("\r\n");
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var34) {
            var34.printStackTrace();
        }

        return bitmaps;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    private ArrayList<Bitmap> pdf_gray_save(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                PdfRenderer.Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Paint.Style.FILL);
                paint.setColor(-16777216);
                paint.setAntiAlias(true);
                binary_bitmap = bitmap;
                String picture_wdith = Integer.toString((bitmap.getWidth() + 7) / 8);
                String picture_height = Integer.toString(bitmap.getHeight());
                String mode = Integer.toString(0);
                String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
                byte[] stream = new byte[(bitmap.getWidth() + 7) / 8 * bitmap.getHeight()];
                int Width_bytes = (bitmap.getWidth() + 7) / 8;
                int Width = bitmap.getWidth();
                int Height = bitmap.getHeight();

                int y;
                for(y = 0; y < Height * Width_bytes; ++y) {
                    stream[y] = -1;
                }

                for(y = 0; y < Height; ++y) {
                    for(int x = 0; x < Width; ++x) {
                        int pixelColor = binary_bitmap.getPixel(x, y);
                        int colorA = Color.alpha(pixelColor);
                        int colorR = Color.red(pixelColor);
                        int colorG = Color.green(pixelColor);
                        int colorB = Color.blue(pixelColor);
                        int total = (colorR + colorG + colorB) / 3;
                        if (colorA != 0) {
                            stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                        }
                    }
                }

                String filename = "document.txt";
                File sdcard = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
                File outfile = new File(sdcard, filename);
                FileOutputStream outStream = new FileOutputStream(outfile);
                byte[] bytes1 = command.getBytes(StandardCharsets.US_ASCII);
                byte[] bytes2 = "\r\n".getBytes(StandardCharsets.US_ASCII);
                outStream.write(bytes1);
                outStream.write(stream);
                outStream.write(bytes2);
                outStream.close();
                return bitmaps;
            }

            renderer.close();
        } catch (Exception var31) {
            var31.printStackTrace();
        }

        return bitmaps;
    }

    private void sendpicture_halftone(int x_coordinates, int y_coordinates, String path) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var25) {
            var25.printStackTrace();
        } catch (SecurityException var26) {
            var26.printStackTrace();
        } catch (IllegalAccessException var27) {
            var27.printStackTrace();
        } catch (NoSuchFieldException var28) {
            var28.printStackTrace();
        }

        original_bitmap = BitmapFactory.decodeFile(path, options);
        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2halftone(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private void sendpicture_CPCL(int x_coordinates, int y_coordinates, String path) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var25) {
            var25.printStackTrace();
        } catch (SecurityException var26) {
            var26.printStackTrace();
        } catch (IllegalAccessException var27) {
            var27.printStackTrace();
        } catch (NoSuchFieldException var28) {
            var28.printStackTrace();
        }

        original_bitmap = BitmapFactory.decodeFile(path, options);
        gray_bitmap = this.bitmap2Gray(original_bitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "EG " + picture_wdith + " " + picture_height + " " + x_axis + " " + y_axis + " ";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = 0;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        String hex_to_string = byteArrayToHex(stream);
        this.sendcommand(command);
        this.sendcommand(hex_to_string.toUpperCase());
        this.sendcommand("\r\n");
    }

    private void sendpicture_resize(int x_coordinates, int y_coordinates, String path, int resize_width, int resize_height) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var28) {
            var28.printStackTrace();
        } catch (SecurityException var29) {
            var29.printStackTrace();
        } catch (IllegalAccessException var30) {
            var30.printStackTrace();
        } catch (NoSuchFieldException var31) {
            var31.printStackTrace();
        }

        original_bitmap = BitmapFactory.decodeFile(path, options);
        Bitmap resizedBitmap = Bitmap.createScaledBitmap(original_bitmap, resize_width, resize_height, false);
        gray_bitmap = this.bitmap2Gray(resizedBitmap);
        binary_bitmap = this.gray2Binary(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private void sendpicture_resize_halftone(int x_coordinates, int y_coordinates, String path, int resize_width, int resize_height) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Bitmap.Config.ARGB_8888;

        try {
            BitmapFactory.Options.class.getField("inNativeAlloc").setBoolean(options, true);
        } catch (IllegalArgumentException var28) {
            var28.printStackTrace();
        } catch (SecurityException var29) {
            var29.printStackTrace();
        } catch (IllegalAccessException var30) {
            var30.printStackTrace();
        } catch (NoSuchFieldException var31) {
            var31.printStackTrace();
        }

        original_bitmap = BitmapFactory.decodeFile(path, options);
        Bitmap resizedBitmap = Bitmap.createScaledBitmap(original_bitmap, resize_width, resize_height, false);
        gray_bitmap = this.bitmap2Gray(resizedBitmap);
        binary_bitmap = this.gray2halftone(gray_bitmap);
        String x_axis = Integer.toString(x_coordinates);
        String y_axis = Integer.toString(y_coordinates);
        String picture_wdith = Integer.toString((binary_bitmap.getWidth() + 7) / 8);
        String picture_height = Integer.toString(binary_bitmap.getHeight());
        String mode = Integer.toString(0);
        String command = "BITMAP " + x_axis + "," + y_axis + "," + picture_wdith + "," + picture_height + "," + mode + ",";
        byte[] stream = new byte[(binary_bitmap.getWidth() + 7) / 8 * binary_bitmap.getHeight()];
        int Width_bytes = (binary_bitmap.getWidth() + 7) / 8;
        int Width = binary_bitmap.getWidth();
        int Height = binary_bitmap.getHeight();

        int y;
        for(y = 0; y < Height * Width_bytes; ++y) {
            stream[y] = -1;
        }

        for(y = 0; y < Height; ++y) {
            for(int x = 0; x < Width; ++x) {
                int pixelColor = binary_bitmap.getPixel(x, y);
                int colorR = Color.red(pixelColor);
                int colorG = Color.green(pixelColor);
                int colorB = Color.blue(pixelColor);
                int total = (colorR + colorG + colorB) / 3;
                if (total == 0) {
                    stream[y * ((Width + 7) / 8) + x / 8] ^= (byte)(128 >> x % 8);
                }
            }
        }

        this.sendcommand(command);
        this.sendcommand(stream);
        this.sendcommand("\r\n");
    }

    private Bitmap bitmap2Gray(Bitmap bmSrc) {
        int width = bmSrc.getWidth();
        int height = bmSrc.getHeight();
        Bitmap bmpGray = null;
        bmpGray = Bitmap.createBitmap(width, height, Bitmap.Config.RGB_565);
        Canvas c = new Canvas(bmpGray);
        Paint paint = new Paint();
        ColorMatrix cm = new ColorMatrix();
        cm.setSaturation(0.0F);
        ColorMatrixColorFilter f = new ColorMatrixColorFilter(cm);
        paint.setColorFilter(f);
        c.drawBitmap(bmSrc, 0.0F, 0.0F, paint);
        return bmpGray;
    }

    private Bitmap lineGrey(Bitmap image) {
        int width = image.getWidth();
        int height = image.getHeight();
        Bitmap linegray = null;
        linegray = image.copy(Bitmap.Config.ARGB_8888, true);

        for(int i = 0; i < width; ++i) {
            for(int j = 0; j < height; ++j) {
                int col = image.getPixel(i, j);
                int alpha = col & -16777216;
                int red = (col & 16711680) >> 16;
                int green = (col & '\uff00') >> 8;
                int blue = col & 255;
                red = (int)(1.1D * (double)red + 30.0D);
                green = (int)(1.1D * (double)green + 30.0D);
                blue = (int)(1.1D * (double)blue + 30.0D);
                if (red >= 255) {
                    red = 255;
                }

                if (green >= 255) {
                    green = 255;
                }

                if (blue >= 255) {
                    blue = 255;
                }

                int newColor = alpha | red << 16 | green << 8 | blue;
                linegray.setPixel(i, j, newColor);
            }
        }

        return linegray;
    }

    private Bitmap gray2Binary(Bitmap graymap) {
        int width = graymap.getWidth();
        int height = graymap.getHeight();
        Bitmap binarymap = null;
        binarymap = graymap.copy(Bitmap.Config.ARGB_8888, true);

        for(int i = 0; i < width; ++i) {
            for(int j = 0; j < height; ++j) {
                int col = binarymap.getPixel(i, j);
                int alpha = col & -16777216;
                int red = (col & 16711680) >> 16;
                int green = (col & '\uff00') >> 8;
                int blue = col & 255;
                int gray = (int)((double)((float)red) * 0.3D + (double)((float)green) * 0.59D + (double)((float)blue) * 0.11D);
                //short gray;
                if (gray <= 127) {
                    gray = 0;
                } else {
                    gray = 255;
                }

                int newColor = alpha | gray << 16 | gray << 8 | gray;
                binarymap.setPixel(i, j, newColor);
            }
        }

        return binarymap;
    }

    private Bitmap gray2halftone(Bitmap graymap) {
        int width = graymap.getWidth();
        int height = graymap.getHeight();
        Bitmap binarymap = null;
        binarymap = graymap.copy(Bitmap.Config.ARGB_8888, true);

        for(int i = 0; i < width - 1; i += 2) {
            for(int j = 0; j < height - 1; j += 2) {
                int col = binarymap.getPixel(i, j);
                int alpha = col & -16777216;
                int red = (col & 16711680) >> 16;
                int green = (col & '\uff00') >> 8;
                int blue = col & 255;
                int gray1 = (int)((double)((float)red) * 0.3D + (double)((float)green) * 0.59D + (double)((float)blue) * 0.11D);
                col = binarymap.getPixel(i + 1, j);
                alpha = col & -16777216;
                red = (col & 16711680) >> 16;
                green = (col & '\uff00') >> 8;
                blue = col & 255;
                int gray2 = (int)((double)((float)red) * 0.3D + (double)((float)green) * 0.59D + (double)((float)blue) * 0.11D);
                col = binarymap.getPixel(i, j + 1);
                alpha = col & -16777216;
                red = (col & 16711680) >> 16;
                green = (col & '\uff00') >> 8;
                blue = col & 255;
                int gray3 = (int)((double)((float)red) * 0.3D + (double)((float)green) * 0.59D + (double)((float)blue) * 0.11D);
                col = binarymap.getPixel(i + 1, j + 1);
                alpha = col & -16777216;
                red = (col & 16711680) >> 16;
                green = (col & '\uff00') >> 8;
                blue = col & 255;
                int gray4 = (int)((double)((float)red) * 0.3D + (double)((float)green) * 0.59D + (double)((float)blue) * 0.11D);
                int helftone = 1020 - (gray1 + gray2 + gray3 + gray4);
                int whiteColor = -1;
                int blackColor = 0;
                if (helftone <= 204) {
                    binarymap.setPixel(i, j, whiteColor);
                    binarymap.setPixel(i + 1, j, whiteColor);
                    binarymap.setPixel(i, j + 1, whiteColor);
                    binarymap.setPixel(i + 1, j + 1, whiteColor);
                } else if (helftone <= 408) {
                    binarymap.setPixel(i, j, whiteColor);
                    binarymap.setPixel(i + 1, j, whiteColor);
                    binarymap.setPixel(i, j + 1, whiteColor);
                    binarymap.setPixel(i + 1, j + 1, blackColor);
                } else if (helftone <= 612) {
                    binarymap.setPixel(i, j, whiteColor);
                    binarymap.setPixel(i + 1, j, blackColor);
                    binarymap.setPixel(i, j + 1, blackColor);
                    binarymap.setPixel(i + 1, j + 1, whiteColor);
                } else if (helftone <= 816) {
                    binarymap.setPixel(i, j, whiteColor);
                    binarymap.setPixel(i + 1, j, blackColor);
                    binarymap.setPixel(i, j + 1, blackColor);
                    binarymap.setPixel(i + 1, j + 1, blackColor);
                } else {
                    binarymap.setPixel(i, j, blackColor);
                    binarymap.setPixel(i + 1, j, blackColor);
                    binarymap.setPixel(i, j + 1, blackColor);
                    binarymap.setPixel(i + 1, j + 1, blackColor);
                }
            }
        }

        return binarymap;
    }

    private static String byteArrayToHex(byte[] a) {
        StringBuilder sb = new StringBuilder(a.length * 2);
        byte[] var5 = a;
        int var4 = a.length;

        for(int var3 = 0; var3 < var4; ++var3) {
            byte b = var5[var3];
            sb.append(String.format("%02x", b & 255));
        }

        return sb.toString();
    }

    private String WiFi_Default() {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 82};
            String default_command = "WLAN DEFAULT\r\n";
            this.sendcommand(default_command);
            this.sendcommand(message);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_SSID(String SSID) {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN SSID \"" + SSID + "\"\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_WPA(String WPA) {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN WPA \"" + WPA + "\"\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_WEP(int number, String WEP) {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN WEP " + Integer.toString(number) + "," + "\"" + WEP + "\"\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_DHCP() {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN DHCP\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_Port(int port) {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN PORT " + Integer.toString(port) + "\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String WiFi_StaticIP(String ip, String mask, String gateway) {
        if (this.OutStream != null && this.InStream != null) {
            String command = "WLAN IP \"" + ip + "\"" + "," + "\"" + mask + "\"" + "," + "\"" + gateway + "\"\r\n";
            this.sendcommand(command);
            return "1";
        } else {
            return "-1";
        }
    }

    private String NFC_Read_data(int delay) {
        this.readBuf = new byte[1024];
        this.sendcommand("NFC MODE OFF\r\n");
        this.sendcommand("NFC READ\r\n");

        try {
            Thread.sleep((long)delay);
        } catch (InterruptedException var3) {
            var3.printStackTrace();
        }

        try {
            if (this.InStream.available() > 0) {
                int var2 = this.InStream.read(this.readBuf);
            }
        } catch (IOException var4) {
            return "-1";
        }

        String nfcdata = new String(this.readBuf);
        return nfcdata;
    }

    private int NFC_Write_data(String data) {
        this.sendcommand("NFC MODE OFF\r\n");
        this.sendcommand("NFC WRITE \"" + data + "\"" + "\r\n");
        return 1;
    }

    private int NFC_Timeout(int delay) {
        this.sendcommand("NFC TIMEOUT " + delay + "\r\n");
        return 1;
    }
}
