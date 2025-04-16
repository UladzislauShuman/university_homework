#include "searchdialog.h"
#include "ui_searchdialog.h"

SearchDialog::SearchDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SearchDialog)
{
    ui->setupUi(this);
    ui->output->setReadOnly(true);
}

SearchDialog::~SearchDialog()
{
    delete ui;
}

void SearchDialog::takeVector(std::vector<radioitem>& vec)
{
    currentVector = vec;
}

void SearchDialog::on_findButton_clicked()
{
    radioitem item(ui->editType->text().toStdString(),
                   ui->editCompany->text().toStdString(),
                   ui->editDateStart->text().toStdString(),
                   ui->editDateEnd->text().toStdString(),
                   true
                   );

    std::string result = "";
    for(auto a = currentVector.begin();a != currentVector.end();++a){
        if((item.Type() == a->Type() or item.Type() == "") and
            (item.Company() == a->Company() or item.Company() == "") and
            (item.DateStart() == a->DateStart() or item.DateStart() == "") and
            (item.DateEnd() == a->DateEnd() or item.DateEnd() == "")){
            result += (*a).to_string();
        }
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void SearchDialog::on_closeButton_clicked()
{
    ui->editType->clear();
    ui->editCompany->clear();
    ui->editDateStart->clear();
    ui->editDateEnd->clear();
    ui->output->clear();
    this->close();
}

