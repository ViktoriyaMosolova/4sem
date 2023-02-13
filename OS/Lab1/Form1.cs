using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Lab1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void textleftbutton(object sender, EventArgs e)
        {
            button1.Text = "Пришел";
            button2.Text = "Ушел";
        }

        private void textrightbutton(object sender, EventArgs e)
        {
            button2.Text = "Пришел";
            button1.Text = "Ушел";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string str;
            double num;
            str = textBox1.Text;
            num = Convert.ToDouble(str);
            num *= 2;
            textBox1.Text = num.ToString();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string str;
            double num;
            str = textBox1.Text;
            num = Convert.ToDouble(str);
            num /= 2;
            textBox1.Text = num.ToString();
        }
    }
}
