#include "fieldwidget.h"

FieldWidget::FieldWidget(QWidget *parent)
    : QWidget{parent}
{
    label = new QLabel("LOL");
    label->setAlignment(Qt::AlignCenter);
    layout = new QGridLayout();
    layout->addWidget(label);
    this->setLayout(this->layout);

    pen = new QPen();
}

void FieldWidget::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    if(this->field.empty()){
        painter.begin(this);
        painter.end();
        return;
    }
    //QPainter painter(this);

    painter.begin(this);
        this->PrintFrield(painter);
    painter.end();
}

// void FieldWidget::mousePressEvent(QMouseEvent *event)
// {
//     if (event->button() == Qt::LeftButton) {
//         QPair<int,int> pair;
//         pair.first = event->x();
//         pair.second = event->y();
//         this->field.push_back(pair);
//         this->update();
//     }
// }


void FieldWidget::PrintFrield(QPainter& painter)
{
    pen->setColor(current_color);
    pen->setWidth(10);
    painter.setPen(*this->pen);

    QPainterPath path;
    path.moveTo(QPointF(this->field[0].first,this->field[0].second));
    for(int i = 1;i < this->field.size();++i){
        path.lineTo(QPointF(this->field[i].first,this->field[i].second));
    }
    painter.drawPath(path);
    if(this->isFill == true){
        painter.fillPath(path,QBrush(current_color));
    }
}


void FieldWidget::SlotGetFileName_fromMainWindow(QString file_name)
{
    this->Clear();
    QFile file(file_name);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Не удалось открыть файл для чтения";
        return;
    }
    QTextStream in(&file);
    while(!in.atEnd()){
        QString tempQString = in.readLine();
        QStringList tempList = tempQString.split(" ");
        QPair<int,int> tempPair;
        tempPair.first = tempList[0].toInt();
        tempPair.second = tempList[1].toInt();
        field.push_back(tempPair);
    }
}

void FieldWidget::SlotGetColor_fromMainWindow(QColor color)
{
    this->current_color = color;
    this->update();
}

void FieldWidget::SlotIsFill_fromMainWindow(bool isFill_)
{
    this->isFill = isFill_;
    this->update();
}

void FieldWidget::SlotPoint_fromMainWindow(QPair<int, int> pair)
{
    this->field.push_back(pair);
    this->update();
}

void FieldWidget::SlotClean_fromMainWindow()
{
    this->Clear();
}

void FieldWidget::SlotToSave_fromMainWindow(QString file_name)
{
    QFile file(file_name);
    if(file.open(QIODevice::WriteOnly|QIODevice::Truncate)){
        QTextStream out(&file);
        for(int i = 0;i < this->field.size();++i){
            out << field[i].first << " " << field[i].second << Qt::endl;
        }
        file.close();
    }
}

void FieldWidget::SlotGetBack_fromMainWindow()
{
    // if(this->amount_of_pressing != 0){
    //     this->field.pop_back();
    //     this->update();
    // }

    this->field.pop_back();
    this->update();
}

void FieldWidget::SlotTakeField_fromTable()
{
    emit SignalVector_toTable(field);
}
