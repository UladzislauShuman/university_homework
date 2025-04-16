#include "tablewidget.h"

tableWidget::tableWidget(QWidget *parent)
    : QWidget{parent}
{


}

void tableWidget::SlotTakeField_fromMainWindow()
{
    emit SignalTakeField_toField();
}

void tableWidget::SlotTaleField_fromField(std::vector<QPair<int, int>> vector)
{
    //delete table,layout;
    this->table_vector = vector;
    table = new QTableWidget(vector.size(),2);
    layout = new QGridLayout();

    table->horizontalHeader()->setSectionResizeMode(QHeaderView::Stretch);
    table->verticalHeader()->setSectionResizeMode(QHeaderView::ResizeToContents);

    //table->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOn);

    table->setHorizontalHeaderLabels(QStringList() << "X" << "Y");
    for(int i = 0;i < vector.size();++i){
        QTableWidgetItem *X = new QTableWidgetItem(QString::number(vector[i].first));
        X->setTextAlignment(Qt::AlignCenter);
        QTableWidgetItem *Y = new QTableWidgetItem(QString::number(vector[i].second));
        Y->setTextAlignment(Qt::AlignCenter);
        table->setItem(i,0,X);
        table->setItem(i,1,Y);
    }
    layout->addWidget(table);
    this->setLayout(layout);
}
