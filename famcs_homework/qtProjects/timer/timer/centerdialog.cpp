#include "centerdialog.h"
#include "ui_centerdialog.h"

CenterDialog::CenterDialog(QPoint* center_,QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::CenterDialog)
    ,center(center_)
{
    ui->setupUi(this);

}

CenterDialog::~CenterDialog()
{
    delete ui;
}

void CenterDialog::on_applyButton_clicked()
{
    center->
}


void CenterDialog::on_closeButton_clicked()
{
    this->close();
}

