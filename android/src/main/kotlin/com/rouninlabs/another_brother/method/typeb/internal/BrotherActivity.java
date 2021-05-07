package com.rouninlabs.another_brother.method.typeb.internal;

//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
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
import android.graphics.Bitmap.Config;
import android.graphics.BitmapFactory.Options;
import android.graphics.Paint.Style;
import android.graphics.pdf.PdfRenderer;
import android.graphics.pdf.PdfRenderer.Page;
import android.os.Build;
import android.os.Environment;
import android.os.ParcelFileDescriptor;
import android.text.Layout;
import android.text.StaticLayout;
import android.text.TextPaint;
import android.text.Layout.Alignment;
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
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Set;
import java.util.UUID;

import androidx.annotation.RequiresApi;

public class BrotherActivity extends Activity {
    private static final String TAG = "THINBTCLIENT";
    private static final boolean D = true;
    private BluetoothAdapter mBluetoothAdapter = null;
    private BluetoothSocket btSocket = null;
    private OutputStream OutStream = null;
    private InputStream InStream = null;
    private byte[] buffer = new byte[1024];
    private static byte[] readBuf = new byte[1024];
    private String printerstatus = "";
    public boolean IsConnected = false;
    private int write_success = 0;
    private int readlength = 0;
    private String CRLF = "\r\n";
    private static String receive_data = "";
    private TextView test1;
    private Button b1;
    private Button b2;
    private Button b3;
    private static final UUID MY_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    private static String address = "00:19:0E:A0:04:E1";

    public BrotherActivity() {
    }

