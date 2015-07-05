using RestSharp;
using Newtonsoft.Json;
using System;
using System.IO.Ports;
using System.Windows.Forms;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        // 1st array of invisible button...
        private Button[] buttonFirst;
        private static string[] sButtonFirst = new String[] {"Fish", "Meat", "Vegetable" }; 
        private Panel pnlButtons = new Panel();

        // array of invisible buttons
        private Button[] buttonNew;
        private const int nButton = 9;
        
        // status panel
        private Label lblStatus;

        // serial port
        SerialPort ComPort = new SerialPort();

        public Form1()
        {
            int xPos, yPos;

            xPos = 50; yPos = 15;

            InitializeComponent();

            // create label 
            lblStatus = new Label();
            lblStatus.Top = 500;
            lblStatus.Left = 50;
            lblStatus.Width = this.Width - 100;
            lblStatus.Height = 100;
            this.Controls.Add(lblStatus);
            lblStatus.Visible = true;
            lblStatus.Text = "Please put the tag onto scale to continue...";

            // create the first buttons...
            buttonFirst = new Button[3];
            for (int i = 0; i < 3; i++)
            {
                buttonFirst[i] = new Button();
                buttonFirst[i].Tag = i+1;
                buttonFirst[i].Height = 75;
                buttonFirst[i].Width = 200;
                buttonFirst[i].Text = sButtonFirst[i];
                buttonFirst[i].Top = yPos;
                buttonFirst[i].Left = xPos;
                xPos += buttonFirst[i].Width;
                this.Controls.Add(buttonFirst[i]);
                buttonFirst[i].Visible = false;
                buttonFirst[i].Click += new System.EventHandler(ClickPrimaryButton);
            }

            xPos = yPos = 0;

            // create the panel
            pnlButtons.Location = new System.Drawing.Point(50, 100);
            pnlButtons.Name = "pnlButtons";
            pnlButtons.Size = new System.Drawing.Size(200*3, 75*3);
            this.Controls.Add(pnlButtons);

            // create invisible buttons...
            buttonNew = new Button[nButton];
            for (int i = 0; i < nButton; i++)
            {
                buttonNew[i] = new System.Windows.Forms.Button();
                buttonNew[i].Tag = i;
                buttonNew[i].Height = 75;
                buttonNew[i].Width = 200;
                buttonNew[i].Text = "123";
                buttonNew[i].Left = xPos;
                buttonNew[i].Top = yPos;
                xPos += buttonNew[i].Width;
                if ((i != 0) && (0 == (i % 3)))
                {
                    xPos = 0;
                    yPos += buttonNew[i].Height;
                    buttonNew[i].Left = xPos;
                    buttonNew[i].Top = yPos;
                }
                buttonNew[i].Visible = false;
                buttonNew[i].Click += new System.EventHandler(ClickSecondaryButton);
                pnlButtons.Controls.Add(buttonNew[i]);
            }

            // open COM port for communication
            ComPort.PortName = "COM5";
            ComPort.BaudRate = 115200;
            ComPort.DataBits = 8;
            ComPort.StopBits = StopBits.One;
            ComPort.Handshake = Handshake.None;
            ComPort.Parity = Parity.None;
            ComPort.DataReceived += new SerialDataReceivedEventHandler(serialPortDataReceivedHandler);
            ComPort.Open();
        }

       
        private static string SerialInputData;
        
        delegate void SetTextCallback(string[] text);
        private void setLblText(string[] text)
        {
            // InvokeRequired required compares the thread ID of the
            // calling thread to the thread ID of the creating thread.
            // If these threads are different, it returns true.
            if (this.lblStatus.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(setLblText);
                this.Invoke(d, new object[] { text });
            }
            else
            {
                lblStatus.Text = "RFID tag = " + text[0] + ", weight = " + text[1];
                
            }
        }

        delegate void setBtnVisibleCallback();
        private void setBtnVisible()
        {
            if (this.lblStatus.InvokeRequired)
            {
                setBtnVisibleCallback d = new setBtnVisibleCallback(setBtnVisible);
                this.Invoke(d, new object[] {  });
            }
            else
            {
                for (int i = 0; i < 3; i++)
                {
                    buttonFirst[i].Visible = true;
                }
            }
        }

        string currentID;
        int currentWeight;
        private void serialPortDataReceivedHandler(object sender, SerialDataReceivedEventArgs e)
        {
            SerialInputData += ComPort.ReadExisting();
            if ((SerialInputData != String.Empty) && (SerialInputData.EndsWith("\r\n")))
            {
                // TODO: enable choosing

                //update label
                string[] words = SerialInputData.Split(' ');

                SetTextCallback d = new SetTextCallback(setLblText);
                this.Invoke(d, new object[] { words });

                // try to query if the box is available
                RestClient client = new RestClient("http://45.63.71.76:2204");
                RestRequest request = new RestRequest("api/boxes/" + words[0], Method.GET);

                // execute the request
                IRestResponse response = client.Execute(request);
                string content = response.Content;
                
                // if already exist...
                if (System.Text.RegularExpressions.Regex.IsMatch(content, words[0], System.Text.RegularExpressions.RegexOptions.IgnoreCase))
                {
                    // if weight is too low, delete the box out of the system
                    int weight = Convert.ToInt32(words[1]) * 4;
                    if (weight < 80)
                    {
                        request = new RestRequest("api/boxes/" + words[0], Method.DELETE);
                        response = client.Execute(request);
                        content = response.Content;

                        if (!(content.Contains("deleted")))
                        {
                            // TODO: server error that cannot be fixed...
                            SerialInputData = String.Empty;
                            return;
                        }

                        SerialInputData = String.Empty;
                        return;
                    }

                    // send updated data
                    request = new RestRequest("api/boxes/" + words[0], Method.PUT);
                    
                    int startPos = content.IndexOf("foodName");
                    startPos += 11;
                    int endPos = content.Substring(startPos).IndexOf('\"');
                    string foodName = content.Substring(startPos,endPos);
                    request.AddParameter("rfidTag", words[0]);
                    request.AddParameter("foodName", foodName);
                    request.AddParameter("weight", weight);

                    response = client.Execute(request);

                    content = response.Content;

                    if (!(content.Contains("updated")))
                    {
                        // TODO: server error that cannot be fixed...
                        SerialInputData = String.Empty;
                        return;
                    }

                    SerialInputData = String.Empty;
                    return;
                }

                // not exist, trying to write a new data
                currentID = words[0];
                currentWeight = Convert.ToInt32(words[1]) * 4;
                // show up buttons
                setBtnVisibleCallback b = new setBtnVisibleCallback(setBtnVisible);
                this.Invoke(b, new object[] { });

                SerialInputData = String.Empty;
            }
        }

        public void ClickPrimaryButton(Object sender, System.EventArgs e)
        {
            Button btn = (Button)sender;
            int i = Convert.ToInt32(btn.Tag);
            btnUpdate(i);
        }

        public void ClickSecondaryButton(Object sender, System.EventArgs e)
        {
            Button btn = (Button)sender;

            // disable all button
            for (int i = 0; i < 3; i++)
            {
                buttonFirst[i].Visible = false;
            }

            for (int i = 0; i < nButton; i++)
            {
                buttonNew[i].Visible = false;
            }

            lblStatus.Text += ", item = " + btn.Text;

            RestClient client = new RestClient("http://45.63.71.76:2204");
            RestRequest request = new RestRequest("api/boxes" , Method.POST);

            request.AddHeader("Content-Type", "application/x-www-form-urlencoded");

            request.AddParameter("rfidTag", currentID);
            request.AddParameter("foodName", btn.Text);
            request.AddParameter("weight", currentWeight);

            IRestResponse response = client.Execute(request);

            string content = response.Content;
            if (!(content.Contains("Box created"))) 
            {
                // TODO: server error that cannot be fixed...
                return;
            }
        }

        private int tabActive;
        private static string[] s1 = new string[] { "Bat", "Mackerel", "Salmon", "Tuna" };
        private static string[] s2 = new string[] { "Chicken", "Beef", "Pork", "Lamb" };
        private static string[] s3 = new string[] { "Tomato", "Cucumber", "Carrot", "Potato" };

        private void btnUpdate(int ii)
        {
            int j = 0;
            tabActive = ii;

            // disable all button
            for (int i = 0; i < nButton; i++)
            {
                buttonNew[i].Visible = false;
            }

            string[] ss;
            switch (ii)
            {
                case 1: ss = s1; break;
                case 2: ss = s2; break;
                case 3: ss = s3; break;
                default: return;
            }
            foreach (string s in ss)
            {
                buttonNew[j].Text = s;
                buttonNew[j].Visible = true;
                j++;
            }
        }
    }
}
