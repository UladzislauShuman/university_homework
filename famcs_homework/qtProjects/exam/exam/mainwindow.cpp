#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->ui->tabWidget->setTabEnabled(0,false);
    this->ui->tabWidget->setTabEnabled(1,false);

    this->ui->tabWidget->setCurrentIndex(0);
    this->ui->fieldAction->setEnabled(false);

    this->ui->saveAction->setEnabled(false);
    this->fieldWidget = new FieldWidget();


    connect(this,&MainWindow::SignalFileName_toField,fieldWidget,&FieldWidget::SlotGetFileName_fromMainWindow);
    connect(this,&MainWindow::SignalColor_toField,fieldWidget,&FieldWidget::SlotGetColor_fromMainWindow);
    connect(this,&MainWindow::SignalIsFill_toField,fieldWidget,&FieldWidget::SlotIsFill_fromMainWindow);
    connect(this,&MainWindow::SignalPoint_toField,fieldWidget,&FieldWidget::SlotPoint_fromMainWindow);
    connect(this,&MainWindow::SignalClean_toField,fieldWidget,&FieldWidget::SlotClean_fromMainWindow);
    connect(this,&MainWindow::SignalToSave_toField,fieldWidget,&FieldWidget::SlotToSave_fromMainWindow);
    connect(this,&MainWindow::SignalGetBack_toField,fieldWidget,&FieldWidget::SlotGetBack_fromMainWindow);

    this->ui->tab1->layout()->addWidget(this->fieldWidget);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        QPair<int,int> pair;
        pair.first = event->x();
        pair.second = event->y();
        emit SignalPoint_toField(pair);
    }
}


void MainWindow::on_tableAction_triggered()
{
    this->ui->tabWidget->setCurrentIndex(1);
    this->ui->tableAction->setEnabled(false);
    this->ui->fieldAction->setEnabled(true);
    this->MakeTable();
}

void MainWindow::MakeTable()
{
    this->table = new tableWidget();

    connect(table,&tableWidget::SignalTakeField_toField,fieldWidget,&FieldWidget::SlotTakeField_fromTable);
    connect(fieldWidget,&FieldWidget::SignalVector_toTable,table,&tableWidget::SlotTaleField_fromField);

    connect(this,&MainWindow::SignalTakeField_toTable,table,&tableWidget::SlotTakeField_fromMainWindow);

    emit SignalTakeField_toTable();
    if(this->isTable == false){
        isTable = true;
    }
    else{
        QLayoutItem* item = this->ui->tab2->layout()->takeAt(1);
        item->widget()->deleteLater();
        delete item;
    }
    this->ui->tab2->layout()->addWidget(this->table);
}


void MainWindow::on_fieldAction_triggered()
{
    this->ui->tabWidget->setCurrentIndex(0);
    this->ui->fieldAction->setEnabled(false);
    this->ui->tableAction->setEnabled(true);
}


void MainWindow::on_openAction_triggered()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    //QFile file(file_name);
    if(!file_name.isEmpty()){
        this->current_file_name = file_name;
        this->ui->saveAction->setEnabled(true);
        emit SignalFileName_toField(file_name);
    }
}


void MainWindow::on_colorAction_triggered()
{
    emit SignalColor_toField(QColorDialog::getColor());
}


void MainWindow::on_fillAction_triggered()
{
    this->isFill = !this->isFill;
    if(this->isFill == true){
        this->ui->fillAction->setText("Заливка (да)");
    }
    else{
        this->ui->fillAction->setText("Заливка (нет)");
    }
    emit SignalIsFill_toField(this->isFill);
}


void MainWindow::on_saveAction_triggered()
{
    emit SignalToSave_toField(this->current_file_name);
}


void MainWindow::on_saveHowAction_triggered()
{
    QString file_name = QFileDialog::getSaveFileName(0,"Open dialog","","*.txt");
    if(this->current_file_name.isEmpty()){
        this->current_file_name = file_name;
    }
    emit SignalToSave_toField(file_name);
}


void MainWindow::on_cleanAction_triggered()
{
    emit SignalClean_toField();
}


void MainWindow::on_GetBackAction_triggered()
{
    emit SignalGetBack_toField();
}



