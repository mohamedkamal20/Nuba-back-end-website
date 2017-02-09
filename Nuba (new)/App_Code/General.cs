using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for General
/// </summary>
public class General
{
    public General()
    {
    }
    public static string b64encode(string StrEncode)
    {
        string encodedString = "";
        encodedString = (Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes(StrEncode)));
        return encodedString;
    }
    public static Bitmap ResizeBitmap(Bitmap b, int nWidth, int nHeight)
    {
        Bitmap result = new Bitmap(nWidth, nHeight);
        using (Graphics g = Graphics.FromImage((System.Drawing.Image)result))
            g.DrawImage(b, 0, 0, nWidth, nHeight);
        return result;
    }
    public static string b64decode(string StrDecode)
    {
        string decodedString = "";
        decodedString = System.Text.ASCIIEncoding.ASCII.GetString(Convert.FromBase64String(StrDecode));
        return decodedString;
    }
}