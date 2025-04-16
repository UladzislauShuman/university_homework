#include "windialog.h"
#include "ui_windialog.h"

WinDialog::WinDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::WinDialog)
{
    qDebug() << "WinDialog::WinDialog(QWidget)"<<Qt::endl;
    ui->setupUi(this);
}

WinDialog::~WinDialog()
{
    qDebug() << "WinDialog::~WinDialog()"<<Qt::endl;
    delete ui;
}

void WinDialog::takeMessage(QString message,bool result)
{
    qDebug() << "WinDialog::takeMessage(QString,bool)"<<Qt::endl;
    this->ui->resultLabel->setText(message);
    if(result == true){
        this->ui->nextButton->setStyleSheet("QPushButton { background-color: green }");
        emit SignalNext(true);
    }
    else{
        this->ui->nextButton->setStyleSheet("QPushButton { background-color: red }");
        emit SignalNext(false);
    }
    this->show();
    return;
}

void WinDialog::on_nextButton_clicked()
{
    qDebug() << "WinDialog::on_nextButton_clicked()"<<Qt::endl;
    emit SignalMakeNewField(true);
    this->close();
}

