using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
///Exam 的摘要说明
/// </summary>
namespace System.Web
{
    public class Exam
    {
        private int getdata(string str, ref int[] a)
        {
            int count = 0;
            int p = 0;
            int len = str.Length;
            System.Text.StringBuilder builder = new System.Text.StringBuilder();
            for (; p < len; p++)
            {
                if (str[p] != ',')
                    builder.Append(str[p]);
                else
                {
                    a[count] = System.Convert.ToInt32(builder.ToString());
                    count++;
                    builder.Length = 0;
                }
            }
            return count;
        }
        private int[] stra;
        public string QAId
        {
            get
            {
                string temp = "";
                for (int i = 0; i < aCount; i++)
                {
                    temp = temp + stra[i].ToString() + ",";
                }
                return temp;
            }
        }
        private int[] strb;
        public string QBId
        {
            get
            {
                string temp = "";
                for (int i = 0; i < bCount; i++)
                {
                    temp = temp + strb[i].ToString() + ",";
                }
                return temp;
            }
        }
        private int[] amark;
        public string AMark
        {
            get
            {
                string temp = "";
                for (int i = 0; i < aCount; i++)
                    temp = temp + amark[i].ToString() + ",";
                return temp;
            }
        }
        private int[] bmark;
        public string BMark
        {
            get
            {
                string temp = "";
                for (int i = 0; i < bCount; i++)
                    temp = temp + bmark[i].ToString() + ",";
                return temp;
            }
        }
        private int a;
        public int aCount
        {
            get { return a; }
        }
        private int b;
        public int bCount
        {
            get { return b; }
        }
        public int aMark
        {
            get
            {
                int temp=0;
                for (int i = 0; i < a; i++)
                {
                    temp = temp + amark[i];
                }
                return temp;
            }
        }
        public int bMark
        {
            get
            {
                int temp = 0;
                for (int i = 0; i < b; i++)
                    temp = temp + bmark[i];
                return temp;
            }
        }
        public Exam()
        {
            stra = new int[1000];
            strb = new int[1000];
            amark = new int[1000];
            bmark = new int[1000];
            a = 0;
            b = 0;
        }
        public Exam(string AId, string BId, string AMark, string Bmark)
        {
            stra = new int[1000];
            strb = new int[1000];
            amark = new int[1000];
            bmark = new int[1000];
            a = this.getdata(AId, ref stra);
            b = this.getdata(BId, ref strb);
            this.getdata(AMark, ref amark);
            this.getdata(Bmark, ref bmark);
        }

        public void aAddId(int AId, int mark)
        {
            int k;
            if (a < 1000)
            {
                k = IsaIn(AId);
                if (k >= 0)
                {
                    if (amark[k] == mark)
                        return;
                    else
                        amark[k] = mark;
                }
                else
                {
                    stra[a] = AId;
                    amark[a] = mark;
                    a++;
                }
            }
            else
                throw new Exception("向试卷中添加选择题的数量超出最大允许值");
        }
        public void bAddId(int BId, int mark)
        {
            int k;
            if (b < 1000)
            {
                k = IsbIn(BId);
                if (k >= 0)
                {
                    if (bmark[k] == mark)
                        return;
                    else
                        bmark[k] = mark;
                }
                else
                {
                    strb[b] = BId;
                    bmark[b] = mark;
                    b++;
                }
            }
            else
                throw new Exception("向试卷中添加问答题的数量超出最大允许值");
        }
        public int GetaId(int i)
        {
            if (i < a)
            {
                return stra[i];
            }
            else
                throw new Exception("参数出界");
        }
        public int GetbId(int i)
        {
            if (i < b)
            {
                return strb[i];
            }
            else
                throw new Exception("参数出界");
        }
        public int GetaMark(int i)
        {
            if (i < a)
            {
                return amark[i];
            }
            else
                throw new Exception("参数出界");
        }
        public int GetbMark(int i)
        {
            if (i < b)
            {
                return bmark[i];
            }
            else
                throw new Exception("参数出界");
        }
        public int GetaMarkById(int aid)
        {
            int i = IsaIn(aid);
            if (i >= 0)
                return amark[i];
            else
                return -1;
        }
        public int GetbMarkById(int bid)
        {
            int i = IsbIn(bid);
            if (i >= 0)
                return bmark[i];
            else
                return -1;
        }
        public void Clear()
        {
            a = 0;
            b = 0;
        }
        public int IsaIn(int aid)
        {
            for (int i = 0; i < a; i++)
            {
                if (stra[i] == aid)
                    return i;
            }
            return -1;
        }
        public int IsbIn(int bid)
        {
            for (int i = 0; i < b; i++)
            {
                if (strb[i] == bid)
                    return i;
            }
            return -1;
        }
        public void removeA(int aid)
        {
            int i = IsaIn(aid);
            if (i >= 0)
            {
                for (int j = i; j < a; j++)
                {
                    stra[j] = stra[j + 1];
                    amark[j] = amark[j + 1];
                }
                a--;
            }
        }

        public void removeB(int bid)
        {
            int i = IsbIn(bid);
            if (i >= 0)
            {
                for (int j = i; j < b; j++)
                {
                    strb[j] = strb[j + 1];
                    bmark[j] = bmark[j + 1];
                }
                b--;
            }
        }
    }
}