    public String openport(String address) {
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = null;
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        InputStream tmpIn = null;
        OutputStream tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(address);

            try {
                this.btSocket = device.createRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var8) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
                return "1";
            } catch (IOException var7) {
                return "-1";
            }
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    public String closeport() {
        try {
            Thread.sleep(1500L);
        } catch (InterruptedException var4) {
        }

        if (this.btSocket.isConnected()) {
            try {
                this.IsConnected = false;
                this.btSocket.close();
            } catch (IOException var3) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var2) {
            }

            return "1";
        } else {
            return "-1";
        }
    }

    public String closeport(int timeout) {
        try {
            Thread.sleep((long)timeout);
        } catch (InterruptedException var5) {
            var5.printStackTrace();
        }

        if (this.btSocket.isConnected()) {
            try {
                this.IsConnected = false;
                this.btSocket.close();
            } catch (IOException var4) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var3) {
                var3.printStackTrace();
            }

            return "1";
        } else {
            return "-1";
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
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var15) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String clearbuffer() {
        String message = "CLS\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String barcode(int x, int y, String type, int height, int human_readable, int rotation, int narrow, int wide, String string) {
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
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var22) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String printerfont(int x, int y, String size, int rotation, int x_multiplication, int y_multiplication, String string) {
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
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var18) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String sendcommand(String message) {
        byte[] msgBuffer = message.getBytes();

        try {
            this.OutStream.write(msgBuffer);
            return "1";
        } catch (IOException var4) {
            return "-1";
        }
    }

    public String printlabel(int quantity, int copy) {
        String message = "";
        message = "PRINT " + quantity + ", " + copy + "\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var6) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String windowsfont(int x_coordinates, int y_coordinates, int fontsize, String path, String textToPrint) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        Paint paint = new Paint();
        paint.setStyle(Style.FILL);
        paint.setColor(-16777216);
        paint.setAntiAlias(true);
        Typeface typeface = Typeface.createFromFile(path);
        paint.setTypeface(typeface);
        paint.setTextSize((float)fontsize);
        TextPaint textpaint = new TextPaint(paint);
        StaticLayout staticLayout = new StaticLayout(textToPrint, textpaint, 832, Alignment.ALIGN_NORMAL, 1.0F, 0.0F, false);
        int height = staticLayout.getHeight();
        int width = (int)Layout.getDesiredWidth(textToPrint, textpaint);
        if (height > 2378) {
            height = 2378;
        }

        try {
            original_bitmap = Bitmap.createBitmap(width + 8, height, Config.RGB_565);
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
        if (this.OutStream != null && this.InStream != null) {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                //FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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
        } else {
            return "-1";
        }
    }

    public String downloadbmp(Context context, String filename) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);

                //FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);

                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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
        } else {
            return "-1";
        }
    }

    public String downloadttf(Context context, String filename) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
                File downloadFile = new File(downloadFolder, filename);
                FileInputStream fis = new FileInputStream(downloadFile);
                //FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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
        } else {
            return "-1";
        }
    }

    public String formfeed() {
        String message = "";
        message = "FORMFEED\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String nobackfeed() {
        String message = "";
        message = "SET TEAR OFF\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String sendfile(String filename) {
        try {
            FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
            byte[] data = new byte[fis.available()];
            int[] var4 = new int[data.length];

            while(fis.read(data) != -1) {
            }

            this.OutStream.write(data);
            fis.close();
            return "1";
        } catch (Exception var5) {
            return "-1";
        }
    }

    public String printerstatus(int delay) {
        byte[] message = new byte[]{27, 33, 63};
        String query = "";
        int length = 0;
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
            } catch (IOException var7) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    length = this.InStream.read(readBuf);
                }
            } catch (IOException var8) {
                return "-1";
            }

            if (length == 0) {
                return "";
            } else {
                if (readBuf[0] == 0) {
                    query = "00";
                } else if (readBuf[0] == 1) {
                    query = "01";
                } else if (readBuf[0] == 2) {
                    query = "02";
                } else if (readBuf[0] == 3) {
                    query = "03";
                } else if (readBuf[0] == 4) {
                    query = "04";
                } else if (readBuf[0] == 5) {
                    query = "05";
                } else if (readBuf[0] == 8) {
                    query = "08";
                } else if (readBuf[0] == 9) {
                    query = "09";
                } else if (readBuf[0] == 10) {
                    query = "0A";
                } else if (readBuf[0] == 11) {
                    query = "0B";
                } else if (readBuf[0] == 12) {
                    query = "0C";
                } else if (readBuf[0] == 13) {
                    query = "0D";
                } else if (readBuf[0] == 16) {
                    query = "10";
                } else if (readBuf[0] == 32) {
                    query = "20";
                } else if (readBuf[0] == 128) {
                    query = "80";
                }

                return query;
            }
        } else {
            return "-1";
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

    public String printPDFbyPath(Context context, String filename, int x_coordinates, int y_coordinates, int printer_dpi) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);

            //File file = new File(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
            if (!filename.toLowerCase().endsWith(".pdf")) {
                return "-1";
            } else {
                PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
                int PageCount = mPdfRenderer.getPageCount();

                for(int idx = 0; idx < PageCount; ++idx) {
                    Page page = mPdfRenderer.openPage(idx);
                    int width = page.getWidth() * printer_dpi / 72;
                    int height = page.getHeight() * printer_dpi / 72;
                    Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                    Canvas canvas = new Canvas(bitmap);
                    canvas.drawColor(-1);
                    canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                    page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                    page.close();
                    this.sendcommand("CLS\r\n");
                    this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                    Thread.sleep(1000L);
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

    public String printPDFbyPath(Context context, String filename, int x_coordinates, int y_coordinates, int printer_dpi, int page_index) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);
            //File file = new File(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
            if (filename.toLowerCase().endsWith(".pdf")) {
                PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
                int PageCount = mPdfRenderer.getPageCount();
                int idx = page_index - 1;
                if (idx >= 0 && idx < PageCount) {
                    Page page = mPdfRenderer.openPage(idx);
                    int width = page.getWidth() * printer_dpi / 72;
                    int height = page.getHeight() * printer_dpi / 72;
                    Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                    Canvas canvas = new Canvas(bitmap);
                    canvas.drawColor(-1);
                    canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                    page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                    page.close();
                    this.sendcommand("CLS\r\n");
                    this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                    Thread.sleep(1000L);
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

    public int getPDFPageCountbyPath(Context context, String filename) {
        try {
            File downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS);
            File file = new File(downloadFolder, filename);

            //File file = new File(Environment.getExternalStorageDirectory().getPath() + "/Download/" + filename);
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

    public String printPDFbyFile(File file, int x_coordinates, int y_coordinates, int printer_dpi) {
        try {
            PdfRenderer mPdfRenderer = new PdfRenderer(ParcelFileDescriptor.open(file, 268435456));
            int PageCount = mPdfRenderer.getPageCount();

            for(int idx = 0; idx < PageCount; ++idx) {
                Page page = mPdfRenderer.openPage(idx);
                int width = page.getWidth() * printer_dpi / 72;
                int height = page.getHeight() * printer_dpi / 72;
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                Canvas canvas = new Canvas(bitmap);
                canvas.drawColor(-1);
                canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                page.close();
                this.sendcommand("CLS\r\n");
                this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                Thread.sleep(1000L);
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
                Page page = mPdfRenderer.openPage(idx);
                int width = page.getWidth() * printer_dpi / 72;
                int height = page.getHeight() * printer_dpi / 72;
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                Canvas canvas = new Canvas(bitmap);
                canvas.drawColor(-1);
                canvas.drawBitmap(bitmap, 0.0F, 0.0F, (Paint)null);
                page.render(bitmap, new Rect(0, 0, width, height), (Matrix)null, 1);
                page.close();
                this.sendcommand("CLS\r\n");
                this.sendbitmap(x_coordinates, y_coordinates, bitmap);
                Thread.sleep(1000L);
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

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
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

    private static String getHexString(byte[] b) throws Exception {
        String result = "";

        for(int i = 0; i < b.length; ++i) {
            result = result + Integer.toString((b[i] & 255) + 256, 16).substring(1);
        }

        return result;
    }

    private void detect_bluetooth() {
    }

    private String openport(String address, int delay) {
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = null;
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        InputStream tmpIn = null;
        OutputStream tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(address);

            try {
                this.btSocket = device.createRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var10) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
            } catch (IOException var9) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            return "1";
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    private String openport_with_pair() {
        String BTMAC = "";
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> pairedDevices = mBluetoothAdapter.getBondedDevices();
        Iterator tmpOut = pairedDevices.iterator();
        BluetoothDevice tmpIn;
        if (tmpOut.hasNext()) {
            tmpIn = (BluetoothDevice)tmpOut.next();
            BTMAC = tmpIn.getAddress();
        }

        tmpIn = null;
        tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(BTMAC);

            try {
                this.btSocket = device.createRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var9) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
                return "1";
            } catch (IOException var8) {
                return "-1";
            }
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    private String openport_with_pair(int delay) {
        String BTMAC = "";
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> pairedDevices = mBluetoothAdapter.getBondedDevices();
        Iterator tmpOut = pairedDevices.iterator();
        BluetoothDevice tmpIn;
        if (tmpOut.hasNext()) {
            tmpIn = (BluetoothDevice)tmpOut.next();
            BTMAC = tmpIn.getAddress();
        }

        tmpIn = null;
        tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(BTMAC);

            try {
                this.btSocket = device.createRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var11) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
            } catch (IOException var10) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var9) {
                var9.printStackTrace();
            }

            return "1";
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    private String openport_onpair_btname(String btname) {
        BluetoothAdapter mbtdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> pairedDevices = mbtdapter.getBondedDevices();
        Iterator var5 = pairedDevices.iterator();

        while(var5.hasNext()) {
            BluetoothDevice device = (BluetoothDevice)var5.next();
            if (btname.equals(device.getName())) {
                this.openport(device.getAddress());
            }
        }

        return "Not Found";
    }

    private String openport_onpair_btname(String btname, int delay) {
        BluetoothAdapter mbtdapter = BluetoothAdapter.getDefaultAdapter();
        Set<BluetoothDevice> pairedDevices = mbtdapter.getBondedDevices();
        Iterator var6 = pairedDevices.iterator();

        while(var6.hasNext()) {
            BluetoothDevice device = (BluetoothDevice)var6.next();
            if (btname.equals(device.getName())) {
                this.openport(device.getAddress(), delay);
            }
        }

        return "Not Found";
    }

    private String openport_without_security(String address) {
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = null;
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        InputStream tmpIn = null;
        OutputStream tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(address);

            try {
                this.btSocket = device.createInsecureRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var8) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
                return "1";
            } catch (IOException var7) {
                return "-1";
            }
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    private String openport_without_security(String address, int delay) {
        BluetoothDevice device = null;
        BluetoothAdapter mBluetoothAdapter = null;
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        InputStream tmpIn = null;
        OutputStream tmpOut = null;
        if (mBluetoothAdapter.isEnabled()) {
            this.IsConnected = true;
            device = mBluetoothAdapter.getRemoteDevice(address);

            try {
                this.btSocket = device.createInsecureRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException var10) {
                return "-1";
            }

            mBluetoothAdapter.cancelDiscovery();

            try {
                this.btSocket.connect();
                this.OutStream = this.btSocket.getOutputStream();
                this.InStream = this.btSocket.getInputStream();
            } catch (IOException var9) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            return "1";
        } else {
            this.detect_bluetooth();
            this.IsConnected = false;
            return "-1";
        }
    }

    private String sendcommand_getstring(String message) {
        readBuf = new byte[1024];
        String end_judge = "OUT \"ENDLINE\"\r\n";
        byte[] msgBuffer = message.getBytes();
        byte[] msgBuffer1 = "\r\n".getBytes();
        byte[] msgBuffer2 = end_judge.getBytes();

        try {
            this.OutStream.write(msgBuffer);
            this.OutStream.write(msgBuffer1);
            this.OutStream.write(msgBuffer2);
        } catch (IOException var7) {
            return "-1";
        }

        try {
            while(!this.ReadStream_judge()) {
            }
        } catch (Exception var8) {
            return "-1";
        }

        return receive_data;
    }

    private String sendcommand_getstring(String message, int timer) {
        readBuf = new byte[1024];
        String end_judge = "OUT \"ENDLINE\"\r\n";
        byte[] msgBuffer = message.getBytes();
        byte[] msgBuffer1 = "\r\n".getBytes();
        byte[] msgBuffer2 = end_judge.getBytes();

        try {
            this.OutStream.write(msgBuffer);
            this.OutStream.write(msgBuffer1);
            this.OutStream.write(msgBuffer2);
        } catch (IOException var8) {
            return "-1";
        }

        while(!this.ReadStream_judge(timer)) {
        }

        return receive_data;
    }

    private String sendcommand(String message, int timer) {
        byte[] msgBuffer = message.getBytes();

        try {
            Thread.sleep((long)timer);
        } catch (InterruptedException var6) {
            var6.printStackTrace();
        }

        try {
            this.OutStream.write(msgBuffer);
            return "1";
        } catch (IOException var5) {
            return "-1";
        }
    }

    private String sendcommandUTF8(String message) {
        if (this.OutStream != null && this.InStream != null) {
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
        } else {
            return "-1";
        }
    }

    private String sendcommandBig5(String message) {
        if (this.OutStream != null && this.InStream != null) {
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
        } else {
            return "-1";
        }
    }

    private String sendcommandGB2312(String message) {
        if (this.OutStream != null && this.InStream != null) {
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
        } else {
            return "-1";
        }
    }

    private String sendcommandGB2312(String message, int timer) {
        if (this.OutStream != null && this.InStream != null) {
            byte[] msgBuffer = null;

            try {
                msgBuffer = message.getBytes("GB2312");
            } catch (UnsupportedEncodingException var7) {
                var7.printStackTrace();
            }

            try {
                Thread.sleep((long)timer);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                this.OutStream.write(msgBuffer);
                return "1";
            } catch (IOException var5) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    public String sendcommand(byte[] message) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
                return "1";
            } catch (IOException var3) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String sendcommand(byte[] message, int timer) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                Thread.sleep((long)timer);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                this.OutStream.write(message);
                return "1";
            } catch (IOException var4) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String status() {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 83};
            readBuf = new byte[1024];
            String printername = "";
            printername = this.printername(200);
            if (printername == "") {
                return "-1";
            } else {
                try {
                    this.OutStream.write(message);
                } catch (IOException var5) {
                    return "-1";
                }

                try {
                    Thread.sleep(300L);
                } catch (InterruptedException var4) {
                    var4.printStackTrace();
                }

                int tim;
                try {
                    while(this.InStream.available() > 0) {
                        tim = this.InStream.read(readBuf);
                    }
                } catch (IOException var6) {
                    return "-1";
                }

                if (readBuf[0] == 2 && readBuf[5] == 3) {
                    for(tim = 0; tim <= 7; ++tim) {
                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ready";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 72 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Jam";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 68 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Empty";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "No Paper";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 66 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Jam";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Empty";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 67 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Cutting";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 75 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Press Print Key";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 76 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Take Label";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 80 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Printing Batch";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 96 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            readBuf = new byte[1024];
                            break;
                        }
                    }
                }

                return this.printerstatus;
            }
        } else {
            return "-1";
        }
    }

    private String status(int delay) {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 83};
            readBuf = new byte[1024];

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
                    readBuf = new byte[1024];
                    tim = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            if (readBuf[0] == 2 && readBuf[5] == 3) {
                for(tim = 0; tim <= 7; ++tim) {
                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ready";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Head Open";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 72 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Jam";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 68 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Ribbon Empty";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "No Paper";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 66 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Jam";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Paper Empty";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 67 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Cutting";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 75 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Press Print Key";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 76 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Waiting to Take Label";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 80 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Printing Batch";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 96 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        readBuf = new byte[1024];
                        break;
                    }

                    if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                        this.printerstatus = "Pause";
                        readBuf = new byte[1024];
                        break;
                    }
                }
            }

            return this.printerstatus;
        } else {
            return "-1";
        }
    }

    private String status(int delay1, int delay2) {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 83};
            readBuf = new byte[1024];
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
                        readBuf = new byte[1024];
                        tim = this.InStream.read(readBuf);
                    }
                } catch (IOException var9) {
                    return "-1";
                }

                if (readBuf[0] == 2 && readBuf[5] == 3) {
                    for(tim = 0; tim <= 7; ++tim) {
                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ready";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 64 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 96 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Head Open";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 72 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Jam";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 68 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Ribbon Empty";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "No Paper";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 66 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Jam";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 65 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Paper Empty";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 67 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Cutting";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 75 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Press Print Key";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 76 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Waiting to Take Label";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 80 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Printing Batch";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 96 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            readBuf = new byte[1024];
                            break;
                        }

                        if (readBuf[tim] == 2 && readBuf[tim + 1] == 69 && readBuf[tim + 2] == 64 && readBuf[tim + 3] == 64 && readBuf[tim + 4] == 64 && readBuf[tim + 5] == 3) {
                            this.printerstatus = "Pause";
                            readBuf = new byte[1024];
                            break;
                        }
                    }
                }

                return this.printerstatus;
            }
        } else {
            return "-1";
        }
    }

    private String printer_completestatus() {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 83};

            try {
                this.OutStream.write(message);
            } catch (IOException var5) {
                return "-1";
            }

            try {
                Thread.sleep(300L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() <= 0) {
                }

                readBuf = new byte[1024];
                int length = this.InStream.read(readBuf);
                if (length > 0) {
                    String completestatus = new String(readBuf, 1, 4);
                    return completestatus;
                } else {
                    return "-1";
                }
            } catch (IOException var6) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String printer_completestatus(int delaytime) {
        if (this.OutStream != null && this.InStream != null) {
            byte[] message = new byte[]{27, 33, 83};

            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                return "-1";
            }

            try {
                Thread.sleep((long)delaytime);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() <= 0) {
                }

                readBuf = new byte[1024];
                int length = this.InStream.read(readBuf);
                if (length > 0) {
                    String completestatus = new String(readBuf, 1, 4);
                    return completestatus;
                } else {
                    return "-1";
                }
            } catch (IOException var7) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private String batch() {
        //int printvalue = false;
        String printbatch = "";
        String stringbatch = "";
        String message = "~HS";
        byte[] batcharray = new byte[8];
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var9) {
                Log.e("THINBTCLIENT", "ON RESUME: Exception during write.", var9);
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    readBuf = new byte[1024];
                    int var7 = this.InStream.read(readBuf);
                }
            } catch (IOException var10) {
                var10.printStackTrace();
            }

            if (readBuf[0] == 2) {
                System.arraycopy(readBuf, 55, batcharray, 0, 8);
                stringbatch = new String(batcharray);
                int printvalue = Integer.parseInt(stringbatch);
                printbatch = Integer.toString(printvalue);
            }

            return printbatch;
        } else {
            return "-1";
        }
    }

    private boolean ReadStream_judge() {
        receive_data = "";

        do {
            try {
                Thread.sleep(300L);
            } catch (InterruptedException var2) {
                var2.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int length = this.InStream.read(readBuf);
                    receive_data = receive_data + new String(readBuf);
                }
            } catch (IOException var3) {
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
            } catch (InterruptedException var3) {
                var3.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int length = this.InStream.read(readBuf);
                    receive_data = receive_data + new String(readBuf);
                }
            } catch (IOException var4) {
                return false;
            }
        } while(!receive_data.contains("ENDLINE\r\n"));

        receive_data = receive_data.replace("ENDLINE\r\n", "");
        return true;
    }

    private String printername() {
        String message = "~!T";
        byte[] batcharray = new byte[8];
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var6) {
                return "-1";
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String name = new String(readBuf);
            return name;
        } else {
            return "-1";
        }
    }

    private String printername(int delay) {
        String message = "~!T";
        byte[] batcharray = new byte[8];
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var7) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var6) {
                var6.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var5 = this.InStream.read(readBuf);
                }
            } catch (IOException var8) {
                return "-1";
            }

            String name = new String(readBuf);
            return name;
        } else {
            return "-1";
        }
    }

    private String printermemory() {
        String message = "~!A";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var3 = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String memory = new String(readBuf);
            return memory;
        } else {
            return "-1";
        }
    }

    private String printermemory(int delay) {
        String message = "~!A";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String memory = new String(readBuf);
            return memory;
        } else {
            return "-1";
        }
    }

    private String printermileage() {
        String message = "~!@";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var3 = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String mileage = new String(readBuf);
            return mileage;
        } else {
            return "-1";
        }
    }

    private String printermileage(int delay) {
        String message = "~!@";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String mileage = new String(readBuf);
            return mileage;
        } else {
            return "-1";
        }
    }

    private String printercodepage() {
        String message = "~!I";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var3 = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            String codepage = new String(readBuf);
            return codepage;
        } else {
            return "-1";
        }
    }

    private String printercodepage(int delay) {
        String message = "~!I";
        byte[] msgBuffer = message.getBytes();
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            String codepage = new String(readBuf);
            return codepage;
        } else {
            return "-1";
        }
    }

    private String printerfile() {
        String message = "~!F";
        readBuf = new byte[1024];
        this.buffer = new byte[1024];
        byte[] buffer2 = new byte[1024];
        int last_bytes = 0;
        //int bytes = false;
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var8) {
                return "-1";
            }

            try {
                Thread.sleep(2000L);
            } catch (InterruptedException var7) {
                var7.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int bytes = this.InStream.read(readBuf);
                    if (bytes >= 0) {
                        this.buffer = readBuf;
                        System.arraycopy(this.buffer, 0, buffer2, last_bytes, bytes);
                    }

                    this.buffer = new byte[1024];
                    last_bytes = bytes;
                    readBuf = buffer2;
                }
            } catch (IOException var9) {
                return "-1";
            }

            String files = new String(readBuf);
            return files;
        } else {
            return "-1";
        }
    }

    private String printerfile(int delay) {
        String message = "~!F";
        readBuf = new byte[1024];
        this.buffer = new byte[1024];
        byte[] buffer2 = new byte[1024];
        int last_bytes = 0;
        //int bytes = false;
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(msgBuffer);
            } catch (IOException var9) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var8) {
                var8.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int bytes = this.InStream.read(readBuf);
                    if (bytes >= 0) {
                        this.buffer = readBuf;
                        System.arraycopy(this.buffer, 0, buffer2, last_bytes, bytes);
                    }

                    this.buffer = new byte[1024];
                    last_bytes = bytes;
                    readBuf = buffer2;
                }
            } catch (IOException var10) {
                return "-1";
            }

            String files = new String(readBuf);
            return files;
        } else {
            return "-1";
        }
    }

    private String restart() {
        byte[] message = new byte[]{27, 33, 82};
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
                return "1";
            } catch (IOException var3) {
                return "-1";
            }
        } else {
            return "-1";
        }
    }

    private byte printerstatus_byte() {
        byte[] message = new byte[]{27, 33, 63};
        String query = "";
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
            } catch (IOException var5) {
                return -1;
            }

            try {
                Thread.sleep(1000L);
            } catch (InterruptedException var4) {
                var4.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var3 = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                readBuf[0] = -1;
            }

            return readBuf[0];
        } else {
            return -1;
        }
    }

    private byte printerstatus_byte(int delay) {
        byte[] message = new byte[]{27, 33, 63};
        String query = "";
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                return -1;
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                readBuf[0] = -1;
            }

            return readBuf[0];
        } else {
            return -1;
        }
    }

    private String queryprinter() {
        byte[] message = new byte[]{27, 33, 63};
        String query = "";
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
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
                while(this.InStream.available() > 0) {
                    int var3 = this.InStream.read(readBuf);
                }
            } catch (IOException var6) {
                return "-1";
            }

            if (readBuf[0] == 0) {
                query = "0";
            } else if (readBuf[0] == 1) {
                query = "1";
            } else if (readBuf[0] == 2) {
                query = "2";
            } else if (readBuf[0] == 3) {
                query = "3";
            } else if (readBuf[0] == 4) {
                query = "4";
            } else if (readBuf[0] == 5) {
                query = "5";
            } else if (readBuf[0] == 8) {
                query = "8";
            } else if (readBuf[0] == 9) {
                query = "9";
            } else if (readBuf[0] == 10) {
                query = "A";
            } else if (readBuf[0] == 11) {
                query = "B";
            } else if (readBuf[0] == 12) {
                query = "C";
            } else if (readBuf[0] == 13) {
                query = "D";
            } else if (readBuf[0] == 16) {
                query = "10";
            } else if (readBuf[0] == 32) {
                query = "20";
            } else if (readBuf[0] == 128) {
                query = "80";
            }

            return query;
        } else {
            return "-1";
        }
    }

    private String queryprinter(int delay) {
        byte[] message = new byte[]{27, 33, 63};
        String query = "";
        readBuf = new byte[1024];
        if (this.OutStream != null && this.InStream != null) {
            try {
                this.OutStream.write(message);
            } catch (IOException var6) {
                return "-1";
            }

            try {
                Thread.sleep((long)delay);
            } catch (InterruptedException var5) {
                var5.printStackTrace();
            }

            try {
                while(this.InStream.available() > 0) {
                    int var4 = this.InStream.read(readBuf);
                }
            } catch (IOException var7) {
                return "-1";
            }

            if (readBuf[0] == 0) {
                query = "0";
            } else if (readBuf[0] == 1) {
                query = "1";
            } else if (readBuf[0] == 2) {
                query = "2";
            } else if (readBuf[0] == 3) {
                query = "3";
            } else if (readBuf[0] == 4) {
                query = "4";
            } else if (readBuf[0] == 5) {
                query = "5";
            } else if (readBuf[0] == 8) {
                query = "8";
            } else if (readBuf[0] == 9) {
                query = "9";
            } else if (readBuf[0] == 10) {
                query = "A";
            } else if (readBuf[0] == 11) {
                query = "B";
            } else if (readBuf[0] == 12) {
                query = "C";
            } else if (readBuf[0] == 13) {
                query = "D";
            } else if (readBuf[0] == 16) {
                query = "10";
            } else if (readBuf[0] == 32) {
                query = "20";
            } else if (readBuf[0] == 128) {
                query = "80";
            }

            return query;
        } else {
            return "-1";
        }
    }

    private String qrcode(int x, int y, String ecc, String cell, String mode, String rotation, String model, String mask, String content) {
        String message = "QRCODE " + x + "," + y + "," + ecc + "," + cell + "," + mode + "," + rotation + "," + model + "," + mask + "," + "\"" + content + "\"" + "\r\n";
        byte[] msgBuffer = message.getBytes();
        if (this.OutStream != null && this.InStream != null) {
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
        if (this.OutStream != null && this.InStream != null) {
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
        String var3 = Environment.getExternalStorageDirectory().getPath();

        try {
            FileInputStream fis = new FileInputStream(Environment.getExternalStorageDirectory().getPath() + "/" + path + filename);
            byte[] data = new byte[fis.available()];
            int[] var6 = new int[data.length];

            while(fis.read(data) != -1) {
            }

            this.OutStream.write(data);
            fis.close();
            return "1";
        } catch (Exception var7) {
            return "-1";
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
        if (this.OutStream != null && this.InStream != null) {
            try {
                FileInputStream fis = new FileInputStream(path + filename);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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

    public String downloadfile(File file, String filename) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                FileInputStream fis = new FileInputStream(file);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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

    private String downloadfile(String path, String filename, String savename) {
        if (this.OutStream != null && this.InStream != null) {
            try {
                FileInputStream fis = new FileInputStream(path + filename);
                byte[] data = new byte[fis.available()];
                int[] FF = new int[data.length];
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
            } catch (Exception var10) {
                return "-1";
            }

            try {
                Thread.sleep(100L);
            } catch (InterruptedException var9) {
                var9.printStackTrace();
            }

            return "1";
        } else {
            return "-1";
        }
    }

    private String windowsfont(int x_coordinates, int y_coordinates, int fontsize, Typeface typeface, String textToPrint) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        Paint paint = new Paint();
        paint.setStyle(Style.FILL);
        paint.setColor(-16777216);
        paint.setAntiAlias(true);
        paint.setTypeface(typeface);
        paint.setTextSize((float)fontsize);
        TextPaint textpaint = new TextPaint(paint);
        StaticLayout staticLayout = new StaticLayout(textToPrint, textpaint, 832, Alignment.ALIGN_NORMAL, 1.0F, 0.0F, false);
        int height = staticLayout.getHeight();
        int width = (int)Layout.getDesiredWidth(textToPrint, textpaint);
        if (height > 2378) {
            height = 2378;
        }

        try {
            original_bitmap = Bitmap.createBitmap(width + 8, height, Config.RGB_565);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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

    private void sendpicture_halftone(int x_coordinates, int y_coordinates, String path) {
        Bitmap original_bitmap = null;
        Bitmap gray_bitmap = null;
        Bitmap binary_bitmap = null;
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        Options options = new Options();
        options.inPurgeable = true;
        options.inPreferredConfig = Config.ARGB_8888;

        try {
            Options.class.getField("inNativeAlloc").setBoolean(options, true);
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
        bmpGray = Bitmap.createBitmap(width, height, Config.RGB_565);
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
        linegray = image.copy(Config.ARGB_8888, true);

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
        binarymap = graymap.copy(Config.ARGB_8888, true);

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
        binarymap = graymap.copy(Config.ARGB_8888, true);

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
        this.sendcommand("NFC MODE OFF\r\n");
        this.sendcommand("NFC READ\r\n");

        try {
            Thread.sleep((long)delay);
        } catch (InterruptedException var3) {
            var3.printStackTrace();
        }

        try {
            if (this.InStream.available() > 0) {
                int var2 = this.InStream.read(readBuf);
            }
        } catch (IOException var4) {
            return "-1";
        }

        String nfcdata = new String(readBuf);
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

    private ArrayList<Bitmap> pdf_color(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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
        } catch (Exception var30) {
            var30.printStackTrace();
        }

        return bitmaps;
    }

    private ArrayList<Bitmap> pdf_color_resize(int x_axis, int y_axis, File f1, int resize_width, int resize_height) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                Bitmap resize_bitmap = Bitmap.createScaledBitmap(bitmap, resize_width, resize_height, false);
                page.render(resize_bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(resize_bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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

    private ArrayList<Bitmap> pdf_color_save(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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

    private ArrayList<Bitmap> pdf_gray(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 2);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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

    private ArrayList<Bitmap> pdf_gray_resize(int x_axis, int y_axis, File f1, int resize_width, int resize_height) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                Bitmap resize_bitmap = Bitmap.createScaledBitmap(bitmap, resize_width, resize_height, false);
                page.render(resize_bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(resize_bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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

    private ArrayList<Bitmap> pdf_gray_save(int x_axis, int y_axis, File f1) throws FileNotFoundException {
        ArrayList bitmaps = new ArrayList();

        try {
            PdfRenderer renderer = new PdfRenderer(ParcelFileDescriptor.open(f1, 268435456));
            int pageCount = renderer.getPageCount();
            int t = 0;
            if (t < pageCount) {
                Page page = renderer.openPage(t);
                int width = (int)((double)(page.getWidth() * 72) / 25.4D);
                int height = (int)((double)(page.getHeight() * 72) / 25.4D);
                Bitmap bitmap = Bitmap.createBitmap(width, height, Config.ARGB_8888);
                page.render(bitmap, (Rect)null, (Matrix)null, 1);
                bitmaps.add(bitmap);
                page.close();
                renderer.close();
                Bitmap gray_bitmap = null;
                Bitmap binary_bitmap = null;
                Paint paint = new Paint();
                paint.setStyle(Style.FILL);
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
}
