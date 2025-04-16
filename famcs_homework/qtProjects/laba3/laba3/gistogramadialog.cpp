#include "gistogramadialog.h"
#include "ui_gistogramadialog.h"
/*

*/
GistogramaDialog::GistogramaDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::GistogramaDialog)
{
    ui->setupUi(this);
    pen = new QPen();
    color = Qt::black;
    penPosition = new QPoint(0,0);
    pen->setColor(color);
    flag = false;

}

GistogramaDialog::~GistogramaDialog()
{
    delete ui;
    delete pen;
    delete penPosition;
}

//чтение файла
void ReadFile(std::vector<int>& data_,const std::string& file_name)
{
    std::ifstream fin(file_name);
    int temp;
    while(fin >> temp){
        data_.push_back(temp);
    }
}
void GistogramaDialog::on_openButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    ReadFile(this->data,file_name.toStdString());
    this->update();
}

//рисование
void GistogramaDialog::paintEvent(QPaintEvent* event)
{
    if(this->data.empty())
        return;

    double x0;
    double k = (double)(this->height())/(*std::max_element(this->data.begin(),this->data.end()));
    int penWidth = (this->width())/(this->data.size());
    pen->setWidth(penWidth);

    QPainter painter(this);
    painter.begin(this);

    painter.setPen(*pen);
    x0 = penWidth / 2;
    for(int i = 0; i < this->data.size();++i){
        painter.drawLine(x0,0.0,x0,this->data[i]*k);
        x0 += penWidth;
    }
    painter.end();


}

