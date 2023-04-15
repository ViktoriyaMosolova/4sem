using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Drawing;
using System.Drawing.Design;
using System.Windows.Forms;
using Timer = System.Windows.Forms.Timer;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Graphics graphics;
            int FPS = 60;
            int player1y;

            int ballx;
            int bally;
            int ballspdx = 3;
            int ballspdy = 3;
        Timer timer = new Timer();
        //-------------------------------	
        public void MainForm()
            {
            
                
                InitializeComponent();
                timer.Enabled = true;
                timer.Interval = 1000 / FPS;
                timer.Tick += new EventHandler(TimerCallback);

                ballx = (int)Width / 2 - 10;
                bally = (int)Height / 2 - 10;
            }

            //Graphics
            void DrawRectangle(int x, int y, int w, int h, SolidBrush Color)
            {
                graphics.FillRectangle(Color, new System.Drawing.Rectangle(x, y, w, h));
            }

            void UpdateBall()
            {
                ballx += ballspdx;
                bally += ballspdy;

                if (ballx + 40 > this.Width)
                {
                    ballspdx = -ballspdx;
                }

                if (bally < 0 || bally + 40 > this.Height)
                {
                    ballspdy = -ballspdy;
                }

                if (IsCollided())
                {
                    ballspdx = -ballspdx;
                }

                if (ballx < 0)
                {
                    label1.Visibility = Visibility;
                    timer.Stop();
                }
            }

            bool IsCollided()
            {
                if (ballx < 20 && bally > player1y && bally < player1y + 130)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }

            void TimerCallback(object sender, EventArgs e)
            {
                DrawRectangle(0, player1y, 20, 130, new SolidBrush(System.Drawing.Color.Black));
                DrawRectangle(ballx, bally, 20, 20, new SolidBrush(System.Drawing.Color.Black));
                UpdateBall();

            InvalidateVisual();
                return;
            }

            //Control
            void MainFormPaint(object sender, PaintEventArgs e)
            {
                graphics.BeginContainer();
                DrawRectangle(0, player1y, 20, 130, new SolidBrush(System.Drawing.Color.Black));
                DrawRectangle(ballx, bally, 20, 20, new SolidBrush(System.Drawing.Color.Black));
            }

            void MainFormKeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
            {
                //MessageBox.Show(Convert.ToString(e.KeyValue));
                int key = e.KeyValue;
                if (key == 38)
                {
                    player1y -= 5;
                }

                if (key == 40)
                {
                    player1y += 5;
                }
            }
    }
}
