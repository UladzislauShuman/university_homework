#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    pen = new QPen();
    penPosition = new QPoint(0,0);
    pen->setColor(Qt::black);
}

MainWindow::~MainWindow()
{
    delete ui;
    delete pen;
    delete penPosition;
}
void MainWindow::on_openButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    ReadFile(this->data,file_name.toStdString());
    this->update();
}

void ReadFile(std::vector<int>& data_,const std::string& fileName)
{
    std::ifstream fin(fileName);
    int tempNum;
    while(fin >> tempNum)
        data_.push_back(tempNum);
}

void MainWindow::paintEvent(QPaintEvent *)
{
    if(this->data.empty())
        return;

    double y0;
    double k = (double)(this->width())/(*std::max_element(this->data.begin(),this->data.end()));
    int penWidth = (this->height())/(this->data.size());
    pen->setWidth(penWidth);

    QPainter painter(this);
    painter.begin(this);
    painter.setPen(*pen);

    y0 = penWidth / 2;
    for(int i = 0; i < this->data.size();++i){
        painter.drawLine(0,y0,this->data[i]*k,y0);
        y0 += penWidth;
    }

    painter.end();
}

